import java.io.*;
import java.util.*;
import java.util.regex.*;

public class GeneradorMIPS {

    // ===============================================================
    // ESTRUCTURAS DE DATOS
    // ===============================================================

    // Tipo de cada simbolo global (temporales, strings, etc.)
    static LinkedHashMap<String, String> simbolosGlobales = new LinkedHashMap<>();

    // Variables/temporales que son LOCALES a una funcion (viven en stack)
    // nombreFuncion -> { nombre -> offset_desde_fp }
    static LinkedHashMap<String, LinkedHashMap<String, Integer>> localesPorFuncion = new LinkedHashMap<>();

    // Tamano del frame de cada funcion (en bytes)
    static LinkedHashMap<String, Integer> frameSizePorFuncion = new LinkedHashMap<>();

    // Arreglos globales
    static LinkedHashMap<String, Integer> arreglos = new LinkedHashMap<>();
    static LinkedHashMap<String, Integer> arregloColumnas = new LinkedHashMap<>();

    // Strings literales
    static LinkedHashMap<String, String> stringsLiterales = new LinkedHashMap<>();
    static int contadorStrings = 0;

    static int contadorCmp = 0;
    static int contadorPow = 0;

    static List<String> lineas3D = new ArrayList<>();
    static Map<String, String> renombrados = new HashMap<>();

    // Estado de la segunda pasada
    static String funcionActual = null;
    static boolean dentroDeFuncion = false;
    static List<String> parametrosPendientes = new ArrayList<>();

    // ===============================================================
    // UTILIDADES: acceso a memoria con la+sw/lw
    // ===============================================================

    // Guarda $reg en variable (global o local segun contexto)
    static String store(String registro, String variable) {
        if (dentroDeFuncion && funcionActual != null) {
            LinkedHashMap<String, Integer> locales = localesPorFuncion.get(funcionActual);
            if (locales != null && locales.containsKey(variable)) {
                int offset = locales.get(variable);
                return "sw " + registro + ", " + offset + "($fp)\n";
            }
        }
        return "la $t9, " + variable + "\nsw " + registro + ", 0($t9)\n";
    }

    static String storeFloat(String registro, String variable) {
        if (dentroDeFuncion && funcionActual != null) {
            LinkedHashMap<String, Integer> locales = localesPorFuncion.get(funcionActual);
            if (locales != null && locales.containsKey(variable)) {
                int offset = locales.get(variable);
                return "s.s " + registro + ", " + offset + "($fp)\n";
            }
        }
        return "la $t9, " + variable + "\ns.s " + registro + ", 0($t9)\n";
    }

    static String load(String registro, String variable) {
        if (esLiteralNumerico(variable) && !variable.contains(".")) {
            return "li " + registro + ", " + variable + "\n";
        }
        if (dentroDeFuncion && funcionActual != null) {
            LinkedHashMap<String, Integer> locales = localesPorFuncion.get(funcionActual);
            if (locales != null && locales.containsKey(variable)) {
                int offset = locales.get(variable);
                return "lw " + registro + ", " + offset + "($fp)\n";
            }
        }
        return "la $t9, " + variable + "\nlw " + registro + ", 0($t9)\n";
    }

    static String loadFloat(String registro, String variable) {
        if (esLiteralNumerico(variable)) {
            return "li.s " + registro + ", " + variable + "\n";
        }
        if (dentroDeFuncion && funcionActual != null) {
            LinkedHashMap<String, Integer> locales = localesPorFuncion.get(funcionActual);
            if (locales != null && locales.containsKey(variable)) {
                int offset = locales.get(variable);
                return "l.s " + registro + ", " + offset + "($fp)\n";
            }
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
                nombresDeclarados.add(linea.substring("declare ".length()).split(",", 2)[0].trim());
            } else if (linea.startsWith("param ")) {
                nombresDeclarados.add(linea.substring("param ".length()).split(",", 2)[0].trim());
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
        simbolosGlobales.clear(); arreglos.clear(); arregloColumnas.clear();
        stringsLiterales.clear(); lineas3D.clear(); renombrados.clear();
        localesPorFuncion.clear(); frameSizePorFuncion.clear();
        contadorStrings = 0; contadorCmp = 0; contadorPow = 0;
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
        // Primero buscar en locales de la funcion actual
        if (dentroDeFuncion && funcionActual != null) {
            // No tenemos tipo en locales directamente, buscamos en simbolosGlobales
        }
        if (simbolosGlobales.containsKey(operando)) return simbolosGlobales.get(operando).equals("float");
        return operando.contains(".") && !operando.startsWith("_");
    }

    static boolean esLiteralNumerico(String s) {
        return s.matches("-?\\d+(\\.\\d+)?([eE][+-]?\\d+)?");
    }

    static String tipoDe(String operando) {
        Matcher mArr = Pattern.compile("^(\\w+)\\[.*\\]\\[.*\\]$").matcher(operando);
        if (mArr.matches()) {
            String arr = mArr.group(1);
            if (simbolosGlobales.containsKey(arr)) {
                String t = simbolosGlobales.get(arr);
                return t.endsWith("[]") ? t.replace("[]", "") : t;
            }
            return "int";
        }
        if (simbolosGlobales.containsKey(operando)) return simbolosGlobales.get(operando);
        if (esLiteralNumerico(operando)) return operando.contains(".") ? "float" : "int";
        return "int";
    }

    // ===============================================================
    // PRIMERA PASADA: recolectar tipos y calcular frames
    // ===============================================================

    static void primeraPasada() {
        // Paso 1: recolectar todos los tipos globalmente
        String funcActualPasada = null;

        for (String linea : lineas3D) {
            // Detectar inicio de funcion
            if (linea.endsWith(":") && !linea.contains(" ") && !linea.contains("=")) {
                String etq = linea.substring(0, linea.length() - 1);
                if (!etq.equals("main") && !etq.startsWith("_")) {
                    funcActualPasada = etq;
                    localesPorFuncion.put(etq, new LinkedHashMap<>());
                    frameSizePorFuncion.put(etq, 0);
                } else {
                    funcActualPasada = etq; // main u otra etiqueta
                }
                continue;
            }

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
                        simbolosGlobales.put(nombre, tipoBase + "[]");
                    }
                } else {
                    // Variable local si estamos dentro de una funcion (no main)
                    if (funcActualPasada != null && !funcActualPasada.equals("main")
                            && localesPorFuncion.containsKey(funcActualPasada)) {
                        LinkedHashMap<String, Integer> locales = localesPorFuncion.get(funcActualPasada);
                        if (!locales.containsKey(nombre)) {
                            int frameActual = frameSizePorFuncion.get(funcActualPasada);
                            // offset negativo desde fp (variables locales debajo del fp)
                            int offset = -(frameActual + 4);
                            locales.put(nombre, offset);
                            frameSizePorFuncion.put(funcActualPasada, frameActual + 4);
                        }
                    }
                    String actual = simbolosGlobales.get(nombre);
                    if (actual == null || (!actual.equals("string") && !actual.equals("char") && !actual.equals("bool")))
                        simbolosGlobales.put(nombre, tipo);
                }
                continue;
            }

            if (linea.startsWith("param ")) {
                String resto = linea.substring("param ".length());
                String[] partes = resto.split(",", 2);
                String nombre = partes[0].trim();
                String tipo = partes[1].trim();

                // Los parametros tambien son locales a la funcion
                if (funcActualPasada != null && !funcActualPasada.equals("main")
                        && localesPorFuncion.containsKey(funcActualPasada)) {
                    LinkedHashMap<String, Integer> locales = localesPorFuncion.get(funcActualPasada);
                    if (!locales.containsKey(nombre)) {
                        int frameActual = frameSizePorFuncion.get(funcActualPasada);
                        int offset = -(frameActual + 4);
                        locales.put(nombre, offset);
                        frameSizePorFuncion.put(funcActualPasada, frameActual + 4);
                    }
                }
                if (!simbolosGlobales.containsKey(nombre)) simbolosGlobales.put(nombre, tipo);
                continue;
            }

            // Strings
            Matcher mStr = Pattern.compile("\"([^\"]*)\"").matcher(linea);
            if (mStr.find()) {
                String contenido = mStr.group(1);
                if (!stringsLiterales.containsKey(contenido))
                    stringsLiterales.put(contenido, "str" + contadorStrings++);
            }

            // Temporales del compilador: siempre locales a la funcion actual
            Matcher mTemp = Pattern.compile("^(__[tf]\\d+)\\s*=\\s*(.*)$").matcher(linea);
            if (mTemp.matches()) {
                String nombre = mTemp.group(1);
                String rhs = mTemp.group(2);

                String tipo;
                if (rhs.matches("\"(.*)\"")) tipo = "string";
                else if (rhs.matches("(true|false)")) tipo = "bool";
                else if (rhs.matches("'.'")) tipo = "char";
                else if (rhs.matches("-?\\d+\\.\\d+")) tipo = "float";
                else tipo = nombre.startsWith("__f") ? "float" : "int";

                if (!simbolosGlobales.containsKey(nombre)) simbolosGlobales.put(nombre, tipo);

                // Si estamos en una funcion, el temporal es local
                if (funcActualPasada != null && !funcActualPasada.equals("main")
                        && localesPorFuncion.containsKey(funcActualPasada)) {
                    LinkedHashMap<String, Integer> locales = localesPorFuncion.get(funcActualPasada);
                    if (!locales.containsKey(nombre)) {
                        int frameActual = frameSizePorFuncion.get(funcActualPasada);
                        int offset = -(frameActual + 4);
                        locales.put(nombre, offset);
                        frameSizePorFuncion.put(funcActualPasada, frameActual + 4);
                    }
                }
            }

            // Temporales que aparecen como destino de otras operaciones
            Matcher mDest = Pattern.compile("^(__[tf]\\d+)\\s*=").matcher(linea);
            if (mDest.find()) {
                String nombre = mDest.group(1);
                if (!simbolosGlobales.containsKey(nombre)) simbolosGlobales.put(nombre, "int");
                if (funcActualPasada != null && !funcActualPasada.equals("main")
                        && localesPorFuncion.containsKey(funcActualPasada)) {
                    LinkedHashMap<String, Integer> locales = localesPorFuncion.get(funcActualPasada);
                    if (!locales.containsKey(nombre)) {
                        int frameActual = frameSizePorFuncion.get(funcActualPasada);
                        int offset = -(frameActual + 4);
                        locales.put(nombre, offset);
                        frameSizePorFuncion.put(funcActualPasada, frameActual + 4);
                    }
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

            if (linea.startsWith("declare ")) continue;

            // -----------------------------------------------------------
            // ETIQUETAS
            // -----------------------------------------------------------
            if (linea.endsWith(":") && !linea.contains(" ") && !linea.contains("=")) {
                String etiqueta = linea.substring(0, linea.length() - 1);

                if (!etiqueta.equals("main") && !etiqueta.startsWith("_")) {
                    dentroDeFuncion = true;
                    funcionActual = etiqueta;
                    parametrosPendientes.clear();

                    int frameSize = frameSizePorFuncion.getOrDefault(etiqueta, 0);
                    // frame: 8 bytes para $ra y $fp + espacio para locales
                    int totalFrame = 8 + frameSize;
                    // Alinear a multiplo de 8
                    if (totalFrame % 8 != 0) totalFrame += 4;

                    sb.append(linea).append("\n");
                    sb.append("subu $sp, $sp, ").append(totalFrame).append("\n");
                    sb.append("sw $ra, ").append(totalFrame - 4).append("($sp)\n");
                    sb.append("sw $fp, ").append(totalFrame - 8).append("($sp)\n");
                    sb.append("move $fp, $sp\n");
                    // Guardar totalFrame para el epilogo
                    frameSizePorFuncion.put(etiqueta + "__total", totalFrame);
                } else {
                    if (etiqueta.equals("main")) {
                        dentroDeFuncion = false;
                        funcionActual = null;
                    }
                    sb.append(linea).append("\n");
                }
                continue;
            }

            // -----------------------------------------------------------
            // PARAM (dentro de funcion: recibir argumento)
            // -----------------------------------------------------------
            Matcher mParam = Pattern.compile("^param\\s+(\\S+),\\s*(\\w+(?:\\[\\]\\[\\])?)$").matcher(linea);
            if (mParam.matches()) {
                String parametro = mParam.group(1);
                String tipo = mParam.group(2);

                if (dentroDeFuncion) {
                    // Contar cuantos params ya se recibieron
                    int numParam = parametrosPendientes.size();
                    parametrosPendientes.add(parametro);
                    simbolosGlobales.put(parametro, tipo);

                    if (tipo.equals("float")) {
                        String regFloat = (numParam == 0) ? "$f12" : "$f14";
                        sb.append(storeFloat(regFloat, parametro));
                    } else if (numParam <= 3) {
                        String reg = "$a" + numParam;
                        sb.append(store(reg, parametro));
                    }
                } else {
                    // Pasar argumento antes del call
                    int indice = parametrosPendientes.size();
                    parametrosPendientes.add(parametro);

                    if (tipo.equals("float")) {
                        String regFloat = (indice == 0) ? "$f12" : "$f14";
                        sb.append(loadFloat(regFloat, parametro));
                    } else if (indice <= 3) {
                        sb.append(load("$a" + indice, parametro));
                    }
                }
                continue;
            }

            // -----------------------------------------------------------
            // ESCRITURA EN ARREGLO
            // -----------------------------------------------------------
            Matcher mArrSet = Pattern.compile("^(\\w+)\\[(.+)\\]\\[(.+)\\]\\s*=\\s*(\\S+)$").matcher(linea);
            if (mArrSet.matches()) {
                String arr = mArrSet.group(1);
                String idx1 = mArrSet.group(2);
                String idx2 = mArrSet.group(3);
                String valor = mArrSet.group(4);
                int cols = arregloColumnas.getOrDefault(arr, 1);

                sb.append(esLiteralNumerico(idx1) ? "li $t8, " + idx1 + "\n" : load("$t8", idx1));
                sb.append("li $t9, ").append(cols).append("\n");
                sb.append("mul $t8, $t8, $t9\n");
                sb.append(esLiteralNumerico(idx2) ? "li $t9, " + idx2 + "\n" : load("$t9", idx2));
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

            // -----------------------------------------------------------
            // LECTURA DE ARREGLO
            // -----------------------------------------------------------
            Matcher mArrGet = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)\\[(.+)\\]\\[(.+)\\]$").matcher(linea);
            if (mArrGet.matches()) {
                String destino = mArrGet.group(1);
                String arr = mArrGet.group(2);
                String idx1 = mArrGet.group(3);
                String idx2 = mArrGet.group(4);
                int cols = arregloColumnas.getOrDefault(arr, 1);

                sb.append(esLiteralNumerico(idx1) ? "li $t8, " + idx1 + "\n" : load("$t8", idx1));
                sb.append("li $t9, ").append(cols).append("\n");
                sb.append("mul $t8, $t8, $t9\n");
                sb.append(esLiteralNumerico(idx2) ? "li $t9, " + idx2 + "\n" : load("$t9", idx2));
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

            // -----------------------------------------------------------
            // LITERAL NUMERICO
            // -----------------------------------------------------------
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

            // -----------------------------------------------------------
            // BOOLEANO
            // -----------------------------------------------------------
            Matcher mBool = Pattern.compile("^(\\w+)\\s*=\\s*(true|false)$").matcher(linea);
            if (mBool.matches()) {
                String destino = mBool.group(1);
                sb.append("li $t0, ").append(mBool.group(2).equals("true") ? "1" : "0").append("\n");
                sb.append(store("$t0", destino));
                continue;
            }

            // -----------------------------------------------------------
            // CARACTER
            // -----------------------------------------------------------
            Matcher mChar = Pattern.compile("^(\\w+)\\s*=\\s*'(.)'$").matcher(linea);
            if (mChar.matches()) {
                String destino = mChar.group(1);
                sb.append("li $t0, ").append((int) mChar.group(2).charAt(0)).append("\n");
                sb.append(store("$t0", destino));
                continue;
            }

            // -----------------------------------------------------------
            // STRING LITERAL
            // -----------------------------------------------------------
            Matcher mStrLit = Pattern.compile("^(\\w+)\\s*=\\s*\"(.*)\"$").matcher(linea);
            if (mStrLit.matches()) {
                String destino = mStrLit.group(1);
                String etiqueta = stringsLiterales.get(mStrLit.group(2));
                sb.append("la $t0, ").append(etiqueta).append("\n");
                sb.append(store("$t0", destino));
                continue;
            }

            // -----------------------------------------------------------
            // COPIA SIMPLE
            // -----------------------------------------------------------
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

            // -----------------------------------------------------------
            // GOTO
            // -----------------------------------------------------------
            Matcher mGoto = Pattern.compile("^goto\\s+(\\S+)$").matcher(linea);
            if (mGoto.matches()) { sb.append("j ").append(mGoto.group(1)).append("\n"); continue; }

            // -----------------------------------------------------------
            // IF FALSE GOTO
            // -----------------------------------------------------------
            Matcher mIfFalse = Pattern.compile("^ifFalse\\s+(\\S+)\\s+goto\\s+(\\S+)$").matcher(linea);
            if (mIfFalse.matches()) {
                sb.append(load("$t0", mIfFalse.group(1)));
                sb.append("beq $t0, $zero, ").append(mIfFalse.group(2)).append("\n");
                continue;
            }

            // -----------------------------------------------------------
            // IF TRUE GOTO
            // -----------------------------------------------------------
            Matcher mIfTrue = Pattern.compile("^if\\s+(\\S+)\\s+goto\\s+(\\S+)$").matcher(linea);
            if (mIfTrue.matches()) {
                sb.append(load("$t0", mIfTrue.group(1)));
                sb.append("bne $t0, $zero, ").append(mIfTrue.group(2)).append("\n");
                continue;
            }

            // -----------------------------------------------------------
            // RELACIONALES
            // -----------------------------------------------------------
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
                    sb.append(negar ? "bc1t " : "bc1f ").append(etqFin).append("\n");
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

            // -----------------------------------------------------------
            // LOGICOS BINARIOS
            // -----------------------------------------------------------
            Matcher mLogico = Pattern.compile("^(\\w+)\\s*=\\s*(\\S+)\\s*([@#])\\s*(\\S+)$").matcher(linea);
            if (mLogico.matches()) {
                String destino = mLogico.group(1);
                sb.append(load("$t1", mLogico.group(2)));
                sb.append(load("$t2", mLogico.group(4)));
                sb.append(mLogico.group(3).equals("@") ? "and $t0, $t1, $t2\n" : "or $t0, $t1, $t2\n");
                sb.append(store("$t0", destino));
                continue;
            }

            // -----------------------------------------------------------
            // NOT LOGICO
            // -----------------------------------------------------------
            Matcher mNot = Pattern.compile("^(\\w+)\\s*=\\s*!(\\S+)$").matcher(linea);
            if (mNot.matches()) {
                sb.append(load("$t1", mNot.group(2)));
                sb.append("xori $t0, $t1, 1\n");
                sb.append(store("$t0", mNot.group(1)));
                continue;
            }

            // -----------------------------------------------------------
            // NEGACION ARITMETICA
            // -----------------------------------------------------------
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

            // -----------------------------------------------------------
            // OPERACIONES ARITMETICAS
            // -----------------------------------------------------------
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

            // -----------------------------------------------------------
            // CALL
            // -----------------------------------------------------------
            Matcher mCall = Pattern.compile("^(\\w*)\\s*=\\s*call\\s+(\\w+),\\s*(\\d+)$").matcher(linea);
            if (mCall.matches()) {
                String destino = mCall.group(1);
                String funcion = mCall.group(2);

                // El prologo de la funcion llamada ya guarda $ra y $fp
                sb.append("jal ").append(funcion).append("\n");

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

            // -----------------------------------------------------------
            // RETURN
            // -----------------------------------------------------------
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
                    int totalFrame = frameSizePorFuncion.getOrDefault(funcionActual + "__total", 8);
                    sb.append("lw $ra, ").append(totalFrame - 4).append("($sp)\n");
                    sb.append("lw $fp, ").append(totalFrame - 8).append("($sp)\n");
                    sb.append("addu $sp, $sp, ").append(totalFrame).append("\n");
                    sb.append("jr $ra\n");
                } else {
                    sb.append("li $v0, 10\nsyscall\n");
                }
                continue;
            }

            // -----------------------------------------------------------
            // WRITE
            // -----------------------------------------------------------
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

            // -----------------------------------------------------------
            // READ
            // -----------------------------------------------------------
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

        sb.append("li $v0, 10\nsyscall\n");
        return sb.toString();
    }

    // ===============================================================
    // SECCION .data  (solo variables globales y arreglos)
    // ===============================================================

    static String generarData() {
        StringBuilder sb = new StringBuilder();
        sb.append(".data\n");

        // Solo variables que NO son locales a ninguna funcion
        Set<String> todasLasLocales = new HashSet<>();
        for (LinkedHashMap<String, Integer> locales : localesPorFuncion.values()) {
            todasLasLocales.addAll(locales.keySet());
        }

        for (Map.Entry<String, String> e : simbolosGlobales.entrySet()) {
            String nombre = e.getKey();
            String tipo = e.getValue();
            if (tipo.endsWith("[]")) continue;
            if (todasLasLocales.contains(nombre)) continue; // local al stack

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
            String tipoBase = simbolosGlobales.get(nombre).replace("[]", "");
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