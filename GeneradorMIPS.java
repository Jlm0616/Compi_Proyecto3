import java.io.*;
import java.util.*;
import java.util.regex.*;

public class GeneradorMIPS {

    static LinkedHashMap<String, String> simbolos = new LinkedHashMap<>();
    static LinkedHashMap<String, Integer> arreglos = new LinkedHashMap<>();
    static LinkedHashMap<String, Integer> arregloColumnas = new LinkedHashMap<>();
    static LinkedHashMap<String, String> stringsLiterales = new LinkedHashMap<>();
    static int contadorStrings = 0;
    static int contadorCmp = 0;
    static int contadorPow = 0;
    static List<String> lineas3D = new ArrayList<>();
    static Map<String, String> renombrados = new HashMap<>();
    static LinkedHashMap<String, Integer> offsetsLocales = new LinkedHashMap<>();
    static LinkedHashMap<String, Integer> offsetsParametros = new LinkedHashMap<>();
    static int frameSize = 0;
    static int paramOffset = 0;
    static int localOffset = 0;
    static String funcionActual = null;
    static boolean dentroDeFuncion = false;
    static List<String> parametrosPendientes = new ArrayList<>();

    // ===============================================================
    // UTILIDAD: cargar dirección y guardar/leer en variable global
    // ===============================================================
    // En SPIM, "sw $t0, variable" no funciona directamente para variables
    // en .data. Hay que hacer:
    //   la $t9, variable
    //   sw $t0, 0($t9)
    // Estas utilidades generan ese patron.

    static String store(String registro, String variable) {
        if (esLiteralNumerico(variable)) {
            // no tiene sentido guardar en un literal, ignorar
            return "# store ignorado: " + variable + "\n";
        }
        return "la $t9, " + variable + "\nsw " + registro + ", 0($t9)\n";
    }

    static String storeFloat(String registro, String variable) {
        return "la $t9, " + variable + "\ns.s " + registro + ", 0($t9)\n";
    }

    static String load(String registro, String variable) {
        if (esLiteralNumerico(variable) && !variable.contains(".")) {
            return "li " + registro + ", " + variable + "\n";
        }
        return "la $t9, " + variable + "\nlw " + registro + ", 0($t9)\n";
    }

    static String loadFloat(String registro, String variable) {
        if (esLiteralNumerico(variable)) {
            return "li.s " + registro + ", " + variable + "\n";
        }
        return "la $t9, " + variable + "\nl.s " + registro + ", 0($t9)\n";
    }

    // ===============================================================
    // RENOMBRADO
    // ===============================================================

    static void renombrarPalabrasReservadas() {
        Set<String> nombresDeclarados = new LinkedHashSet<>();
        for (String linea : lineas3D) {
            if (linea.startsWith("declare ")) {
                String nombre = linea.substring("declare ".length()).split(",", 2)[0].trim();
                nombresDeclarados.add(nombre);
            } else if (linea.startsWith("param ")) {
                String nombre = linea.substring("param ".length()).split(",", 2)[0].trim();
                nombresDeclarados.add(nombre);
            }
        }
        for (String nombre : nombresDeclarados) nombreSeguro(nombre);

        boolean hayConflictos = renombrados.entrySet().stream().anyMatch(e -> !e.getKey().equals(e.getValue()));
        if (!hayConflictos) return;

        List<String> corregidas = new ArrayList<>();
        for (String linea : lineas3D) corregidas.add(renombrarFueraDeStrings(linea));
        lineas3D.clear();
        lineas3D.addAll(corregidas);
    }

    static String renombrarFueraDeStrings(String linea) {
        StringBuilder resultado = new StringBuilder();
        Matcher m = Pattern.compile("\"[^\"]*\"|[^\"]+").matcher(linea);
        while (m.find()) {
            String parte = m.group();
            if (parte.startsWith("\"")) {
                resultado.append(parte);
            } else {
                String nueva = parte;
                for (Map.Entry<String, String> e : renombrados.entrySet()) {
                    if (e.getKey().equals(e.getValue())) continue;
                    nueva = nueva.replaceAll("\\b" + Pattern.quote(e.getKey()) + "\\b", e.getValue());
                }
                resultado.append(nueva);
            }
        }
        return resultado.toString();
    }

    static final Set<String> PALABRAS_RESERVADAS_MIPS = new HashSet<>(Arrays.asList(
        "b", "j", "jr", "jal", "jalr",
        "la", "li", "lw", "sw", "lb", "sb", "lh", "sh",
        "l.s", "s.s", "l.d", "s.d", "li.s", "li.d",
        "lui", "move", "mfhi", "mflo", "mfc1", "mtc1",
        "add", "addu", "addi", "addiu", "sub", "subu",
        "mul", "mult", "multu", "div", "divu", "neg", "negu",
        "and", "andi", "or", "ori", "xor", "xori", "nor", "not",
        "sll", "srl", "sra", "rem", "abs",
        "add.s", "sub.s", "mul.s", "div.s", "neg.s", "abs.s",
        "add.d", "sub.d", "mul.d", "div.d", "neg.d", "abs.d",
        "mov.s", "mov.d", "cvt.s.w", "cvt.w.s", "cvt.d.w", "cvt.w.d",
        "slt", "slti", "sltu", "sltiu", "sle", "sgt", "sge", "seq", "sne",
        "beq", "bne", "blt", "ble", "bgt", "bge", "beqz", "bnez",
        "bltz", "blez", "bgtz", "bgez",
        "c.lt.s", "c.le.s", "c.eq.s", "c.lt.d", "c.le.d", "c.eq.d",
        "bc1t", "bc1f",
        "syscall", "nop", "break", "trap", "eret",
        "data", "text", "word", "asciiz", "ascii", "byte", "float", "double",
        "globl", "ent", "end", "space", "align", "extern"
    ));

    static String nombreSeguro(String nombreOriginal) {
        if (renombrados.containsKey(nombreOriginal)) return renombrados.get(nombreOriginal);
        String seguro = nombreOriginal;
        if (!nombreOriginal.startsWith("__") && PALABRAS_RESERVADAS_MIPS.contains(nombreOriginal.toLowerCase())) {
            seguro = "var_" + nombreOriginal;
        }
        renombrados.put(nombreOriginal, seguro);
        return seguro;
    }

    // ===============================================================
    // PUNTO DE ENTRADA
    // ===============================================================

    public static void main(String[] args) {
        if (args.length < 1) { System.out.println("Uso: java GeneradorMIPS <archivo.txt>"); return; }
        try {
            String entrada = args[0];
            String salida = entrada.replaceAll("\\.[^.]+$", "") + ".asm";
            generar(entrada, salida);
            System.out.println("Archivo MIPS generado: " + salida);
        } catch (IOException e) { System.out.println("Error: " + e.getMessage()); }
    }

    static String generar(String archivoEntrada, String archivoSalida) throws IOException {
        simbolos.clear(); arreglos.clear(); arregloColumnas.clear();
        stringsLiterales.clear(); lineas3D.clear(); renombrados.clear();
        contadorStrings = 0; contadorCmp = 0; contadorPow = 0;
        offsetsLocales.clear(); offsetsParametros.clear();
        frameSize = 0; paramOffset = 0; localOffset = 0;
        funcionActual = null; dentroDeFuncion = false; parametrosPendientes.clear();

        leerArchivo(archivoEntrada);
        renombrarPalabrasReservadas();
        primeraPasada();

        StringBuilder asm = new StringBuilder();
        asm.append(generarData());
        asm.append(".text\n.globl main\n");
        asm.append(segundaPasada());

        BufferedWriter bw = new BufferedWriter(new FileWriter(archivoSalida));
        bw.write(asm.toString());
        bw.close();
        return archivoSalida;
    }

    // ===============================================================
    // UTILIDADES DE TIPOS
    // ===============================================================

    static boolean esFloat(String operando) {
        if (simbolos.containsKey(operando)) return simbolos.get(operando).equals("float");
        return operando.contains(".") && !operando.startsWith("_");
    }

    static boolean esLiteralNumerico(String s) {
        return s.matches("-?\\d+(\\.\\d+)?([eE][+-]?\\d+)?");
    }

    static String tipoDe(String operando) {
        Matcher mArr = Pattern.compile("^(\\w+)\\[.*\\]\\[.*\\]$").matcher(operando);
        if (mArr.matches()) {
            String arr = mArr.group(1);
            if (simbolos.containsKey(arr)) {
                String t = simbolos.get(arr);
                return t.endsWith("[]") ? t.replace("[]", "") : t;
            }
            return arr.startsWith("__f") ? "float" : "int";
        }
        if (simbolos.containsKey(operando)) return simbolos.get(operando);
        if (esLiteralNumerico(operando)) return operando.contains(".") ? "float" : "int";
        return "int";
    }

    // ===============================================================
    // PRIMERA PASADA
    // ===============================================================

    static void primeraPasada() {
        for (String linea : lineas3D) {
            if (linea.startsWith("declare ")) {
                String resto = linea.substring("declare ".length());
                String[] partes = resto.split(",", 2);
                String nombre = partes[0].trim();
                String tipo = partes[1].trim();
                if (tipo.contains("[")) {
                    String tipoBase = tipo.substring(0, tipo.indexOf('['));
                    Matcher m = Pattern.compile("\\[(\\d+)\\]\\[(\\d+)\\]").matcher(tipo);
                    if (m.find()) {
                        int filas = Integer.parseInt(m.group(1));
                        int cols = Integer.parseInt(m.group(2));
                        arreglos.put(nombre, filas * cols);
                        arregloColumnas.put(nombre, cols);
                        simbolos.put(nombre, tipoBase + "[]");
                    }
                } else {
                    String actual = simbolos.get(nombre);
                    if (actual == null || (!actual.equals("string") && !actual.equals("char") && !actual.equals("bool")))
                        simbolos.put(nombre, tipo);
                }
                continue;
            }

            if (linea.startsWith("param ")) {
                String resto = linea.substring("param ".length());
                String[] partes = resto.split(",", 2);
                String nombre = partes[0].trim();
                String tipo = partes[1].trim();
                if (!simbolos.containsKey(nombre)) simbolos.put(nombre, tipo);
                continue;
            }

            Matcher mArrAsign = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)\\[.*\\]\\[.*\\]$").matcher(linea);
            if (mArrAsign.matches()) {
                String temp = mArrAsign.group(1);
                String arr = mArrAsign.group(2);
                if (!simbolos.containsKey(temp) && simbolos.containsKey(arr)) {
                    String t = simbolos.get(arr);
                    simbolos.put(temp, t.endsWith("[]") ? t.replace("[]", "") : t);
                }
                continue;
            }

            Matcher mStr = Pattern.compile("\"([^\"]*)\"").matcher(linea);
            if (mStr.find()) {
                String contenido = mStr.group(1);
                if (!stringsLiterales.containsKey(contenido))
                    stringsLiterales.put(contenido, "str" + contadorStrings++);
            }

            Matcher mTemp = Pattern.compile("^(__[tf]\\d+)\\s*=\\s*(.*)$").matcher(linea);
            if (mTemp.matches()) {
                String nombre = mTemp.group(1);
                String rhs = mTemp.group(2);
                if (!simbolos.containsKey(nombre)) {
                    String tipo;
                    if (rhs.matches("\"(.*)\"")) tipo = "string";
                    else if (rhs.matches("(true|false)")) tipo = "bool";
                    else if (rhs.matches("'.'")) tipo = "char";
                    else if (rhs.matches("-?\\d+\\.\\d+")) tipo = "float";
                    else tipo = nombre.startsWith("__f") ? "float" : "int";
                    simbolos.put(nombre, tipo);
                }
            }
        }
    }

    // ===============================================================
    // SEGUNDA PASADA
    // ===============================================================

    static String segundaPasada() {
        StringBuilder sb = new StringBuilder();
        dentroDeFuncion = false;
        funcionActual = null;
        parametrosPendientes.clear();

        for (String linea : lineas3D) {

            // Ignorar declares
            if (linea.startsWith("declare ")) continue;

            // -------------------------------------------------------
            // ETIQUETAS
            // -------------------------------------------------------
            if (linea.endsWith(":") && !linea.contains(" ") && !linea.contains("=")) {
                String etiqueta = linea.substring(0, linea.length() - 1);

                if (!etiqueta.equals("main") && !etiqueta.startsWith("_")) {
                    // Es una función de usuario
                    dentroDeFuncion = true;
                    funcionActual = etiqueta;
                    frameSize = 0; localOffset = 0; paramOffset = 0;
                    offsetsLocales.clear(); offsetsParametros.clear(); parametrosPendientes.clear();

                    sb.append(linea).append("\n");
                    sb.append("subu $sp, $sp, 8\n");
                    sb.append("sw $ra, 4($sp)\n");
                    sb.append("sw $fp, 0($sp)\n");
                    sb.append("move $fp, $sp\n");
                } else {
                    if (etiqueta.equals("main")) {
                        dentroDeFuncion = false;
                        funcionActual = null;
                    }
                    sb.append(linea).append("\n");
                }
                continue;
            }

            // -------------------------------------------------------
            // ESCRITURA EN ARREGLO: arr[i][j] = valor
            // -------------------------------------------------------
            Matcher mArrSet = Pattern.compile("^(\\w+)\\[(.+)\\]\\[(.+)\\]\\s*=\\s*(\\S+)$").matcher(linea);
            if (mArrSet.matches()) {
                String arr = mArrSet.group(1);
                String idx1 = mArrSet.group(2);
                String idx2 = mArrSet.group(3);
                String valor = mArrSet.group(4);
                int cols = arregloColumnas.getOrDefault(arr, 1);

                sb.append(esLiteralNumerico(idx1) && !idx1.contains(".") ? "li $t8, " + idx1 + "\n" : load("$t8", idx1));
                sb.append("li $t9, ").append(cols).append("\n");
                sb.append("mul $t8, $t8, $t9\n");
                sb.append(esLiteralNumerico(idx2) && !idx2.contains(".") ? "li $t9, " + idx2 + "\n" : load("$t9", idx2));
                sb.append("add $t8, $t8, $t9\n");
                sb.append("sll $t8, $t8, 2\n");
                sb.append("la $t9, ").append(arr).append("\n");
                sb.append("add $t9, $t9, $t8\n");

                if (esFloat(arr) || esFloat(valor)) {
                    sb.append(loadFloat("$f0", valor));
                    sb.append("s.s $f0, 0($t9)\n");
                } else {
                    sb.append(esLiteralNumerico(valor) ? "li $t0, " + valor + "\n" : load("$t0", valor));
                    sb.append("sw $t0, 0($t9)\n");
                }
                continue;
            }

            // -------------------------------------------------------
            // LECTURA DE ARREGLO: dest = arr[i][j]
            // -------------------------------------------------------
            Matcher mArrGet = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)\\[(.+)\\]\\[(.+)\\]$").matcher(linea);
            if (mArrGet.matches()) {
                String destino = mArrGet.group(1);
                String arr = mArrGet.group(2);
                String idx1 = mArrGet.group(3);
                String idx2 = mArrGet.group(4);
                int cols = arregloColumnas.getOrDefault(arr, 1);

                sb.append(esLiteralNumerico(idx1) && !idx1.contains(".") ? "li $t8, " + idx1 + "\n" : load("$t8", idx1));
                sb.append("li $t9, ").append(cols).append("\n");
                sb.append("mul $t8, $t8, $t9\n");
                sb.append(esLiteralNumerico(idx2) && !idx2.contains(".") ? "li $t9, " + idx2 + "\n" : load("$t9", idx2));
                sb.append("add $t8, $t8, $t9\n");
                sb.append("sll $t8, $t8, 2\n");
                sb.append("la $t9, ").append(arr).append("\n");
                sb.append("add $t9, $t9, $t8\n");

                if (esFloat(arr) || esFloat(destino)) {
                    sb.append("l.s $f0, 0($t9)\n");
                    sb.append(storeFloat("$f0", destino));
                } else {
                    sb.append("lw $t0, 0($t9)\n");
                    sb.append(store("$t0", destino));
                }
                continue;
            }

            // -------------------------------------------------------
            // LITERAL NUMERICO: dest = 42 o dest = 3.14
            // -------------------------------------------------------
            Matcher mLit = Pattern.compile("^([\\w_]+)\\s*=\\s*(-?\\d+(\\.\\d+)?)$").matcher(linea);
            if (mLit.matches()) {
                String destino = mLit.group(1);
                String valor = mLit.group(2);
                if (valor.contains(".") || esFloat(destino)) {
                    sb.append("li.s $f0, ").append(valor).append("\n");
                    sb.append(storeFloat("$f0", destino));
                } else {
                    sb.append("li $t0, ").append(valor).append("\n");
                    sb.append(store("$t0", destino));
                }
                continue;
            }

            // -------------------------------------------------------
            // BOOLEANO: dest = true/false
            // -------------------------------------------------------
            Matcher mBool = Pattern.compile("^(\\w+)\\s*=\\s*(true|false)$").matcher(linea);
            if (mBool.matches()) {
                String destino = mBool.group(1);
                String valor = mBool.group(2).equals("true") ? "1" : "0";
                sb.append("li $t0, ").append(valor).append("\n");
                sb.append(store("$t0", destino));
                continue;
            }

            // -------------------------------------------------------
            // CARACTER: dest = 'A'
            // -------------------------------------------------------
            Matcher mChar = Pattern.compile("^(\\w+)\\s*=\\s*'(.)'$").matcher(linea);
            if (mChar.matches()) {
                String destino = mChar.group(1);
                int ascii = (int) mChar.group(2).charAt(0);
                sb.append("li $t0, ").append(ascii).append("\n");
                sb.append(store("$t0", destino));
                continue;
            }

            // -------------------------------------------------------
            // STRING LITERAL: dest = "texto"
            // -------------------------------------------------------
            Matcher mStrLit = Pattern.compile("^(\\w+)\\s*=\\s*\"(.*)\"$").matcher(linea);
            if (mStrLit.matches()) {
                String destino = mStrLit.group(1);
                String contenido = mStrLit.group(2);
                String etiqueta = stringsLiterales.get(contenido);
                sb.append("la $t0, ").append(etiqueta).append("\n");
                sb.append(store("$t0", destino));
                continue;
            }

            // -------------------------------------------------------
            // COPIA SIMPLE: dest = origen
            // -------------------------------------------------------
            Matcher mCopia = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)$").matcher(linea);
            if (mCopia.matches()) {
                String destino = mCopia.group(1);
                String origen = mCopia.group(2);
                if (esFloat(destino) || esFloat(origen)) {
                    sb.append(loadFloat("$f0", origen));
                    sb.append(storeFloat("$f0", destino));
                } else {
                    sb.append(load("$t0", origen));
                    sb.append(store("$t0", destino));
                }
                continue;
            }

            // -------------------------------------------------------
            // GOTO
            // -------------------------------------------------------
            Matcher mGoto = Pattern.compile("^goto\\s+(\\S+)$").matcher(linea);
            if (mGoto.matches()) {
                sb.append("j ").append(mGoto.group(1)).append("\n");
                continue;
            }

            // -------------------------------------------------------
            // IF FALSE GOTO
            // -------------------------------------------------------
            Matcher mIfFalse = Pattern.compile("^ifFalse\\s+(\\S+)\\s+goto\\s+(\\S+)$").matcher(linea);
            if (mIfFalse.matches()) {
                sb.append(load("$t0", mIfFalse.group(1)));
                sb.append("beq $t0, $zero, ").append(mIfFalse.group(2)).append("\n");
                continue;
            }

            // -------------------------------------------------------
            // IF TRUE GOTO
            // -------------------------------------------------------
            Matcher mIfTrue = Pattern.compile("^if\\s+(\\S+)\\s+goto\\s+(\\S+)$").matcher(linea);
            if (mIfTrue.matches()) {
                sb.append(load("$t0", mIfTrue.group(1)));
                sb.append("bne $t0, $zero, ").append(mIfTrue.group(2)).append("\n");
                continue;
            }

            // -------------------------------------------------------
            // RELACIONALES: dest = op1 OP op2
            // -------------------------------------------------------
            Matcher mRel = Pattern.compile("^(\\w+)\\s*=\\s*(\\S+)\\s*(<=|>=|==|!=|<|>)\\s*(\\S+)$").matcher(linea);
            if (mRel.matches()) {
                String destino = mRel.group(1);
                String op1 = mRel.group(2);
                String operador = mRel.group(3);
                String op2 = mRel.group(4);
                boolean flotante = esFloat(op1) || esFloat(op2);

                if (flotante) {
                    sb.append(loadFloat("$f1", op1));
                    sb.append(loadFloat("$f2", op2));
                    String etqFin = "_cmp" + (contadorCmp++);
                    switch (operador) {
                        case "<":  sb.append("c.lt.s $f1, $f2\n"); break;
                        case "<=": sb.append("c.le.s $f1, $f2\n"); break;
                        case ">":  sb.append("c.lt.s $f2, $f1\n"); break;
                        case ">=": sb.append("c.le.s $f2, $f1\n"); break;
                        case "==": sb.append("c.eq.s $f1, $f2\n"); break;
                        case "!=": sb.append("c.eq.s $f1, $f2\n"); break;
                    }
                    boolean negar = operador.equals("!=");
                    sb.append("li $t0, 0\n");
                    if (negar) {
                        sb.append("bc1t ").append(etqFin).append("\n");
                    } else {
                        sb.append("bc1f ").append(etqFin).append("\n");
                    }
                    sb.append("li $t0, 1\n");
                    sb.append(etqFin).append(":\n");
                    sb.append(store("$t0", destino));
                } else {
                    sb.append(esLiteralNumerico(op1) ? "li $t1, " + op1 + "\n" : load("$t1", op1));
                    sb.append(esLiteralNumerico(op2) ? "li $t2, " + op2 + "\n" : load("$t2", op2));
                    switch (operador) {
                        case "<":  sb.append("slt $t0, $t1, $t2\n"); break;
                        case "<=": sb.append("sle $t0, $t1, $t2\n"); break;
                        case ">":  sb.append("sgt $t0, $t1, $t2\n"); break;
                        case ">=": sb.append("sge $t0, $t1, $t2\n"); break;
                        case "==": sb.append("seq $t0, $t1, $t2\n"); break;
                        case "!=": sb.append("sne $t0, $t1, $t2\n"); break;
                    }
                    sb.append(store("$t0", destino));
                }
                continue;
            }

            // -------------------------------------------------------
            // LOGICOS BINARIOS: dest = op1 @ op2  /  dest = op1 # op2
            // -------------------------------------------------------
            Matcher mLogico = Pattern.compile("^(\\w+)\\s*=\\s*(\\S+)\\s*([@#])\\s*(\\S+)$").matcher(linea);
            if (mLogico.matches()) {
                String destino = mLogico.group(1);
                String op1 = mLogico.group(2);
                String operador = mLogico.group(3);
                String op2 = mLogico.group(4);
                sb.append(load("$t1", op1));
                sb.append(load("$t2", op2));
                sb.append(operador.equals("@") ? "and $t0, $t1, $t2\n" : "or $t0, $t1, $t2\n");
                sb.append(store("$t0", destino));
                continue;
            }

            // -------------------------------------------------------
            // NOT LOGICO: dest = !op
            // -------------------------------------------------------
            Matcher mNot = Pattern.compile("^(\\w+)\\s*=\\s*!(\\S+)$").matcher(linea);
            if (mNot.matches()) {
                String destino = mNot.group(1);
                String op1 = mNot.group(2);
                sb.append(load("$t1", op1));
                sb.append("xori $t0, $t1, 1\n");
                sb.append(store("$t0", destino));
                continue;
            }

            // -------------------------------------------------------
            // NEGACION ARITMETICA: dest = -op
            // -------------------------------------------------------
            Matcher mNeg = Pattern.compile("^(\\w+)\\s*=\\s*-\\s*(\\S+)$").matcher(linea);
            if (mNeg.matches()) {
                String destino = mNeg.group(1);
                String op1 = mNeg.group(2);
                if (esFloat(destino) || esFloat(op1)) {
                    sb.append(loadFloat("$f1", op1));
                    sb.append("neg.s $f0, $f1\n");
                    sb.append(storeFloat("$f0", destino));
                } else {
                    sb.append(esLiteralNumerico(op1) ? "li $t1, " + op1 + "\n" : load("$t1", op1));
                    sb.append("sub $t0, $zero, $t1\n");
                    sb.append(store("$t0", destino));
                }
                continue;
            }

            // -------------------------------------------------------
            // OPERACIONES ARITMETICAS: dest = op1 OP op2
            // -------------------------------------------------------
            Matcher mOp = Pattern.compile("^(\\w+)\\s*=\\s*(\\S+)\\s*([+\\-*/%^])\\s*(\\S+)$").matcher(linea);
            if (mOp.matches()) {
                String destino = mOp.group(1);
                String op1 = mOp.group(2);
                String operador = mOp.group(3);
                String op2 = mOp.group(4);
                boolean flotante = esFloat(destino) || esFloat(op1) || esFloat(op2);

                if (flotante) {
                    sb.append(loadFloat("$f1", op1));
                    sb.append(loadFloat("$f2", op2));
                    switch (operador) {
                        case "+": sb.append("add.s $f0, $f1, $f2\n"); break;
                        case "-": sb.append("sub.s $f0, $f1, $f2\n"); break;
                        case "*": sb.append("mul.s $f0, $f1, $f2\n"); break;
                        case "/": sb.append("div.s $f0, $f1, $f2\n"); break;
                    }
                    sb.append(storeFloat("$f0", destino));
                } else {
                    sb.append(esLiteralNumerico(op1) ? "li $t1, " + op1 + "\n" : load("$t1", op1));
                    sb.append(esLiteralNumerico(op2) ? "li $t2, " + op2 + "\n" : load("$t2", op2));
                    switch (operador) {
                        case "+": sb.append("add $t0, $t1, $t2\n"); break;
                        case "-": sb.append("sub $t0, $t1, $t2\n"); break;
                        case "*": sb.append("mul $t0, $t1, $t2\n"); break;
                        case "/": sb.append("div $t1, $t2\n"); sb.append("mflo $t0\n"); break;
                        case "%": sb.append("div $t1, $t2\n"); sb.append("mfhi $t0\n"); break;
                        case "^":
                            String etqI = "_pow" + (contadorPow++) + "_start";
                            String etqF = "_pow" + (contadorPow++) + "_end";
                            sb.append("li $t0, 1\n");
                            sb.append(etqI).append(":\n");
                            sb.append("blez $t2, ").append(etqF).append("\n");
                            sb.append("mul $t0, $t0, $t1\n");
                            sb.append("addi $t2, $t2, -1\n");
                            sb.append("j ").append(etqI).append("\n");
                            sb.append(etqF).append(":\n");
                            break;
                    }
                    sb.append(store("$t0", destino));
                }
                continue;
            }

            // -------------------------------------------------------
            // PARAM
            // -------------------------------------------------------
            Matcher mParam = Pattern.compile("^param\\s+(\\S+),\\s*(\\w+(?:\\[\\]\\[\\])?)$").matcher(linea);
            if (mParam.matches()) {
                String parametro = mParam.group(1);
                String tipo = mParam.group(2);

                if (dentroDeFuncion) {
                    // Recibir argumento del registro $aX y guardarlo en memoria
                    int numParam = offsetsParametros.size();
                    offsetsParametros.put(parametro, paramOffset);
                    paramOffset += 4;
                    frameSize += 4;
                    simbolos.put(parametro, tipo);

                    if (tipo.equals("float")) {
                        String regFloat = (numParam == 0) ? "$f12" : "$f14";
                        sb.append(storeFloat(regFloat, parametro));
                    } else if (numParam <= 3) {
                        String reg = "$a" + numParam;
                        sb.append("la $t9, ").append(parametro).append("\n");
                        sb.append("sw ").append(reg).append(", 0($t9)\n");
                    }
                } else {
                    // Pasar argumento al registro $aX antes del call
                    int indice = parametrosPendientes.size();
                    parametrosPendientes.add(parametro);

                    if (tipo.equals("float")) {
                        String regFloat = (indice == 0) ? "$f12" : "$f14";
                        sb.append(loadFloat(regFloat, parametro));
                    } else if (indice <= 3) {
                        String reg = "$a" + indice;
                        sb.append(load(reg, parametro));
                    }
                }
                continue;
            }

            // -------------------------------------------------------
            // CALL
            // -------------------------------------------------------
            Matcher mCall = Pattern.compile("^(\\w*)\\s*=\\s*call\\s+(\\w+),\\s*(\\d+)$").matcher(linea);
            if (mCall.matches()) {
                String destino = mCall.group(1);
                String funcion = mCall.group(2);

                sb.append("subu $sp, $sp, 8\n");
                sb.append("sw $ra, 4($sp)\n");
                sb.append("sw $fp, 0($sp)\n");
                sb.append("jal ").append(funcion).append("\n");
                sb.append("lw $fp, 0($sp)\n");
                sb.append("lw $ra, 4($sp)\n");
                sb.append("addu $sp, $sp, 8\n");

                if (!destino.isEmpty()) {
                    if (tipoDe(destino).equals("float")) {
                        sb.append(storeFloat("$f0", destino));
                    } else {
                        sb.append(store("$v0", destino));
                    }
                }
                parametrosPendientes.clear();
                continue;
            }

            // -------------------------------------------------------
            // RETURN
            // -------------------------------------------------------
            Matcher mReturn = Pattern.compile("^return\\s*(\\S*)$").matcher(linea);
            if (mReturn.matches()) {
                String valor = mReturn.group(1);
                if (!valor.isEmpty()) {
                    if (esFloat(valor)) {
                        sb.append(loadFloat("$f0", valor));
                    } else {
                        sb.append(load("$v0", valor));
                    }
                }
                if (dentroDeFuncion && funcionActual != null) {
                    sb.append("lw $fp, 0($sp)\n");
                    sb.append("lw $ra, 4($sp)\n");
                    sb.append("addu $sp, $sp, 8\n");
                    sb.append("jr $ra\n");
                    dentroDeFuncion = false;
                    funcionActual = null;
                } else {
                    sb.append("li $v0, 10\n");
                    sb.append("syscall\n");
                }
                continue;
            }

            // -------------------------------------------------------
            // WRITE
            // -------------------------------------------------------
            Matcher mWrite = Pattern.compile("^write\\s+(\\S+)$").matcher(linea);
            if (mWrite.matches()) {
                String operando = mWrite.group(1);
                String tipo = tipoDe(operando);
                switch (tipo) {
                    case "float":
                        sb.append(loadFloat("$f12", operando));
                        sb.append("li $v0, 2\nsyscall\n");
                        break;
                    case "string":
                        sb.append(load("$a0", operando));
                        sb.append("li $v0, 4\nsyscall\n");
                        break;
                    case "char":
                        sb.append(load("$a0", operando));
                        sb.append("li $v0, 11\nsyscall\n");
                        break;
                    default:
                        sb.append(load("$a0", operando));
                        sb.append("li $v0, 1\nsyscall\n");
                        break;
                }
                continue;
            }

            // -------------------------------------------------------
            // READ
            // -------------------------------------------------------
            Matcher mRead = Pattern.compile("^read\\s+(\\S+)$").matcher(linea);
            if (mRead.matches()) {
                String variable = mRead.group(1);
                if (tipoDe(variable).equals("float")) {
                    sb.append("li $v0, 6\nsyscall\n");
                    sb.append(storeFloat("$f0", variable));
                } else {
                    sb.append("li $v0, 5\nsyscall\n");
                    sb.append(store("$v0", variable));
                }
                continue;
            }

            sb.append("# PENDIENTE: ").append(linea).append("\n");
        }

        // Cerrar función si quedó abierta
        if (dentroDeFuncion && funcionActual != null) {
            sb.append("lw $fp, 0($sp)\n");
            sb.append("lw $ra, 4($sp)\n");
            sb.append("addu $sp, $sp, 8\n");
            sb.append("jr $ra\n");
        }

        sb.append("li $v0, 10\nsyscall\n");
        return sb.toString();
    }

    // ===============================================================
    // SECCION .data
    // ===============================================================

    static String generarData() {
        StringBuilder sb = new StringBuilder();
        sb.append(".data\n");

        for (Map.Entry<String, String> e : simbolos.entrySet()) {
            String nombre = e.getKey();
            String tipo = e.getValue();
            if (tipo.endsWith("[]")) continue;
            switch (tipo) {
                case "int": case "bool": case "char": case "string":
                    sb.append(nombre).append(": .word 0\n"); break;
                case "float":
                    sb.append(nombre).append(": .float 0.0\n"); break;
                default:
                    sb.append(nombre).append(": .word 0\n"); break;
            }
        }

        for (Map.Entry<String, Integer> e : arreglos.entrySet()) {
            String nombre = e.getKey();
            int total = e.getValue();
            String tipoBase = simbolos.get(nombre).replace("[]", "");
            if (tipoBase.equals("float")) {
                sb.append(nombre).append(": .float ");
                for (int i = 0; i < total; i++) { sb.append("0.0"); if (i < total-1) sb.append(", "); }
                sb.append("\n");
            } else {
                sb.append(nombre).append(": .word 0:").append(total).append("\n");
            }
        }

        for (Map.Entry<String, String> e : stringsLiterales.entrySet()) {
            sb.append(e.getValue()).append(": .asciiz \"").append(e.getKey()).append("\"\n");
        }

        sb.append("\n");
        return sb.toString();
    }

    // ===============================================================
    // LECTURA DEL ARCHIVO
    // ===============================================================

    static void leerArchivo(String path) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(path));
        String linea;
        while ((linea = br.readLine()) != null) {
            String limpia = linea.trim();
            if (limpia.isEmpty() || limpia.startsWith("#")) continue;
            lineas3D.add(limpia);
        }
        br.close();
    }
}