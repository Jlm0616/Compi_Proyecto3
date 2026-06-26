import java.io.*;
import java.util.*;
import java.util.regex.*;

public class GeneradorMIPS {

    static LinkedHashMap<String, String> simbolosGlobales = new LinkedHashMap<>();
    static LinkedHashMap<String, Integer> arreglos = new LinkedHashMap<>();
    static LinkedHashMap<String, Integer> arregloColumnas = new LinkedHashMap<>();
    static LinkedHashMap<String, String> stringsLiterales = new LinkedHashMap<>();
    static int contadorStrings = 0;
    static int contadorCmp = 0;
    static int contadorPow = 0;
    static List<String> lineas3D = new ArrayList<>();
    static Map<String, String> renombrados = new HashMap<>();

    static LinkedHashMap<String, LinkedHashMap<String, Integer>> localesPorFuncion = new LinkedHashMap<>();
    static LinkedHashMap<String, Integer> frameSizePorFuncion = new LinkedHashMap<>();
    static LinkedHashMap<String, Integer> frameTotalPorFuncion = new LinkedHashMap<>();

    static String funcionActual = null;
    static boolean dentroDeFuncion = false;
    static List<String> parametrosPendientes = new ArrayList<>();

    // ===============================================================
    // ACCESO A MEMORIA 
    // ===============================================================

    static String store(String reg, String var) {
        if (dentroDeFuncion && funcionActual != null) {
            LinkedHashMap<String, Integer> loc = localesPorFuncion.get(funcionActual);
            if (loc != null && loc.containsKey(var)) {
                int offset = loc.get(var);
                return "sw " + reg + ", " + offset + "($sp)\n";
            }
        }
        return "la $t9, " + var + "\nsw " + reg + ", 0($t9)\n";
    }

    static String storeF(String reg, String var) {
        if (dentroDeFuncion && funcionActual != null) {
            LinkedHashMap<String, Integer> loc = localesPorFuncion.get(funcionActual);
            if (loc != null && loc.containsKey(var)) {
                int offset = loc.get(var);
                return "s.s " + reg + ", " + offset + "($sp)\n";
            }
        }
        return "la $t9, " + var + "\ns.s " + reg + ", 0($t9)\n";
    }

    static String load(String reg, String var) {
        if (esLitInt(var)) return "li " + reg + ", " + var + "\n";
        if (dentroDeFuncion && funcionActual != null) {
            LinkedHashMap<String, Integer> loc = localesPorFuncion.get(funcionActual);
            if (loc != null && loc.containsKey(var)) {
                int offset = loc.get(var);
                return "lw " + reg + ", " + offset + "($sp)\n";
            }
        }
        return "la $t9, " + var + "\nlw " + reg + ", 0($t9)\n";
    }

    static String loadF(String reg, String var) {
        if (esLitFloat(var)) return "li.s " + reg + ", " + var + "\n";
        if (dentroDeFuncion && funcionActual != null) {
            LinkedHashMap<String, Integer> loc = localesPorFuncion.get(funcionActual);
            if (loc != null && loc.containsKey(var)) {
                int offset = loc.get(var);
                return "l.s " + reg + ", " + offset + "($sp)\n";
            }
        }
        return "la $t9, " + var + "\nl.s " + reg + ", 0($t9)\n";
    }

    // ===============================================================
    // UTILIDADES
    // ===============================================================

    static boolean esLitInt(String s) { return s.matches("-?\\d+"); }
    static boolean esLitFloat(String s) { return s.matches("-?\\d+\\.\\d+([eE][+-]?\\d+)?"); }
    static boolean esLit(String s) { return esLitInt(s) || esLitFloat(s); }

    static boolean esFloat(String op) {
        if (simbolosGlobales.containsKey(op)) {
            String tipo = simbolosGlobales.get(op);
            return tipo.equals("float") || tipo.equals("float[]");
        }
        return esLitFloat(op);
    }

    static boolean esBool(String op) {
        if (simbolosGlobales.containsKey(op)) {
            return simbolosGlobales.get(op).equals("bool");
        }
        return false;
    }

    static String tipoDe(String op) {
        if (simbolosGlobales.containsKey(op)) {
            String tipo = simbolosGlobales.get(op);
            if (tipo.endsWith("[]")) return tipo.substring(0, tipo.length() - 2);
            return tipo;
        }
        if (esLitFloat(op)) return "float";
        if (esLitInt(op)) return "int";
        if (op.matches("(true|false)")) return "bool";
        return "int";
    }

    static boolean esArreglo(String var) {
        return simbolosGlobales.containsKey(var) && simbolosGlobales.get(var).endsWith("[]");
    }

    // ===============================================================
    // RENOMBRADO
    // ===============================================================

    static final Set<String> MIPS_KW = new HashSet<>(Arrays.asList(
        "b","j","jr","jal","jalr","la","li","lw","sw","lb","sb","lh","sh",
        "l.s","s.s","l.d","s.d","li.s","li.d","lui","move","mfhi","mflo","mfc1","mtc1",
        "add","addu","addi","addiu","sub","subu","mul","mult","multu","div","divu","neg","negu",
        "and","andi","or","ori","xor","xori","nor","not","sll","srl","sra","rem","abs",
        "add.s","sub.s","mul.s","div.s","neg.s","abs.s","add.d","sub.d","mul.d","div.d","neg.d","abs.d",
        "mov.s","mov.d","cvt.s.w","cvt.w.s","cvt.d.w","cvt.w.d",
        "slt","slti","sltu","sltiu","sle","sgt","sge","seq","sne",
        "beq","bne","blt","ble","bgt","bge","beqz","bnez","bltz","blez","bgtz","bgez",
        "c.lt.s","c.le.s","c.eq.s","c.lt.d","c.le.d","c.eq.d","bc1t","bc1f",
        "syscall","nop","break","trap","eret",
        "data","text","word","asciiz","ascii","byte","float","double",
        "globl","ent","end","space","align","extern"
    ));

    static String safe(String name) {
        if (renombrados.containsKey(name)) return renombrados.get(name);
        String s = (!name.startsWith("__") && MIPS_KW.contains(name.toLowerCase())) ? "var_" + name : name;
        renombrados.put(name, s);
        return s;
    }

    static void renombrar() {
        Set<String> names = new LinkedHashSet<>();
        for (String l : lineas3D) {
            if (l.startsWith("declare ")) names.add(l.substring("declare ".length()).split(",",2)[0].trim());
            else if (l.startsWith("param "))  names.add(l.substring("param ".length()).split(",",2)[0].trim());
        }
        for (String n : names) safe(n);
        if (renombrados.entrySet().stream().noneMatch(e -> !e.getKey().equals(e.getValue()))) return;
        List<String> fixed = new ArrayList<>();
        for (String l : lineas3D) fixed.add(renombrarLinea(l));
        lineas3D.clear(); lineas3D.addAll(fixed);
    }

    static String renombrarLinea(String l) {
        StringBuilder sb = new StringBuilder();
        Matcher m = Pattern.compile("\"[^\"]*\"|[^\"]+").matcher(l);
        while (m.find()) {
            String p = m.group();
            if (p.startsWith("\"")) { sb.append(p); continue; }
            for (Map.Entry<String,String> e : renombrados.entrySet()) {
                if (!e.getKey().equals(e.getValue()))
                    p = p.replaceAll("\\b" + Pattern.quote(e.getKey()) + "\\b", e.getValue());
            }
            sb.append(p);
        }
        return sb.toString();
    }

    // ===============================================================
    // PUNTO DE ENTRADA
    // ===============================================================

    public static void main(String[] args) {
        if (args.length < 1) { System.out.println("Uso: java GeneradorMIPS <archivo.txt>"); return; }
        try {
            String in = args[0], out = in.replaceAll("\\.[^.]+$","") + ".asm";
            generar(in, out);
            System.out.println("Generado: " + out);
        } catch (IOException e) { System.out.println("Error: " + e.getMessage()); }
    }

    static String generar(String inp, String outp) throws IOException {
        simbolosGlobales.clear(); arreglos.clear(); arregloColumnas.clear();
        stringsLiterales.clear(); lineas3D.clear(); renombrados.clear();
        localesPorFuncion.clear(); frameSizePorFuncion.clear(); frameTotalPorFuncion.clear();
        contadorStrings=0; contadorCmp=0; contadorPow=0;
        funcionActual=null; dentroDeFuncion=false; parametrosPendientes.clear();

        leer(inp); renombrar(); primeraPasada();

        StringBuilder asm = new StringBuilder();
        asm.append(generarData());
        asm.append(".text\n.globl main\n");
        asm.append(segundaPasada());

        BufferedWriter bw = new BufferedWriter(new FileWriter(outp));
        bw.write(asm.toString()); bw.close();
        return outp;
    }

    // ===============================================================
    // PRIMERA PASADA
    // ===============================================================

    static void primeraPasada() {
        String funcActual = null;

        for (String linea : lineas3D) {

            if (linea.endsWith(":") && !linea.contains(" ") && !linea.contains("=")) {
                String etq = linea.substring(0, linea.length()-1);
                if (!etq.equals("main") && !etq.startsWith("_") && !etq.startsWith("L")) {
                    funcActual = etq;
                    localesPorFuncion.put(etq, new LinkedHashMap<>());
                    frameSizePorFuncion.put(etq, 0);
                } else {
                    if (etq.equals("main")) funcActual = "main";
                }
                continue;
            }

            if (linea.startsWith("declare ")) {
                String[] p = linea.substring("declare ".length()).split(",",2);
                String nombre = p[0].trim(), tipo = p[1].trim();
                if (tipo.contains("[")) {
                    String tipoBase = tipo.substring(0, tipo.indexOf('['));
                    Matcher m = Pattern.compile("\\[(\\d+)\\]\\[(\\d+)\\]").matcher(tipo);
                    if (m.find()) {
                        arreglos.put(nombre, Integer.parseInt(m.group(1))*Integer.parseInt(m.group(2)));
                        arregloColumnas.put(nombre, Integer.parseInt(m.group(2)));
                        simbolosGlobales.put(nombre, tipoBase+"[]");
                    }
                } else {
                    if (!simbolosGlobales.containsKey(nombre)) simbolosGlobales.put(nombre, tipo);
                    agregarLocal(funcActual, nombre);
                }
                continue;
            }

            if (linea.startsWith("param ")) {
                String[] p = linea.substring("param ".length()).split(",",2);
                String nombre = p[0].trim(), tipo = p[1].trim();
                if (!simbolosGlobales.containsKey(nombre)) simbolosGlobales.put(nombre, tipo);
                agregarLocal(funcActual, nombre);
                continue;
            }

            Matcher ms = Pattern.compile("\"([^\"]*)\"").matcher(linea);
            if (ms.find()) {
                String c = ms.group(1);
                if (!stringsLiterales.containsKey(c)) stringsLiterales.put(c, "str"+(contadorStrings++));
            }

            Matcher ma = Pattern.compile("^(\\w+)\\s*=").matcher(linea);
            if (ma.find()) {
                String nombre = ma.group(1);
                if (!simbolosGlobales.containsKey(nombre)) {
                    String rhs = linea.substring(linea.indexOf('=')+1).trim();
                    String tipo;
                    if (rhs.matches("\"(.*)\"")) tipo = "string";
                    else if (rhs.matches("(true|false)")) tipo = "bool";
                    else if (rhs.matches("'.'")) tipo = "char";
                    else if (esLitFloat(rhs)) tipo = "float";
                    else tipo = nombre.startsWith("__f") ? "float" : "int";
                    simbolosGlobales.put(nombre, tipo);
                }
                agregarLocal(funcActual, nombre);
            }
        }

        if (!frameSizePorFuncion.containsKey("main")) {
            frameSizePorFuncion.put("main", 0);
        }
        for (Map.Entry<String,Integer> e : frameSizePorFuncion.entrySet()) {
            int total = 32 + e.getValue();
            if (total % 8 != 0) total += 4;
            frameTotalPorFuncion.put(e.getKey(), total);
        }
    }

    static void agregarLocal(String func, String nombre) {
        if (func == null || func.equals("main")) return;
        if (!localesPorFuncion.containsKey(func)) return;
        LinkedHashMap<String,Integer> loc = localesPorFuncion.get(func);
        if (loc.containsKey(nombre)) return;
        int fs = frameSizePorFuncion.get(func);
       
        loc.put(nombre, (fs+4));
        frameSizePorFuncion.put(func, fs+4);
    }

    // ===============================================================
    // SEGUNDA PASADA 
    // ===============================================================

    static String segundaPasada() {
        StringBuilder sb = new StringBuilder();
        dentroDeFuncion = false; funcionActual = null; parametrosPendientes.clear();
        int paramIdx = 0;
        boolean mainProcesado = false;

        for (String linea : lineas3D) {

            if (linea.startsWith("declare ")) continue;

            // ETIQUETAS
            if (linea.endsWith(":") && !linea.contains(" ") && !linea.contains("=")) {
                String etq = linea.substring(0, linea.length()-1);
                
                if (etq.equals("main")) {
                    if (!mainProcesado) {
                        dentroDeFuncion = true;
                        funcionActual = "main";
                        int total = frameTotalPorFuncion.getOrDefault("main", 32);
                        sb.append("main:\n");
                        sb.append("subu $sp, $sp, ").append(total).append("\n");
                        sb.append("sw $ra, ").append(total-4).append("($sp)\n");
                       
                        mainProcesado = true;
                    } else {
                        sb.append("# main duplicado ignorado\n");
                    }
                    continue;
                }
                
                if (!etq.equals("main") && !etq.startsWith("_") && !etq.startsWith("L")) {
                    dentroDeFuncion = true; funcionActual = etq; paramIdx = 0;
                    parametrosPendientes.clear();
                    int total = frameTotalPorFuncion.getOrDefault(etq, 32);
                    sb.append(etq).append(":\n");
                    sb.append("subu $sp, $sp, ").append(total).append("\n");
                    sb.append("sw $ra, ").append(total-4).append("($sp)\n");
                } else {
                    sb.append(linea).append("\n");
                }
                continue;
            }

            // PARAM
            Matcher mParam = Pattern.compile("^param\\s+(\\S+),\\s*(\\S+)$").matcher(linea);
            if (mParam.matches()) {
                String nombre = mParam.group(1), tipo = mParam.group(2);
                simbolosGlobales.put(nombre, tipo);
                if (tipo.equals("float")) {
                    String rf;
                    if (paramIdx == 0) rf = "$f12";
                    else if (paramIdx == 1) rf = "$f14";
                    else if (paramIdx == 2) rf = "$f16";
                    else rf = "$f18";
                    sb.append(storeF(rf, nombre));
                } else if (paramIdx <= 3) {
                    sb.append(store("$a"+paramIdx, nombre));
                }
                paramIdx++;
                continue;
            }

            // ARG
            Matcher mArg = Pattern.compile("^arg\\s+(\\S+),\\s*(\\S+)$").matcher(linea);
            if (mArg.matches()) {
                String arg = mArg.group(1), tipo = mArg.group(2);
                int idx = parametrosPendientes.size();
                parametrosPendientes.add(arg);
                if (tipo.equals("float")) {
                    String reg;
                    if (idx == 0) reg = "$f12";
                    else if (idx == 1) reg = "$f14";
                    else if (idx == 2) reg = "$f16";
                    else reg = "$f18";
                    sb.append(loadF(reg, arg));
                } else if (simbolosGlobales.getOrDefault(arg,"").contains("[]")) {
                    if (idx <= 3) sb.append("la $a"+idx+", "+arg+"\n");
                } else if (idx <= 3) {
                    sb.append(load("$a"+idx, arg));
                }
                continue;
            }

            // ARREGLO ESCRITURA
            Matcher mAS = Pattern.compile("^(\\w+)\\[(.+)\\]\\[(.+)\\]\\s*=\\s*(\\S+)$").matcher(linea);
            if (mAS.matches()) {
                String arr=mAS.group(1), i1=mAS.group(2), i2=mAS.group(3), val=mAS.group(4);
                int cols = arregloColumnas.getOrDefault(arr,1);
                String tipoArr = simbolosGlobales.getOrDefault(arr, "int[]");
                boolean esFloatArr = tipoArr.startsWith("float");
                
                sb.append(esLitInt(i1)?"li $t8, "+i1+"\n":load("$t8",i1));
                sb.append("li $t9, ").append(cols).append("\nmul $t8, $t8, $t9\n");
                sb.append(esLitInt(i2)?"li $t9, "+i2+"\n":load("$t9",i2));
                sb.append("add $t8, $t8, $t9\nsll $t8, $t8, 2\nla $t9, ").append(arr).append("\nadd $t8, $t9, $t8\n");
                
              
                if (esFloatArr || esFloat(val)) {
                    sb.append(loadF("$f0",val));
                    sb.append("s.s $f0, 0($t8)\n");
                } else {
                    sb.append(esLitInt(val)?"li $t0, "+val+"\n":load("$t0",val));
                    sb.append("sw $t0, 0($t8)\n");
                }
                continue;
            }

            // ARREGLO LECTURA 
            Matcher mAG = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)\\[(.+)\\]\\[(.+)\\]$").matcher(linea);
            if (mAG.matches()) {
                String dest=mAG.group(1), arr=mAG.group(2), i1=mAG.group(3), i2=mAG.group(4);
                int cols = arregloColumnas.getOrDefault(arr,1);
                String tipoArr = simbolosGlobales.getOrDefault(arr, "int[]");
                boolean esFloatArr = tipoArr.startsWith("float");
                boolean destEsFloat = esFloat(dest);
                
                sb.append(esLitInt(i1)?"li $t8, "+i1+"\n":load("$t8",i1));
                sb.append("li $t9, ").append(cols).append("\nmul $t8, $t8, $t9\n");
                sb.append(esLitInt(i2)?"li $t9, "+i2+"\n":load("$t9",i2));
                sb.append("add $t8, $t8, $t9\nsll $t8, $t8, 2\nla $t9, ").append(arr).append("\nadd $t8, $t9, $t8\n");
                
               
                if (esFloatArr) {
                    sb.append("l.s $f0, 0($t8)\n");
                    if (destEsFloat) {
                        sb.append(storeF("$f0",dest));
                    } else {
                        // Convertir float a int para destino entero
                        sb.append("cvt.w.s $f0, $f0\n");
                        sb.append("mfc1 $t0, $f0\n");
                        sb.append(store("$t0",dest));
                    }
                } else {
                    sb.append("lw $t0, 0($t8)\n");
                    if (destEsFloat) {
                        // Convertir int a float para destino float
                        sb.append("mtc1 $t0, $f0\n");
                        sb.append("cvt.s.w $f0, $f0\n");
                        sb.append(storeF("$f0",dest));
                    } else {
                        sb.append(store("$t0",dest));
                    }
                }
                continue;
            }
            
            // LITERAL NUMERICO
            Matcher mLit = Pattern.compile("^([\\w_]+)\\s*=\\s*(-?\\d+(\\.\\d+)?)$").matcher(linea);
            if (mLit.matches()) {
                String dest=mLit.group(1), val=mLit.group(2);
                if (val.contains(".")||esFloat(dest)) { 
                    sb.append("li.s $f0, ").append(val).append("\n"); 
                    sb.append(storeF("$f0",dest)); 
                } else { 
                    sb.append("li $t0, ").append(val).append("\n"); 
                    sb.append(store("$t0",dest)); 
                }
                continue;
            }

            // BOOLEANO
            Matcher mB = Pattern.compile("^(\\w+)\\s*=\\s*(true|false)$").matcher(linea);
            if (mB.matches()) {
                String dest = mB.group(1);
                String tipoDest = tipoDe(dest);
                int valor = mB.group(2).equals("true") ? 1 : 0;
                
                //Guardar bool como int (0/1), no como float
                sb.append("li $t0, ").append(valor).append("\n");
                // Si el destino es float por error, convertir
                if (tipoDest.equals("float")) {
                    sb.append("mtc1 $t0, $f0\n");
                    sb.append("cvt.s.w $f0, $f0\n");
                    sb.append(storeF("$f0",dest));
                } else {
                    sb.append(store("$t0",dest));
                }
                continue;
            }

            // CARACTER
            Matcher mC = Pattern.compile("^(\\w+)\\s*=\\s*'(.)'$").matcher(linea);
            if (mC.matches()) {
                sb.append("li $t0, ").append((int)mC.group(2).charAt(0)).append("\n");
                sb.append(store("$t0",mC.group(1))); continue;
            }

            // STRING
            Matcher mS = Pattern.compile("^(\\w+)\\s*=\\s*\"(.*)\"$").matcher(linea);
            if (mS.matches()) {
                String etq = stringsLiterales.get(mS.group(2));
                sb.append("la $t0, ").append(etq).append("\n");
                sb.append(store("$t0",mS.group(1))); continue;
            }

            
            Matcher mCop = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)$").matcher(linea);
            if (mCop.matches()) {
                String dest=mCop.group(1), src=mCop.group(2);
                String tipoDest = tipoDe(dest);
                String tipoSrc = tipoDe(src);
                
                // Si ambos son float, copia float
                if (esFloat(dest) && esFloat(src)) {
                    sb.append(loadF("$f0",src));
                    sb.append(storeF("$f0",dest));
                }
                // Si destino es float y origen es int/bool, convertir
                else if (esFloat(dest) && !esFloat(src)) {
                    sb.append(load("$t0",src));
                    sb.append("mtc1 $t0, $f0\n");
                    sb.append("cvt.s.w $f0, $f0\n");
                    sb.append(storeF("$f0",dest));
                }
                // Si destino es int y origen es float, convertir
                else if (!esFloat(dest) && esFloat(src)) {
                    sb.append(loadF("$f0",src));
                    sb.append("cvt.w.s $f0, $f0\n");
                    sb.append("mfc1 $t0, $f0\n");
                    sb.append(store("$t0",dest));
                }
                // Ambos enteros
                else {
                    sb.append(load("$t0",src));
                    sb.append(store("$t0",dest));
                }
                continue;
            }

            // ===========================================================
            // INCREMENTO (++)
            // ===========================================================
            Matcher mInc = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)\\s*\\+\\s*1$").matcher(linea);
            if (mInc.matches()) {
                String dest = mInc.group(1);
                String src = mInc.group(2);
                if (esFloat(dest) || esFloat(src)) {
                    sb.append(loadF("$f0", src));
                    sb.append("li.s $f1, 1.0\n");
                    sb.append("add.s $f0, $f0, $f1\n");
                    sb.append(storeF("$f0", dest));
                } else {
                    sb.append(load("$t0", src));
                    sb.append("addi $t0, $t0, 1\n");
                    sb.append(store("$t0", dest));
                }
                continue;
            }

            // ===========================================================
            // DECREMENTO (--)
            // ===========================================================
            Matcher mDec = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)\\s*-\\s*1$").matcher(linea);
            if (mDec.matches()) {
                String dest = mDec.group(1);
                String src = mDec.group(2);
                if (esFloat(dest) || esFloat(src)) {
                    sb.append(loadF("$f0", src));
                    sb.append("li.s $f1, 1.0\n");
                    sb.append("sub.s $f0, $f0, $f1\n");
                    sb.append(storeF("$f0", dest));
                } else {
                    sb.append(load("$t0", src));
                    sb.append("addi $t0, $t0, -1\n");
                    sb.append(store("$t0", dest));
                }
                continue;
            }

            // GOTO
            Matcher mG = Pattern.compile("^goto\\s+(\\S+)$").matcher(linea);
            if (mG.matches()) { sb.append("j ").append(mG.group(1)).append("\n"); continue; }

            // IF FALSE GOTO
            Matcher mIF = Pattern.compile("^ifFalse\\s+(\\S+)\\s+goto\\s+(\\S+)$").matcher(linea);
            if (mIF.matches()) { 
                String cond = mIF.group(1);
                //  Cargar bool como int
                sb.append(load("$t0",cond)); 
                sb.append("beq $t0, $zero, ").append(mIF.group(2)).append("\n"); 
                continue; 
            }

            // IF TRUE GOTO
            Matcher mIT = Pattern.compile("^if\\s+(\\S+)\\s+goto\\s+(\\S+)$").matcher(linea);
            if (mIT.matches()) { 
                String cond = mIT.group(1);
                // Cargar bool como int
                sb.append(load("$t0",cond)); 
                sb.append("bne $t0, $zero, ").append(mIT.group(2)).append("\n"); 
                continue; 
            }

            // RELACIONALES -  resultado siempre int (0/1)
            Matcher mR = Pattern.compile("^(\\w+)\\s*=\\s*(\\S+)\\s*(<=|>=|==|!=|<|>)\\s*(\\S+)$").matcher(linea);
            if (mR.matches()) {
                String dest=mR.group(1), op1=mR.group(2), oper=mR.group(3), op2=mR.group(4);
                if (esFloat(op1)||esFloat(op2)) {
                    sb.append(loadF("$f1",op1)); sb.append(loadF("$f2",op2));
                    String ef = "_cmp"+(contadorCmp++);
                    switch(oper) {
                        case "<": sb.append("c.lt.s $f1, $f2\n"); break;
                        case "<=": sb.append("c.le.s $f1, $f2\n"); break;
                        case ">": sb.append("c.lt.s $f2, $f1\n"); break;
                        case ">=": sb.append("c.le.s $f2, $f1\n"); break;
                        case "==": sb.append("c.eq.s $f1, $f2\n"); break;
                        case "!=": sb.append("c.eq.s $f1, $f2\n"); break;
                    }
                    sb.append("li $t0, 0\n");
                    sb.append(oper.equals("!=")?"bc1t ":"bc1f ").append(ef).append("\n");
                    sb.append("li $t0, 1\n").append(ef).append(":\n");
                    // Guardar como int siempre
                    sb.append(store("$t0",dest));
                } else {
                    sb.append(esLitInt(op1)?"li $t1, "+op1+"\n":load("$t1",op1));
                    sb.append(esLitInt(op2)?"li $t2, "+op2+"\n":load("$t2",op2));
                    switch(oper) {
                        case "<": sb.append("slt $t0, $t1, $t2\n"); break;
                        case "<=": sb.append("sle $t0, $t1, $t2\n"); break;
                        case ">": sb.append("sgt $t0, $t1, $t2\n"); break;
                        case ">=": sb.append("sge $t0, $t1, $t2\n"); break;
                        case "==": sb.append("seq $t0, $t1, $t2\n"); break;
                        case "!=": sb.append("sne $t0, $t1, $t2\n"); break;
                    }
                    sb.append(store("$t0",dest));
                }
                continue;
            }

            // LOGICOS BINARIOS -  resultado int (0/1)
            Matcher mL = Pattern.compile("^(\\w+)\\s*=\\s*(\\S+)\\s*([@#])\\s*(\\S+)$").matcher(linea);
            if (mL.matches()) {
                String dest = mL.group(1);
                // Cargar como int (0/1)
                sb.append(load("$t1",mL.group(2))); 
                sb.append(load("$t2",mL.group(4)));
                sb.append(mL.group(3).equals("@")?"and $t0, $t1, $t2\n":"or $t0, $t1, $t2\n");
                // Guardar como int
                sb.append(store("$t0",dest)); 
                continue;
            }

            // NOT -  resultado int (0/1)
            Matcher mN = Pattern.compile("^(\\w+)\\s*=\\s*\\$(\\S+)$").matcher(linea);
            if (mN.matches()) {
                String dest = mN.group(1);
                sb.append(load("$t1",mN.group(2))); 
                sb.append("xori $t0, $t1, 1\n");
                sb.append(store("$t0",dest)); 
                continue;
            }

            // NEGACION ARITMETICA
            Matcher mNeg = Pattern.compile("^(\\w+)\\s*=\\s*-\\s*(\\S+)$").matcher(linea);
            if (mNeg.matches()) {
                String dest=mNeg.group(1), op=mNeg.group(2);
                if (esFloat(dest)||esFloat(op)) { 
                    sb.append(loadF("$f1",op)); 
                    sb.append("neg.s $f0, $f1\n"); 
                    sb.append(storeF("$f0",dest)); 
                } else { 
                    sb.append(esLitInt(op)?"li $t1, "+op+"\n":load("$t1",op)); 
                    sb.append("sub $t0, $zero, $t1\n"); 
                    sb.append(store("$t0",dest)); 
                }
                continue;
            }

            // ARITMETICA
            Matcher mOp = Pattern.compile("^(\\w+)\\s*=\\s*(\\S+)\\s*([+\\-*/%^])\\s*(\\S+)$").matcher(linea);
            if (mOp.matches()) {
                String dest=mOp.group(1), op1=mOp.group(2), oper=mOp.group(3), op2=mOp.group(4);
                if (esFloat(dest)||esFloat(op1)||esFloat(op2)) {
                    sb.append(loadF("$f1",op1)); sb.append(loadF("$f2",op2));
                    switch(oper) {
                        case "+": sb.append("add.s $f0, $f1, $f2\n"); break;
                        case "-": sb.append("sub.s $f0, $f1, $f2\n"); break;
                        case "*": sb.append("mul.s $f0, $f1, $f2\n"); break;
                        case "/": sb.append("div.s $f0, $f1, $f2\n"); break;
                        case "%": 
                            // Módulo con floats
                            sb.append("div.s $f3, $f1, $f2\n");
                            sb.append("floor.w.s $f3, $f3\n");
                            sb.append("cvt.s.w $f3, $f3\n");
                            sb.append("mul.s $f3, $f3, $f2\n");
                            sb.append("sub.s $f0, $f1, $f3\n");
                            break;
                        case "^":
                            // Potencia con floats
                            sb.append("cvt.w.s $f3, $f2\n");
                            sb.append("mfc1 $t2, $f3\n");
                            sb.append("li.s $f0, 1.0\n");
                            String pf1 = "_powf" + (contadorPow++) + "_s";
                            String pf2 = "_powf" + (contadorPow++) + "_e";
                            sb.append("blt $t2, $zero, ").append(pf1).append("_neg\n");
                            sb.append(pf1).append(":\n");
                            sb.append("blez $t2, ").append(pf2).append("\n");
                            sb.append("mul.s $f0, $f0, $f1\n");
                            sb.append("addi $t2, $t2, -1\n");
                            sb.append("j ").append(pf1).append("\n");
                            sb.append(pf2).append(":\n");
                            sb.append("j ").append(pf2).append("_end\n");
                            sb.append(pf1).append("_neg:\n");
                            sb.append("neg $t2, $t2\n");
                            sb.append("li.s $f3, 1.0\n");
                            sb.append(pf1).append("_neg_loop:\n");
                            sb.append("blez $t2, ").append(pf2).append("_neg_end\n");
                            sb.append("mul.s $f3, $f3, $f1\n");
                            sb.append("addi $t2, $t2, -1\n");
                            sb.append("j ").append(pf1).append("_neg_loop\n");
                            sb.append(pf2).append("_neg_end:\n");
                            sb.append("li.s $f1, 1.0\n");
                            sb.append("div.s $f0, $f1, $f3\n");
                            sb.append(pf2).append("_end:\n");
                            break;
                    }
                    sb.append(storeF("$f0",dest));
                } else {
                    sb.append(esLitInt(op1)?"li $t1, "+op1+"\n":load("$t1",op1));
                    sb.append(esLitInt(op2)?"li $t2, "+op2+"\n":load("$t2",op2));
                    switch(oper) {
                        case "+": sb.append("add $t0, $t1, $t2\n"); break;
                        case "-": sb.append("sub $t0, $t1, $t2\n"); break;
                        case "*": sb.append("mul $t0, $t1, $t2\n"); break;
                        case "/": sb.append("div $t1, $t2\nmflo $t0\n"); break;
                        case "%": sb.append("div $t1, $t2\nmfhi $t0\n"); break;
                        case "^":
                            String ei="_pow"+(contadorPow++)+"_s", ef2="_pow"+(contadorPow++)+"_e";
                            sb.append("li $t0, 1\n").append(ei).append(":\nblez $t2, ").append(ef2).append("\n");
                            sb.append("mul $t0, $t0, $t1\naddi $t2, $t2, -1\nj ").append(ei).append("\n").append(ef2).append(":\n");
                            break;
                    }
                    sb.append(store("$t0",dest));
                }
                continue;
            }

            // CALL
            Matcher mCall = Pattern.compile("^(\\w*)\\s*=\\s*call\\s+(\\w+),\\s*(\\d+)$").matcher(linea);
            if (mCall.matches()) {
                String dest = mCall.group(1), func = mCall.group(2);
               
                sb.append("jal ").append(func).append("\n");
                if (!dest.isEmpty()) {
                    if (tipoDe(dest).equals("float")) sb.append(storeF("$f0",dest));
                    else sb.append(store("$v0",dest));
                }
                parametrosPendientes.clear();
                continue;
            }

            // RETURN
            Matcher mRet = Pattern.compile("^return\\s*(\\S*)$").matcher(linea);
            if (mRet.matches()) {
                String val = mRet.group(1);
                if (!val.isEmpty()) {
                    if (esFloat(val)) sb.append(loadF("$f0",val));
                    else sb.append(load("$v0",val));
                }
                if (dentroDeFuncion && funcionActual != null) {
                    int total = frameTotalPorFuncion.getOrDefault(funcionActual,32);
                    sb.append("lw $ra, ").append(total-4).append("($sp)\n");
                    sb.append("addu $sp, $sp, ").append(total).append("\n");
                    sb.append("jr $ra\n");
                } else {
                    sb.append("li $v0, 10\nsyscall\n");
                }
                continue;
            }

            // WRITE - bool imprime como 0/1, float como float
            Matcher mW = Pattern.compile("^write\\s+(\\S+)$").matcher(linea);
            if (mW.matches()) {
                String op = mW.group(1);
                String tipo = tipoDe(op);
                switch(tipo) {
                    case "float":  
                        sb.append(loadF("$f12",op)); 
                        sb.append("li $v0, 2\nsyscall\n"); 
                        break;
                    case "bool":
                        //  bool se imprime como entero (0/1)
                        sb.append(load("$a0",op));  
                        sb.append("li $v0, 1\nsyscall\n"); 
                        break;
                    case "string": 
                        sb.append(load("$a0",op));  
                        sb.append("li $v0, 4\nsyscall\n"); 
                        break;
                    case "char":   
                        sb.append(load("$a0",op));  
                        sb.append("li $v0, 11\nsyscall\n"); 
                        break;
                    default:       
                        sb.append(load("$a0",op));  
                        sb.append("li $v0, 1\nsyscall\n"); 
                        break;
                }
                continue;
            }

            // READ
            Matcher mRd = Pattern.compile("^read\\s+(\\S+)$").matcher(linea);
            if (mRd.matches()) {
                String var = mRd.group(1);
                if (tipoDe(var).equals("float")) { 
                    sb.append("li $v0, 6\nsyscall\n"); 
                    sb.append(storeF("$f0",var)); 
                } else { 
                    sb.append("li $v0, 5\nsyscall\n"); 
                    sb.append(store("$v0",var)); 
                }
                continue;
            }

            sb.append("# PENDIENTE: ").append(linea).append("\n");
        }

        // Terminar main
        if (dentroDeFuncion && funcionActual != null && funcionActual.equals("main")) {
            sb.append("li $v0, 10\n");
            sb.append("syscall\n");
        }
        
        return sb.toString();
    }

    // ===============================================================
    // SECCION .data
    // ===============================================================

    static String generarData() {
        StringBuilder sb = new StringBuilder();
        sb.append(".data\n");

        Set<String> excluir = new HashSet<>();
        for (Map.Entry<String, LinkedHashMap<String,Integer>> entry : localesPorFuncion.entrySet()) {
            if (!entry.getKey().equals("main")) {
                for (String nombre : entry.getValue().keySet()) {
                    if (nombre.startsWith("__")) {
                        excluir.add(nombre);
                    }
                }
            }
        }

        for (Map.Entry<String,String> e : simbolosGlobales.entrySet()) {
            String nombre=e.getKey(), tipo=e.getValue();
            if (tipo.endsWith("[]") || excluir.contains(nombre)) continue;
            switch(tipo) {
                case "int": case "bool": case "char": case "string":
                    sb.append(nombre).append(": .word 0\n"); break;
                case "float":
                    sb.append(nombre).append(": .float 0.0\n"); break;
                default:
                    sb.append(nombre).append(": .word 0\n"); break;
            }
        }

        for (Map.Entry<String,Integer> e : arreglos.entrySet()) {
            String nombre=e.getKey(); int total=e.getValue();
            String tb = simbolosGlobales.get(nombre).replace("[]","");
            if (tb.equals("float")) {
                sb.append(nombre).append(": .float ");
                for (int i=0;i<total;i++) { sb.append("0.0"); if(i<total-1) sb.append(", "); }
                sb.append("\n");
            } else {
                sb.append(nombre).append(": .word 0:").append(total).append("\n");
            }
        }

        for (Map.Entry<String,String> e : stringsLiterales.entrySet())
            sb.append(e.getValue()).append(": .asciiz \"").append(e.getKey()).append("\"\n");

        sb.append("\n");
        return sb.toString();
    }

    // ===============================================================
    // LECTURA
    // ===============================================================

    static void leer(String path) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(path));
        String l;
        while ((l=br.readLine())!=null) {
            String lim=l.trim();
            if (!lim.isEmpty() && !lim.startsWith("#")) lineas3D.add(lim);
        }
        br.close();
    }
}