// ===================================================================
// 1. IMPORTACIONES Y CONFIGURACION INICIAL
// ===================================================================

import java.io.*;
import java.util.*;
import java.util.regex.*;

// ===================================================================
// 2. CLASE PRINCIPAL GeneradorMIPS
// ===================================================================

public class GeneradorMIPS {

    // ===============================================================
    // 2.0 ESTRUCTURAS DE DATOS PARA LA PRIMERA PASADA
    // ===============================================================

    // nombre de variable/temporal -> tipo ("int", "float", "bool", "char", "string")
    static LinkedHashMap<String, String> simbolos = new LinkedHashMap<>();

    // nombre de variable arreglo -> tamano total en palabras (para arreglos 2D)
    static LinkedHashMap<String, Integer> arreglos = new LinkedHashMap<>();

    // nombre de variable arreglo -> numero de columnas (necesario para calcular el offset)
    static LinkedHashMap<String, Integer> arregloColumnas = new LinkedHashMap<>();

    // strings literales encontrados -> etiqueta generada (str0, str1, ...)
    static LinkedHashMap<String, String> stringsLiterales = new LinkedHashMap<>();
    static int contadorStrings = 0;

    // Contador para generar etiquetas unicas en comparaciones de punto flotante
    static int contadorCmp = 0;

    // Contador para generar etiquetas unicas en el bucle de potencia (^)
    static int contadorPow = 0;

    // Contador para etiquetas de funciones
    static int contadorFunc = 0;

    // Lineas crudas del archivo de 3D
    static List<String> lineas3D = new ArrayList<>();

    // Mapa de renombrado: nombre original -> nombre seguro usado en el .asm
    static Map<String, String> renombrados = new HashMap<>();

    // Stack frame para funciones
    static LinkedHashMap<String, Integer> offsetsLocales = new LinkedHashMap<>();
    static LinkedHashMap<String, Integer> offsetsParametros = new LinkedHashMap<>();
    static int frameSize = 0;
    static int paramOffset = 0;
    static int localOffset = 0;
    static String funcionActual = null;
    static boolean dentroDeFuncion = false;
    static List<String> parametrosPendientes = new ArrayList<>();

    // ===============================================================
    // 2.1 RENOMBRADO DE IDENTIFICADORES QUE CHOCAN CON PALABRAS RESERVADAS
    // ===============================================================
    // Recorre lineas3D, detecta cualquier identificador definido cuyo nombre
    // coincida con un mnemonico de MIPS, y sustituye TODAS sus apariciones
    // por una version segura (ej. "b" -> "var_b").

    static void renombrarPalabrasReservadas() {
        // Solo detectar nombres que vienen de DECLARACIONES EXPLICITAS del usuario
        Set<String> nombresDeclarados = new LinkedHashSet<>();
        for (String linea : lineas3D) {
            if (linea.startsWith("declare ")) {
                String resto = linea.substring("declare ".length());
                String nombre = resto.split(",", 2)[0].trim();
                nombresDeclarados.add(nombre);
            }
        }

        // Verificar cuales necesitan renombrado
        for (String nombre : nombresDeclarados) {
            nombreSeguro(nombre);
        }

        boolean hayConflictos = false;
        for (Map.Entry<String, String> e : renombrados.entrySet()) {
            if (!e.getKey().equals(e.getValue())) {
                hayConflictos = true;
                break;
            }
        }
        if (!hayConflictos) return;

        // Sustituir en todas las lineas, pero NUNCA dentro de un literal de
        // cadena (texto entre comillas dobles). Sin esto, una palabra como
        // "b" que aparece como texto normal dentro de un string del usuario
        // (ej. "el valor de b es: ") se renombraria por error a "var_b",
        // corrompiendo el contenido real del string.
        List<String> lineasCorregidas = new ArrayList<>();
        for (String linea : lineas3D) {
            lineasCorregidas.add(renombrarFueraDeStrings(linea));
        }
        lineas3D.clear();
        lineas3D.addAll(lineasCorregidas);
    }

    // Aplica el renombrado de "renombrados" solo a los segmentos de la linea
    // que estan FUERA de comillas dobles. Los segmentos entre comillas
    // (literales de cadena) se copian intactos, sin tocarlos.
    static String renombrarFueraDeStrings(String linea) {
        StringBuilder resultado = new StringBuilder();
        Matcher mPartes = Pattern.compile("\"[^\"]*\"|[^\"]+").matcher(linea);
        while (mPartes.find()) {
            String parte = mPartes.group();
            if (parte.startsWith("\"")) {
                // Literal de cadena: se copia tal cual, sin renombrar nada
                resultado.append(parte);
            } else {
                // Fuera de comillas: aqui si se aplica el renombrado
                String nueva = parte;
                for (Map.Entry<String, String> e : renombrados.entrySet()) {
                    String original = e.getKey();
                    String seguro = e.getValue();
                    if (original.equals(seguro)) continue;
                    nueva = nueva.replaceAll("\\b" + Pattern.quote(original) + "\\b", seguro);
                }
                resultado.append(nueva);
            }
        }
        return resultado.toString();
    }

    // ===============================================================
    // 2.2 PALABRAS RESERVADAS DE MIPS/SPIM
    // ===============================================================
    // Todos los mnemonicos de instrucciones (y pseudo-instrucciones) son
    // identificadores reservados para el ensamblador.

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

    // Genera un nombre seguro: si el nombre coincide con una palabra reservada,
    // se le antepone "var_". Los temporales con prefijo "__" (espacio reservado
    // del compilador, ver GeneradorCodigo.nuevoTemp) se excluyen siempre del
    // renombrado, porque por diseno nunca pueden colisionar con un mnemonico
    // de MIPS ni con un identificador de usuario.
    static String nombreSeguro(String nombreOriginal) {
        if (renombrados.containsKey(nombreOriginal)) {
            return renombrados.get(nombreOriginal);
        }
        String seguro = nombreOriginal;
        if (!nombreOriginal.startsWith("__")
                && PALABRAS_RESERVADAS_MIPS.contains(nombreOriginal.toLowerCase())) {
            seguro = "var_" + nombreOriginal;
        }
        renombrados.put(nombreOriginal, seguro);
        return seguro;
    }

    // ===============================================================
    // 2.3 PUNTO DE ENTRADA (uso standalone)
    // ===============================================================

    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Uso: java GeneradorMIPS <archivo_codigo_intermedio.txt>");
            return;
        }
        try {
            String archivoEntrada = args[0];
            String archivoSalida = archivoEntrada.replaceAll("\\.[^.]+$", "") + ".asm";
            generar(archivoEntrada, archivoSalida);
            System.out.println("Archivo MIPS generado: " + archivoSalida);
        } catch (IOException e) {
            System.out.println("Error generando MIPS: " + e.getMessage());
        }
    }

    // ===============================================================
    // 2.4 METODO GENERAR (llamable desde Main.java)
    // ===============================================================
    // Genera el .asm a partir del archivo de 3D y devuelve la ruta del .asm creado.
    // No imprime nada en consola; lo unico que importa es el .asm.

    static String generar(String archivoEntrada, String archivoSalida) throws IOException {
        simbolos.clear();
        arreglos.clear();
        arregloColumnas.clear();
        stringsLiterales.clear();
        contadorStrings = 0;
        contadorCmp = 0;
        contadorPow = 0;
        lineas3D.clear();
        renombrados.clear();
        
        // Limpiar datos de funciones
        offsetsLocales.clear();
        offsetsParametros.clear();
        frameSize = 0;
        paramOffset = 0;
        localOffset = 0;
        funcionActual = null;
        dentroDeFuncion = false;
        parametrosPendientes.clear();

        leerArchivo(archivoEntrada);
        renombrarPalabrasReservadas();
        primeraPasada();

        StringBuilder asm = new StringBuilder();
        asm.append(generarData());
        asm.append(".text\n");
        asm.append(".globl main\n");
        asm.append(segundaPasada());

        BufferedWriter bw = new BufferedWriter(new FileWriter(archivoSalida));
        bw.write(asm.toString());
        bw.close();

        return archivoSalida;
    }

    // ===============================================================
    // 2.5 UTILIDADES PARA TIPOS
    // ===============================================================

    static boolean esFloat(String operando) {
        if (simbolos.containsKey(operando)) {
            return simbolos.get(operando).equals("float");
        }
        return operando.contains(".");
    }

    static boolean esLiteralNumerico(String s) {
        return s.matches("-?\\d+(\\.\\d+)?");
    }

    static String cargarEntero(String registro, String operando) {
        if (esLiteralNumerico(operando) && !operando.contains(".")) {
            return "li " + registro + ", " + operando + "\n";
        } else {
            return "lw " + registro + ", " + operando + "\n";
        }
    }

    static String tipoDe(String operando) {

        // ---------------------------------------------------------------
        // 1. DETECTAR ACCESO A ARREGLO: "mat[0][0]" o "mat[i][j]"
        // ---------------------------------------------------------------
        Matcher mArr = Pattern.compile("^(\\w+)\\[.*\\]\\[.*\\]$").matcher(operando);
        if (mArr.matches()) {
            String nombreArr = mArr.group(1);
            if (simbolos.containsKey(nombreArr)) {
                String tipoArr = simbolos.get(nombreArr);
                if (tipoArr.endsWith("[]")) {
                    String resultado = tipoArr.replace("[]", "");
                    return resultado;
                }
                return tipoArr;
            }
            // Sin registro en la tabla de simbolos: inferir por el prefijo del
            // TEMPORAL DEL COMPILADOR (no de un identificador de usuario), que
            // siempre empieza con "__". Si no matchea, se asume int por defecto.
            if (nombreArr.startsWith("__f")) {
                return "float";
            }
            return "int";
        }

        // ---------------------------------------------------------------
        // 2. BUSCAR EN TABLA DE SIMBOLOS
        // ---------------------------------------------------------------
        if (simbolos.containsKey(operando)) {
            String resultado = simbolos.get(operando);
            return resultado;
        }

        // ---------------------------------------------------------------
        // 3. LITERALES NUMERICOS
        // ---------------------------------------------------------------
        if (esLiteralNumerico(operando)) {
            String resultado = operando.contains(".") ? "float" : "int";
            return resultado;
        }

        return "int";
    }

    // ===============================================================
    // 2.6 PRIMERA PASADA: recolectar variables, temporales y strings
    // ===============================================================

    static void primeraPasada() {
        for (String linea : lineas3D) {

            // ---------------------------------------------------------------
            // 2.6.1 DECLARACIONES EXPLICITAS: "declare nombre, tipo"
            // ---------------------------------------------------------------
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
                    String tipoActual = simbolos.get(nombre);
                    if (tipoActual == null || 
                        (!tipoActual.equals("string") && !tipoActual.equals("char") && !tipoActual.equals("bool"))) {
                        simbolos.put(nombre, tipo);
                    }
                }
                continue;
            }

            // ---------------------------------------------------------------
            // DETECTAR ASIGNACION DE ARREGLO: "__t8 = mat[0][0]"
            // ---------------------------------------------------------------
            Matcher mArrAsign = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)\\[.*\\]\\[.*\\]$").matcher(linea);
            if (mArrAsign.matches()) {
                String temp = mArrAsign.group(1);
                String arr = mArrAsign.group(2);
                if (!simbolos.containsKey(temp) && simbolos.containsKey(arr)) {
                    String tipoArr = simbolos.get(arr);
                    if (tipoArr.endsWith("[]")) {
                        String tipoBase = tipoArr.replace("[]", "");
                        simbolos.put(temp, tipoBase);
                    } else {
                        simbolos.put(temp, tipoArr);
                    }
                }
                continue;
            }

            // ---------------------------------------------------------------
            // 2.6.2 STRINGS LITERALES: cualquier linea con "..."
            // ---------------------------------------------------------------
            Matcher mStr = Pattern.compile("\"([^\"]*)\"").matcher(linea);
            if (mStr.find()) {
                String contenido = mStr.group(1);
                if (!stringsLiterales.containsKey(contenido)) {
                    String etiqueta = "str" + contadorStrings++;
                    stringsLiterales.put(contenido, etiqueta);
                }
            }

            // ---------------------------------------------------------------
            // 2.6.3 TEMPORALES DEL COMPILADOR: __t0, __t1, __f0, __f1, etc.
            // ---------------------------------------------------------------
            // El prefijo "__" (doble guion bajo) es el espacio de nombres
            // reservado para temporales generados automaticamente por
            // GeneradorCodigo.nuevoTemp(). Esto evita que choquen con
            // variables de usuario que el programador puede nombrar
            // libremente, incluyendo nombres como "t5" o "f2" (misma
            // convencion que usa C#: identificadores con "__" se reservan
            // para nombres generados por el compilador). Variables internas
            // que no sigan este patron (ej. tswN del switch) requieren su
            // propio "declare" explicito.
            Matcher mTemp = Pattern.compile("^(__[tf]\\d+)\\s*=\\s*(.*)$").matcher(linea);
            if (mTemp.matches()) {
                String nombreTemp = mTemp.group(1);
                String ladoDerecho = mTemp.group(2);
                if (!simbolos.containsKey(nombreTemp)) {
                    String tipoInferido;
                    if (ladoDerecho.matches("\"(.*)\"")) {
                        tipoInferido = "string";
                    } else if (ladoDerecho.matches("(true|false)")) {
                        tipoInferido = "bool";
                    } else if (ladoDerecho.matches("'.'")) {
                        tipoInferido = "char";
                    } else if (ladoDerecho.matches("-?\\d+\\.\\d+")) {
                        tipoInferido = "float";
                    } else {
                        tipoInferido = nombreTemp.startsWith("__f") ? "float" : "int";
                    }
                    simbolos.put(nombreTemp, tipoInferido);
                }
            }
        }
    }

    // ===============================================================
    // 2.7 SEGUNDA PASADA: traduccion de cada linea de 3D a MIPS
    // ===============================================================

    static String segundaPasada() {
        StringBuilder sb = new StringBuilder();
        
        // Reiniciar estado de funciones
        dentroDeFuncion = false;
        funcionActual = null;
        parametrosPendientes.clear();

        for (String linea : lineas3D) {

            if (linea.startsWith("declare ")) continue;

            // ---------------------------------------------------------------
            // DETECTAR FUNCIONES CON PRÓLOGO MEJORADO
            // ---------------------------------------------------------------
            if (linea.endsWith(":") && !linea.contains(" ") && !linea.contains("=")) {
                String etiqueta = linea.substring(0, linea.length() - 1);
                
                // Si es una función (no es main)
                if (!etiqueta.equals("main") && !etiqueta.startsWith("L")) {
                    dentroDeFuncion = true;
                    funcionActual = etiqueta;
                    frameSize = 0;
                    localOffset = 0;
                    paramOffset = 0;
                    offsetsLocales.clear();
                    offsetsParametros.clear();
                    parametrosPendientes.clear();
                    
                    // PRÓLOGO MEJORADO
                    sb.append(linea).append("\n");
                    sb.append("subu $sp, $sp, 8\n");     // Espacio para $ra y $fp
                    sb.append("sw $ra, 4($sp)\n");       // Guardar $ra
                    sb.append("sw $fp, 0($sp)\n");       // Guardar $fp
                    sb.append("move $fp, $sp\n");        // $fp = $sp (frame pointer)
                    continue;
                }
                
                sb.append(linea).append("\n");
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.1 ESCRITURA EN ELEMENTO DE ARREGLO: "arr[i][j] = valor"
            // ---------------------------------------------------------------
            Matcher mArrSet = Pattern.compile("^(\\w+)\\[(.+)\\]\\[(.+)\\]\\s*=\\s*(\\S+)$").matcher(linea);
            if (mArrSet.matches()) {
                String arr = mArrSet.group(1);
                String idx1 = mArrSet.group(2);
                String idx2 = mArrSet.group(3);
                String valor = mArrSet.group(4);
                int cols = arregloColumnas.getOrDefault(arr, 1);

                sb.append(cargarEntero("$t8", idx1));
                sb.append("li $t9, ").append(cols).append("\n");
                sb.append("mul $t8, $t8, $t9\n");
                sb.append(cargarEntero("$t9", idx2));
                sb.append("add $t8, $t8, $t9\n");
                sb.append("sll $t8, $t8, 2\n");
                sb.append("la $t9, ").append(arr).append("\n");
                sb.append("add $t9, $t9, $t8\n");

                if (esFloat(arr) || esFloat(valor)) {
                    sb.append("l.s $f0, ").append(valor).append("\n");
                    sb.append("s.s $f0, 0($t9)\n");
                } else {
                    sb.append(cargarEntero("$t0", valor));
                    sb.append("sw $t0, 0($t9)\n");
                }
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.2 LECTURA DE ELEMENTO DE ARREGLO: "__t5 = arr[i][j]"
            // ---------------------------------------------------------------
            Matcher mArrGet = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)\\[(.+)\\]\\[(.+)\\]$").matcher(linea);
            if (mArrGet.matches()) {
                String destino = mArrGet.group(1);
                String arr = mArrGet.group(2);
                String idx1 = mArrGet.group(3);
                String idx2 = mArrGet.group(4);
                int cols = arregloColumnas.getOrDefault(arr, 1);

                sb.append(cargarEntero("$t8", idx1));
                sb.append("li $t9, ").append(cols).append("\n");
                sb.append("mul $t8, $t8, $t9\n");
                sb.append(cargarEntero("$t9", idx2));
                sb.append("add $t8, $t8, $t9\n");
                sb.append("sll $t8, $t8, 2\n");
                sb.append("la $t9, ").append(arr).append("\n");
                sb.append("add $t9, $t9, $t8\n");

                if (esFloat(arr) || esFloat(destino)) {
                    sb.append("l.s $f0, 0($t9)\n");
                    sb.append("s.s $f0, ").append(destino).append("\n");
                } else {
                    sb.append("lw $t0, 0($t9)\n");
                    sb.append("sw $t0, ").append(destino).append("\n");
                }
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.3 ASIGNACION DE LITERALES (numeros, booleanos, caracteres, strings)
            // ---------------------------------------------------------------
            Matcher mLit = Pattern.compile("^([\\w_]+)\\s*=\\s*(-?\\d+(\\.\\d+)?)$").matcher(linea);
            if (mLit.matches()) {
                String destino = mLit.group(1);
                String valor = mLit.group(2);
                
                // Determinar si es float (tiene punto decimal o el destino es float)
                boolean esFloatLiteral = valor.contains(".");
                
                if (esFloatLiteral || esFloat(destino)) {
                    // Si el destino es float o el literal tiene punto
                    sb.append("li.s $f0, ").append(valor).append("\n");
                    sb.append("s.s $f0, ").append(destino).append("\n");
                } else {
                    // Literal entero
                    sb.append("li $t0, ").append(valor).append("\n");
                    sb.append("sw $t0, ").append(destino).append("\n");
                }
                continue;
            }

            Matcher mBool = Pattern.compile("^(\\w+)\\s*=\\s*(true|false)$").matcher(linea);
            if (mBool.matches()) {
                String destino = mBool.group(1);
                String valor = mBool.group(2).equals("true") ? "1" : "0";
                sb.append("li $t0, ").append(valor).append("\n");
                sb.append("sw $t0, ").append(destino).append("\n");
                continue;
            }

            Matcher mChar = Pattern.compile("^(\\w+)\\s*=\\s*'(.)'$").matcher(linea);
            if (mChar.matches()) {
                String destino = mChar.group(1);
                char c = mChar.group(2).charAt(0);
                sb.append("li $t0, ").append((int) c).append("\n");
                sb.append("sw $t0, ").append(destino).append("\n");
                continue;
            }

            Matcher mStrLit = Pattern.compile("^(\\w+)\\s*=\\s*\"(.*)\"$").matcher(linea);
            if (mStrLit.matches()) {
                String destino = mStrLit.group(1);
                String contenido = mStrLit.group(2);
                String etiqueta = stringsLiterales.get(contenido);
                sb.append("la $t0, ").append(etiqueta).append("\n");
                sb.append("sw $t0, ").append(destino).append("\n");
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.4 COPIA SIMPLE: "x = __t0"
            // ---------------------------------------------------------------
            Matcher mCopia = Pattern.compile("^(\\w+)\\s*=\\s*(\\w+)$").matcher(linea);
            if (mCopia.matches()) {
                String destino = mCopia.group(1);
                String origen = mCopia.group(2);
                if (esFloat(destino) || esFloat(origen)) {
                    sb.append("l.s $f0, ").append(origen).append("\n");
                    sb.append("s.s $f0, ").append(destino).append("\n");
                } else {
                    sb.append("lw $t0, ").append(origen).append("\n");
                    sb.append("sw $t0, ").append(destino).append("\n");
                }
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.5 SALTOS (goto, ifFalse, if)
            // ---------------------------------------------------------------
            Matcher mGoto = Pattern.compile("^goto\\s+(\\S+)$").matcher(linea);
            if (mGoto.matches()) {
                sb.append("j ").append(mGoto.group(1)).append("\n");
                continue;
            }

            Matcher mIfFalse = Pattern.compile("^ifFalse\\s+(\\S+)\\s+goto\\s+(\\S+)$").matcher(linea);
            if (mIfFalse.matches()) {
                String cond = mIfFalse.group(1);
                String etiqueta = mIfFalse.group(2);
                sb.append("lw $t0, ").append(cond).append("\n");
                sb.append("beq $t0, $zero, ").append(etiqueta).append("\n");
                continue;
            }

            Matcher mIfTrue = Pattern.compile("^if\\s+(\\S+)\\s+goto\\s+(\\S+)$").matcher(linea);
            if (mIfTrue.matches()) {
                String cond = mIfTrue.group(1);
                String etiqueta = mIfTrue.group(2);
                sb.append("lw $t0, ").append(cond).append("\n");
                sb.append("bne $t0, $zero, ").append(etiqueta).append("\n");
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.6 COMPARACIONES RELACIONALES: "__t4 = __t2 <= __t3"
            // ---------------------------------------------------------------
            Matcher mRel = Pattern.compile("^(\\w+)\\s*=\\s*(\\S+)\\s*(<=|>=|==|!=|<|>)\\s*(\\S+)$").matcher(linea);
            if (mRel.matches()) {
                String destino = mRel.group(1);
                String op1 = mRel.group(2);
                String operador = mRel.group(3);
                String op2 = mRel.group(4);

                boolean flotante = esFloat(op1) || esFloat(op2);

                if (flotante) {
                    sb.append("l.s $f1, ").append(op1).append("\n");
                    sb.append("l.s $f2, ").append(op2).append("\n");
                    String etqTrue = "_cmp" + (contadorCmp++);
                    String etqFin = "_cmp" + (contadorCmp++);
                    
                    // ---------------------------------------------------------------
                    // COMPARACIONES DE PUNTO FLOTANTE CORREGIDAS
                    // ---------------------------------------------------------------
                    // Para float, las instrucciones son:
                    // - c.lt.s $f1, $f2  -> 1 si $f1 < $f2
                    // - c.le.s $f1, $f2  -> 1 si $f1 <= $f2
                    // - c.eq.s $f1, $f2  -> 1 si $f1 == $f2
                    //
                    // Para > y >= hay que invertir los operandos:
                    // - a > b  ->  b < a   -> c.lt.s $f2, $f1
                    // - a >= b ->  b <= a  -> c.le.s $f2, $f1
                    // ---------------------------------------------------------------
                    switch (operador) {
                        case "<":  
                            sb.append("c.lt.s $f1, $f2\n");   // $f1 < $f2
                            break;
                        case "<=": 
                            sb.append("c.le.s $f1, $f2\n");   // $f1 <= $f2
                            break;
                        case ">":  
                            sb.append("c.lt.s $f2, $f1\n");   // $f2 < $f1
                            break;
                        case ">=": 
                            sb.append("c.le.s $f2, $f1\n");   // $f2 <= $f1 
                            break;
                        case "==": 
                            sb.append("c.eq.s $f1, $f2\n");   // $f1 == $f2
                            break;
                        case "!=": 
                            sb.append("c.eq.s $f1, $f2\n");   // $f1 == $f2 
                            break;
                    }
                    
                    // Para >, >=, != hay que negar el resultado
                    boolean negar = operador.equals(">") || operador.equals(">=") || operador.equals("!=");
                    
                    // Inicializar resultado a 0 (falso)
                    sb.append("li $t0, 0\n");
                    
                    if (negar) {
                        // Si la condición es verdadera, saltar al final (mantener 0)
                        // Si es falsa, poner 1 
                        sb.append("bc1t ").append(etqFin).append("\n");
                        sb.append("li $t0, 1\n");
                    } else {
                        // Si la condición es falsa, saltar al final (mantener 0)
                        // Si es verdadera, poner 1
                        sb.append("bc1f ").append(etqFin).append("\n");
                        sb.append("li $t0, 1\n");
                    }
                    sb.append(etqFin).append(":\n");
                    sb.append("sw $t0, ").append(destino).append("\n");
                } else {
                    // Comparaciones para enteros 
                    sb.append(cargarEntero("$t1", op1));
                    sb.append(cargarEntero("$t2", op2));
                    switch (operador) {
                        case "<":  sb.append("slt $t0, $t1, $t2\n"); break;
                        case "<=": sb.append("sle $t0, $t1, $t2\n"); break;
                        case ">":  sb.append("sgt $t0, $t1, $t2\n"); break;
                        case ">=": sb.append("sge $t0, $t1, $t2\n"); break;
                        case "==": sb.append("seq $t0, $t1, $t2\n"); break;
                        case "!=": sb.append("sne $t0, $t1, $t2\n"); break;
                    }
                    sb.append("sw $t0, ").append(destino).append("\n");
                }
                continue;
            }


            // ---------------------------------------------------------------
            // 2.7.7 OPERADORES LOGICOS BINARIOS: "@" (AND), "#" (OR)
            // ---------------------------------------------------------------
            Matcher mLogico = Pattern.compile("^(\\w+)\\s*=\\s*(\\S+)\\s*([@#])\\s*(\\S+)$").matcher(linea);
            if (mLogico.matches()) {
                String destino = mLogico.group(1);
                String op1 = mLogico.group(2);
                String operador = mLogico.group(3);
                String op2 = mLogico.group(4);

                sb.append(cargarEntero("$t1", op1));
                sb.append(cargarEntero("$t2", op2));
                if (operador.equals("@")) {
                    sb.append("and $t0, $t1, $t2\n");
                } else {
                    sb.append("or $t0, $t1, $t2\n");
                }
                sb.append("sw $t0, ").append(destino).append("\n");
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.8 NEGACION LOGICA: "__t11 = !__t10"
            // ---------------------------------------------------------------
            Matcher mNot = Pattern.compile("^(\\w+)\\s*=\\s*!(\\S+)$").matcher(linea);
            if (mNot.matches()) {
                String destino = mNot.group(1);
                String op1 = mNot.group(2);
                sb.append(cargarEntero("$t1", op1));
                sb.append("xori $t0, $t1, 1\n");
                sb.append("sw $t0, ").append(destino).append("\n");
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.9 NEGACION ARITMETICA: "__t3 = - __t2"
            // ---------------------------------------------------------------
            Matcher mNeg = Pattern.compile("^(\\w+)\\s*=\\s*-\\s*(\\S+)$").matcher(linea);
            if (mNeg.matches()) {
                String destino = mNeg.group(1);
                String op1 = mNeg.group(2);
                if (esFloat(destino) || esFloat(op1)) {
                    sb.append("l.s $f1, ").append(op1).append("\n");
                    sb.append("neg.s $f0, $f1\n");
                    sb.append("s.s $f0, ").append(destino).append("\n");
                } else {
                    sb.append(cargarEntero("$t1", op1));
                    sb.append("sub $t0, $zero, $t1\n");
                    sb.append("sw $t0, ").append(destino).append("\n");
                }
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.10 OPERACIONES ARITMETICAS: "+", "-", "*", "/", "%", "^"
            // ---------------------------------------------------------------
            Matcher mOp = Pattern.compile("^(\\w+)\\s*=\\s*(\\S+)\\s*([+\\-*/%^])\\s*(\\S+)$").matcher(linea);
            if (mOp.matches()) {
                String destino = mOp.group(1);
                String op1 = mOp.group(2);
                String operador = mOp.group(3);
                String op2 = mOp.group(4);

                boolean flotante = esFloat(destino) || esFloat(op1) || esFloat(op2);

                if (flotante) {
                    sb.append("l.s $f1, ").append(op1).append("\n");
                    sb.append("l.s $f2, ").append(op2).append("\n");
                    switch (operador) {
                        case "+": sb.append("add.s $f0, $f1, $f2\n"); break;
                        case "-": sb.append("sub.s $f0, $f1, $f2\n"); break;
                        case "*": sb.append("mul.s $f0, $f1, $f2\n"); break;
                        case "/": sb.append("div.s $f0, $f1, $f2\n"); break;
                    }
                    sb.append("s.s $f0, ").append(destino).append("\n");
                } else {
                    sb.append(cargarEntero("$t1", op1));
                    sb.append(cargarEntero("$t2", op2));
                    switch (operador) {
                        case "+": sb.append("add $t0, $t1, $t2\n"); break;
                        case "-": sb.append("sub $t0, $t1, $t2\n"); break;
                        case "*": sb.append("mul $t0, $t1, $t2\n"); break;
                        case "/": sb.append("div $t1, $t2\n"); sb.append("mflo $t0\n"); break;
                        case "%": sb.append("div $t1, $t2\n"); sb.append("mfhi $t0\n"); break;
                        case "^":
                            // Potencia: bucle que multiplica la base por si misma
                            String etqInicio = "_pow" + (contadorPow++) + "_start";
                            String etqFin = "_pow" + (contadorPow++) + "_end";
                            sb.append("li $t0, 1\n");
                            sb.append(etqInicio).append(":\n");
                            sb.append("blez $t2, ").append(etqFin).append("\n");
                            sb.append("mul $t0, $t0, $t1\n");
                            sb.append("addi $t2, $t2, -1\n");
                            sb.append("j ").append(etqInicio).append("\n");
                            sb.append(etqFin).append(":\n");
                            break;
                    }
                    sb.append("sw $t0, ").append(destino).append("\n");
                }
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.11 PARAM - Pasar parámetro a función
            // ---------------------------------------------------------------
            Matcher mParam = Pattern.compile("^param\\s+(\\S+),\\s*(\\w+)$").matcher(linea);
            if (mParam.matches()) {
                String parametro = mParam.group(1);
                String tipo = mParam.group(2);
                
                if (dentroDeFuncion) {
                    // Es un parámetro de la función actual
                    offsetsParametros.put(parametro, paramOffset);
                    paramOffset += 4;  // Cada parámetro ocupa 4 bytes
                    frameSize += 4;
                    
                    // El parámetro se pasa en $a0-$a3, guardarlo en el stack frame
                    int numParam = offsetsParametros.size();
                    if (numParam <= 4) {
                        // Usar $a0-$a3
                        String reg = "$a" + (numParam - 1);
                        if (tipo.equals("float")) {
                            sb.append("s.s ").append(reg).append(", ").append(parametro).append("\n");
                        } else {
                            sb.append("sw ").append(reg).append(", ").append(parametro).append("\n");
                        }
                    }
                    
                    // Registrar el parámetro en la tabla de símbolos
                    simbolos.put(parametro, tipo);
                } else {
                    // Es un parámetro para una llamada a función
                    parametrosPendientes.add(parametro);
                    
                    // Cargar en $a0-$a3
                    if (tipo.equals("float")) {
                        sb.append("l.s $f12, ").append(parametro).append("\n");
                    } else {
                        sb.append("lw $a0, ").append(parametro).append("\n");
                    }
                }
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.12 CALL - Llamada a función
            // ---------------------------------------------------------------
            Matcher mCall = Pattern.compile("^(\\w*)\\s*=\\s*call\\s+(\\w+),\\s*(\\d+)$").matcher(linea);
            if (mCall.matches()) {
                String destino = mCall.group(1);
                String funcion = mCall.group(2);
                int numParams = Integer.parseInt(mCall.group(3));
                
                // Guardar $ra y $fp en el stack
                sb.append("subu $sp, $sp, 8\n");
                sb.append("sw $ra, 4($sp)\n");
                sb.append("sw $fp, 0($sp)\n");
                
                // Llamar a la función
                sb.append("jal ").append(funcion).append("\n");
                
                // Restaurar $ra y $fp
                sb.append("lw $fp, 0($sp)\n");
                sb.append("lw $ra, 4($sp)\n");
                sb.append("addu $sp, $sp, 8\n");
                
                // Guardar el valor de retorno
                if (!destino.isEmpty()) {
                    String tipoDest = tipoDe(destino);
                    if (tipoDest.equals("float")) {
                        sb.append("s.s $f0, ").append(destino).append("\n");
                    } else {
                        sb.append("sw $v0, ").append(destino).append("\n");
                    }
                }
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.13 RETURN - Retornar de función
            // ---------------------------------------------------------------
            Matcher mReturn = Pattern.compile("^return\\s*(\\S*)$").matcher(linea);
            if (mReturn.matches()) {
                String valor = mReturn.group(1);
                
                if (!valor.isEmpty()) {
                    // Return con valor
                    if (esFloat(valor)) {
                        sb.append("l.s $f0, ").append(valor).append("\n");
                    } else {
                        sb.append("lw $v0, ").append(valor).append("\n");
                    }
                }
                
                // EPÍLOGO MEJORADO
                if (dentroDeFuncion && funcionActual != null) {
                    sb.append("lw $fp, 0($sp)\n");      // Restaurar $fp
                    sb.append("lw $ra, 4($sp)\n");      // Restaurar $ra
                    sb.append("addu $sp, $sp, 8\n");    // Liberar frame
                    sb.append("jr $ra\n");              // Retornar
                    dentroDeFuncion = false;
                    funcionActual = null;
                } else {
                    // Return en main
                    sb.append("li $v0, 10\n");
                    sb.append("syscall\n");
                }
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.14 IMPRESION POR PANTALLA: "write __t5"
            // ---------------------------------------------------------------
            Matcher mWrite = Pattern.compile("^write\\s+(\\S+)$").matcher(linea);
            if (mWrite.matches()) {
                String operando = mWrite.group(1);
                String tipo = tipoDe(operando);

                switch (tipo) {
                    case "float":
                        sb.append("l.s $f12, ").append(operando).append("\n");
                        sb.append("li $v0, 2\n");
                        sb.append("syscall\n");
                        break;
                    case "string":
                        sb.append("lw $a0, ").append(operando).append("\n");
                        sb.append("li $v0, 4\n");
                        sb.append("syscall\n");
                        break;
                    case "char":
                        sb.append("lw $a0, ").append(operando).append("\n");
                        sb.append("li $v0, 11\n");
                        sb.append("syscall\n");
                        break;
                    default:
                        sb.append("lw $a0, ").append(operando).append("\n");
                        sb.append("li $v0, 1\n");
                        sb.append("syscall\n");
                        break;
                }
                continue;
            }

            // ---------------------------------------------------------------
            // 2.7.15 LECTURA DE CONSOLA: "read x"
            // ---------------------------------------------------------------
            Matcher mRead = Pattern.compile("^read\\s+(\\S+)$").matcher(linea);
            if (mRead.matches()) {
                String variable = mRead.group(1);
                String tipo = tipoDe(variable);

                if (tipo.equals("float")) {
                    sb.append("li $v0, 6\n");
                    sb.append("syscall\n");
                    sb.append("s.s $f0, ").append(variable).append("\n");
                } else {
                    // int (bool y char tambien leen como entero)
                    sb.append("li $v0, 5\n");
                    sb.append("syscall\n");
                    sb.append("sw $v0, ").append(variable).append("\n");
                }
                continue;
            }

            sb.append("# PENDIENTE: ").append(linea).append("\n");
        }

        // Si estamos dentro de una función y no hay return, agregar epílogo
        if (dentroDeFuncion && funcionActual != null) {
            sb.append("lw $fp, 0($sp)\n");
            sb.append("lw $ra, 4($sp)\n");
            sb.append("addu $sp, $sp, 8\n");
            sb.append("jr $ra\n");
            dentroDeFuncion = false;
            funcionActual = null;
        }

        sb.append("li $v0, 10\n");
        sb.append("syscall\n");

        return sb.toString();
    }

    // ===============================================================
    // 2.8 GENERACION DE LA SECCION .data
    // ===============================================================

    static String generarData() {
        StringBuilder sb = new StringBuilder();
        sb.append(".data\n");

        for (Map.Entry<String, String> e : simbolos.entrySet()) {
            String nombre = e.getKey();
            String tipo = e.getValue();

            if (tipo.endsWith("[]")) continue;

            switch (tipo) {
                case "int":
                case "bool":
                case "char":
                    sb.append(nombre).append(": .word 0\n");
                    break;
                case "float":
                    sb.append(nombre).append(": .float 0.0\n");
                    break;
                case "string":
                    sb.append(nombre).append(": .word 0\n");
                    break;
                default:
                    sb.append(nombre).append(": .word 0   # tipo desconocido: ").append(tipo).append("\n");
            }
        }

        for (Map.Entry<String, Integer> e : arreglos.entrySet()) {
            String nombre = e.getKey();
            int total = e.getValue();
            String tipoBase = simbolos.get(nombre).replace("[]", "");
            if (tipoBase.equals("float")) {
                sb.append(nombre).append(": .float ");
                for (int i = 0; i < total; i++) {
                    sb.append("0.0");
                    if (i < total - 1) sb.append(", ");
                }
                sb.append("\n");
            } else {
                sb.append(nombre).append(": .word 0:").append(total).append("\n");
            }
        }

        for (Map.Entry<String, String> e : stringsLiterales.entrySet()) {
            String contenido = e.getKey();
            String etiqueta = e.getValue();
            sb.append(etiqueta).append(": .asciiz \"").append(contenido).append("\"\n");
        }

        sb.append("\n");
        return sb.toString();
    }

    // ===============================================================
    // 2.9 LECTURA DEL ARCHIVO DE 3D
    // ===============================================================

    static void leerArchivo(String path) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(path));
        String linea;
        while ((linea = br.readLine()) != null) {
            String limpia = linea.trim();
            if (limpia.isEmpty()) continue;
            if (limpia.startsWith("#")) continue;
            lineas3D.add(limpia);
        }
        br.close();
    }
}