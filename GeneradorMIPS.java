import java.io.*;
import java.util.*;
import java.util.regex.*;

// GeneradorMIPS.java
public class GeneradorMIPS {

    // ===============================================================
    // ESTRUCTURAS DE DATOS PARA LA PRIMERA PASADA
    // ===============================================================

    // nombre de variable/temporal -> tipo ("int", "float", "bool", "char", "string")
    static LinkedHashMap<String, String> simbolos = new LinkedHashMap<>();

    // nombre de variable arreglo -> tamano total en palabras (para arreglos 2D)
    static LinkedHashMap<String, Integer> arreglos = new LinkedHashMap<>();

    // strings literales encontrados -> etiqueta generada (str0, str1, ...)
    static LinkedHashMap<String, String> stringsLiterales = new LinkedHashMap<>();
    static int contadorStrings = 0;

    // Contador para generar etiquetas unicas en comparaciones de punto flotante
    static int contadorCmp = 0;

    // Lineas crudas del archivo de 3D
    static List<String> lineas3D = new ArrayList<>();

    // Mapa de renombrado: nombre original del 3D -> nombre seguro usado en el .asm
    // (solo contiene entradas para los nombres que chocaban con una palabra
    // reservada de MIPS, por ejemplo "b" -> "var_b")
    static Map<String, String> renombrados = new HashMap<>();

    // ===============================================================
    // RENOMBRADO DE IDENTIFICADORES QUE CHOCAN CON PALABRAS RESERVADAS
    // ===============================================================
    // Recorre lineas3D, detecta cualquier identificador definido (ya sea por
    // "declare nombre, tipo" o por una asignacion "nombre = ...") cuyo nombre
    // coincida con un mnemonico de MIPS, y sustituye TODAS sus apariciones en
    // todas las lineas por una version segura (ej. "b" -> "var_b"). Esto debe
    // ejecutarse ANTES de primeraPasada()/segundaPasada(), para que el resto
    // del pipeline nunca vea los nombres conflictivos.
    static void renombrarPalabrasReservadas() {
        // 1. Detectar todos los identificadores definidos en el programa
        Set<String> nombresDetectados = new LinkedHashSet<>();
        for (String linea : lineas3D) {
            if (linea.startsWith("declare ")) {
                String resto = linea.substring("declare ".length());
                String nombre = resto.split(",", 2)[0].trim();
                nombresDetectados.add(nombre);
                continue;
            }
            Matcher mDef = Pattern.compile("^(\\w+)\\s*=").matcher(linea);
            if (mDef.find()) {
                nombresDetectados.add(mDef.group(1));
            }
        }

        // 2. Quedarnos solo con los que en verdad chocan con una palabra
        // reservada, y calcular su nombre seguro
        for (String nombre : nombresDetectados) {
            nombreSeguro(nombre); // registra en "renombrados" si aplica
        }

        // 3. Si no hay ningun choque, no hace falta tocar nada
        boolean hayConflictos = false;
        for (Map.Entry<String, String> e : renombrados.entrySet()) {
            if (!e.getKey().equals(e.getValue())) {
                hayConflictos = true;
                break;
            }
        }
        if (!hayConflictos) return;

        // 4. Sustituir cada nombre conflictivo por su version segura en TODAS
        // las lineas, usando limites de palabra para no afectar coincidencias
        // parciales (por ejemplo, no tocar "tabla" al renombrar "b").
        List<String> lineasCorregidas = new ArrayList<>();
        for (String linea : lineas3D) {
            String nueva = linea;
            for (Map.Entry<String, String> e : renombrados.entrySet()) {
                String original = e.getKey();
                String seguro = e.getValue();
                if (original.equals(seguro)) continue; // no necesitaba cambio
                nueva = nueva.replaceAll("\\b" + Pattern.quote(original) + "\\b", seguro);
            }
            lineasCorregidas.add(nueva);
        }
        lineas3D.clear();
        lineas3D.addAll(lineasCorregidas);
    }

    // ===============================================================
    // PALABRAS RESERVADAS DE MIPS/SPIM
    // ===============================================================
    // Todos los mnemonicos de instrucciones (y pseudo-instrucciones) son
    // identificadores reservados para el ensamblador: no se pueden usar como
    // etiquetas de variables. Si el codigo fuente del usuario declara una
    // variable con uno de estos nombres (el caso clasico es "b", que es el
    // opcode de branch), el ensamblado falla con un syntax error en QtSpim.
    // Esta lista cubre los mnemonicos que mas comunmente chocan con nombres
    // cortos de variables reales.
    static final Set<String> PALABRAS_RESERVADAS_MIPS = new HashSet<>(Arrays.asList(
        // Pseudo-instrucciones y saltos de una sola letra/abreviatura corta
        "b", "j", "jr", "jal", "jalr",
        // Carga/almacenamiento
        "la", "li", "lw", "sw", "lb", "sb", "lh", "sh",
        "l.s", "s.s", "l.d", "s.d", "li.s", "li.d",
        "lui", "move", "mfhi", "mflo", "mfc1", "mtc1",
        // Aritmetica entera
        "add", "addu", "addi", "addiu", "sub", "subu",
        "mul", "mult", "multu", "div", "divu", "neg", "negu",
        "and", "andi", "or", "ori", "xor", "xori", "nor", "not",
        "sll", "srl", "sra", "rem", "abs",
        // Aritmetica de punto flotante
        "add.s", "sub.s", "mul.s", "div.s", "neg.s", "abs.s",
        "add.d", "sub.d", "mul.d", "div.d", "neg.d", "abs.d",
        "mov.s", "mov.d", "cvt.s.w", "cvt.w.s", "cvt.d.w", "cvt.w.d",
        // Comparaciones (set y branch)
        "slt", "slti", "sltu", "sltiu", "sle", "sgt", "sge", "seq", "sne",
        "beq", "bne", "blt", "ble", "bgt", "bge", "beqz", "bnez",
        "bltz", "blez", "bgtz", "bgez",
        "c.lt.s", "c.le.s", "c.eq.s", "c.lt.d", "c.le.d", "c.eq.d",
        "bc1t", "bc1f",
        // Llamadas al sistema y control
        "syscall", "nop", "break", "trap", "eret",
        // Directivas comunes (por si acaso aparecen como nombre)
        "data", "text", "word", "asciiz", "ascii", "byte", "float", "double",
        "globl", "ent", "end", "space", "align", "extern"
    ));

    // Genera un nombre seguro para usar en el .asm: si el nombre original
    // coincide (sin importar mayusculas) con una palabra reservada de MIPS,
    // se le antepone el prefijo "var_"; en caso contrario se deja igual.
    // El resultado se cachea en "renombrados" para que el mismo nombre
    // original siempre produzca el mismo nombre seguro.
    static String nombreSeguro(String nombreOriginal) {
        if (renombrados.containsKey(nombreOriginal)) {
            return renombrados.get(nombreOriginal);
        }
        String seguro = nombreOriginal;
        if (PALABRAS_RESERVADAS_MIPS.contains(nombreOriginal.toLowerCase())) {
            seguro = "var_" + nombreOriginal;
        }
        renombrados.put(nombreOriginal, seguro);
        return seguro;
    }

    // ===============================================================
    // PUNTO DE ENTRADA (uso standalone: java GeneradorMIPS archivo.txt)
    // ===============================================================

    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Uso: java GeneradorMIPS <archivo_codigo_intermedio.txt>");
            return;
        }

        try {
            generar(args[0]);
        } catch (IOException e) {
            System.out.println("Error leyendo el archivo: " + e.getMessage());
        }
    }

    // ===============================================================
    // METODO REUTILIZABLE: genera el .asm a partir del archivo de 3D
    // y devuelve la ruta del archivo .asm creado.
    //
    // Se puede llamar tanto desde main() (uso standalone) como desde
    // Main.java (justo despues de generar el codigo intermedio).
    // No imprime nada en consola; lo unico que importa es el .asm.
    // ===============================================================

    static String generar(String archivoEntrada) throws IOException {
        // Reseteamos el estado por si se llama mas de una vez en el mismo
        // proceso (por ejemplo, si Main.java se reutiliza en pruebas)
        simbolos.clear();
        arreglos.clear();
        stringsLiterales.clear();
        contadorStrings = 0;
        contadorCmp = 0;
        lineas3D.clear();
        renombrados.clear();

        String archivoSalida = archivoEntrada.replaceAll("\\.[^.]+$", "") + ".asm";

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
    // UTILIDADES PARA SABER SI UN OPERANDO ES FLOTANTE
    // ===============================================================

    // Determina si un nombre (variable, temporal o literal) es de tipo float
    static boolean esFloat(String operando) {
        if (simbolos.containsKey(operando)) {
            return simbolos.get(operando).equals("float");
        }
        // Si no esta en la tabla, puede ser un literal numerico: 3.14
        return operando.contains(".");
    }

    // Indica si el string es un literal numerico (no nombre de variable)
    static boolean esLiteralNumerico(String s) {
        return s.matches("-?\\d+(\\.\\d+)?");
    }

    // Genera la instruccion para cargar un operando ENTERO/BOOL/CHAR en el
    // registro indicado: "li $reg, valor" si es un literal numerico puro,
    // o "lw $reg, operando" si es una variable/temporal en memoria.
    // (Para floats se usa l.s directamente, ver los bloques que lo manejan.)
    static String cargarEntero(String registro, String operando) {
        if (esLiteralNumerico(operando) && !operando.contains(".")) {
            return "li " + registro + ", " + operando + "\n";
        } else {
            return "lw " + registro + ", " + operando + "\n";
        }
    }

    // Devuelve el tipo de un operando ("int", "float", "bool", "char", "string")
    // consultando la tabla de simbolos. Si no esta registrado, se infiere por
    // forma (literal numerico con punto -> float, sin punto -> int).
    static String tipoDe(String operando) {
        if (simbolos.containsKey(operando)) {
            return simbolos.get(operando);
        }
        if (esLiteralNumerico(operando)) {
            return operando.contains(".") ? "float" : "int";
        }
        return "int"; // valor por defecto si no se reconoce
    }

    // ===============================================================
    // SEGUNDA PASADA: traduccion de cada linea de 3D a MIPS
    // ===============================================================

    static String segundaPasada() {
        StringBuilder sb = new StringBuilder();

        for (String linea : lineas3D) {

            // Ignoramos las declaraciones (ya se uso en la primera pasada)
            if (linea.startsWith("declare ")) continue;

            // Etiquetas de funcion/main: "nombre:" (sin espacios, termina en ':')
            // Las vemos mas adelante (saltos y funciones), por ahora las dejamos pasar
            if (linea.endsWith(":") && !linea.contains(" ") && !linea.contains("=")) {
                sb.append(linea).append("\n");
                continue;
            }

            // --- ASIGNACION DE LITERAL NUMERICO: "t0 = 5"  o  "f0 = -3.14" ---
            Matcher mLit = Pattern.compile("^(\\w+)\\s*=\\s*(-?\\d+\\.?\\d*)$").matcher(linea);
            if (mLit.matches()) {
                String destino = mLit.group(1);
                String valor = mLit.group(2);
                if (esFloat(destino)) {
                    sb.append("li.s $f0, ").append(valor).append("\n");
                    sb.append("s.s $f0, ").append(destino).append("\n");
                } else {
                    sb.append("li $t0, ").append(valor).append("\n");
                    sb.append("sw $t0, ").append(destino).append("\n");
                }
                continue;
            }

            // --- ASIGNACION DE BOOLEANO: "t0 = true" / "t0 = false" ---
            Matcher mBool = Pattern.compile("^(\\w+)\\s*=\\s*(true|false)$").matcher(linea);
            if (mBool.matches()) {
                String destino = mBool.group(1);
                String valor = mBool.group(2).equals("true") ? "1" : "0";
                sb.append("li $t0, ").append(valor).append("\n");
                sb.append("sw $t0, ").append(destino).append("\n");
                continue;
            }

            // --- ASIGNACION DE CARACTER LITERAL: "t0 = 'a'" ---
            Matcher mChar = Pattern.compile("^(\\w+)\\s*=\\s*'(.)'$").matcher(linea);
            if (mChar.matches()) {
                String destino = mChar.group(1);
                char c = mChar.group(2).charAt(0);
                sb.append("li $t0, ").append((int) c).append("\n");
                sb.append("sw $t0, ").append(destino).append("\n");
                continue;
            }

            // --- ASIGNACION DE STRING LITERAL: 't0 = "Hola"' ---
            Matcher mStrLit = Pattern.compile("^(\\w+)\\s*=\\s*\"(.*)\"$").matcher(linea);
            if (mStrLit.matches()) {
                String destino = mStrLit.group(1);
                String contenido = mStrLit.group(2);
                String etiqueta = stringsLiterales.get(contenido);
                sb.append("la $t0, ").append(etiqueta).append("\n");
                sb.append("sw $t0, ").append(destino).append("\n");
                continue;
            }

            // --- COPIA SIMPLE: "x = t0"  o  "t0 = x" ---
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

            // --- SALTO INCONDICIONAL: "goto L2" ---
            Matcher mGoto = Pattern.compile("^goto\\s+(\\S+)$").matcher(linea);
            if (mGoto.matches()) {
                sb.append("j ").append(mGoto.group(1)).append("\n");
                continue;
            }

            // --- SALTO CONDICIONAL FALSO: "ifFalse t4 goto L0" ---
            Matcher mIfFalse = Pattern.compile("^ifFalse\\s+(\\S+)\\s+goto\\s+(\\S+)$").matcher(linea);
            if (mIfFalse.matches()) {
                String cond = mIfFalse.group(1);
                String etiqueta = mIfFalse.group(2);
                sb.append("lw $t0, ").append(cond).append("\n");
                sb.append("beq $t0, $zero, ").append(etiqueta).append("\n");
                continue;
            }

            // --- SALTO CONDICIONAL VERDADERO: "if t14 goto _case1_1_b" ---
            Matcher mIfTrue = Pattern.compile("^if\\s+(\\S+)\\s+goto\\s+(\\S+)$").matcher(linea);
            if (mIfTrue.matches()) {
                String cond = mIfTrue.group(1);
                String etiqueta = mIfTrue.group(2);
                sb.append("lw $t0, ").append(cond).append("\n");
                sb.append("bne $t0, $zero, ").append(etiqueta).append("\n");
                continue;
            }

            // --- COMPARACIONES RELACIONALES: "t4 = t2 <= t3" ---
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
                    switch (operador) {
                        case "<":  sb.append("c.lt.s $f1, $f2\n"); break;
                        case "<=": sb.append("c.le.s $f1, $f2\n"); break;
                        case ">":  sb.append("c.le.s $f1, $f2\n"); break; // negado abajo
                        case ">=": sb.append("c.lt.s $f1, $f2\n"); break; // negado abajo
                        case "==": sb.append("c.eq.s $f1, $f2\n"); break;
                        case "!=": sb.append("c.eq.s $f1, $f2\n"); break; // negado abajo
                    }
                    boolean negar = operador.equals(">") || operador.equals(">=") || operador.equals("!=");
                    sb.append("li $t0, 0\n");
                    if (negar) {
                        sb.append("bc1t ").append(etqFin).append("\n");
                        sb.append("li $t0, 1\n");
                    } else {
                        sb.append("bc1f ").append(etqFin).append("\n");
                        sb.append("li $t0, 1\n");
                    }
                    sb.append(etqFin).append(":\n");
                    sb.append("sw $t0, ").append(destino).append("\n");
                } else {
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

            // --- OPERADORES LOGICOS BINARIOS: "t6 = t4 @ t5" (AND) / "t6 = t4 # t5" (OR) ---
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

            // --- NEGACION LOGICA (NOT): "t11 = !t10" ---
            Matcher mNot = Pattern.compile("^(\\w+)\\s*=\\s*!(\\S+)$").matcher(linea);
            if (mNot.matches()) {
                String destino = mNot.group(1);
                String op1 = mNot.group(2);
                sb.append(cargarEntero("$t1", op1));
                sb.append("xori $t0, $t1, 1\n"); // invierte 0<->1 (booleano)
                sb.append("sw $t0, ").append(destino).append("\n");
                continue;
            }

            // --- NEGACION ARITMETICA UNARIA: "t3 = - t2" ---
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

            // --- OPERACION ARITMETICA BINARIA: "t2 = t0 + t1" ---
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
                        case "^": sb.append("# TODO potencia (ver mas adelante)\n"); break;
                    }
                    sb.append("sw $t0, ").append(destino).append("\n");
                }
                continue;
            }

            // --- IMPRESION POR PANTALLA: "write t5" ---
            // Usa los syscalls estandar de SPIM/MARS/QtSpim segun el tipo del
            // operando: int/bool -> print_int (1), float -> print_float (2),
            // string -> print_string (4), char -> print_char (11).
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
                        // int y bool se imprimen igual: print_int (bool como 0/1)
                        sb.append("lw $a0, ").append(operando).append("\n");
                        sb.append("li $v0, 1\n");
                        sb.append("syscall\n");
                        break;
                }
                continue;
            }

            // Si no coincide con ningun patron conocido todavia, lo dejamos como
            // comentario para identificarlo facilmente y seguir construyendo
            sb.append("# PENDIENTE: ").append(linea).append("\n");
        }

        // Syscall de salida (exit, codigo 10). Sin esto, QtSpim sigue
        // ejecutando instrucciones mas alla del final de .text y termina
        // lanzando una excepcion de "direccion de instruccion invalida".
        sb.append("li $v0, 10\n");
        sb.append("syscall\n");

        return sb.toString();
    }

    // ===============================================================
    // GENERACION DE LA SECCION .data
    // ===============================================================

    static String generarData() {
        StringBuilder sb = new StringBuilder();
        sb.append(".data\n");

        // 1. Variables y temporales (que no sean arreglos)
        for (Map.Entry<String, String> e : simbolos.entrySet()) {
            String nombre = e.getKey();
            String tipo = e.getValue();

            if (tipo.endsWith("[]")) continue; // los arreglos se manejan aparte

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
                    // El espacio real del string se reserva donde se le asigna
                    // un valor (linea con comillas); aqui solo reservamos un
                    // puntero/placeholder de 4 bytes para la variable string.
                    sb.append(nombre).append(": .word 0\n");
                    break;
                default:
                    sb.append(nombre).append(": .word 0   # tipo desconocido: ").append(tipo).append("\n");
            }
        }

        // 2. Arreglos
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

        // 3. Strings literales
        for (Map.Entry<String, String> e : stringsLiterales.entrySet()) {
            String contenido = e.getKey();
            String etiqueta = e.getValue();
            sb.append(etiqueta).append(": .asciiz \"").append(contenido).append("\"\n");
        }

        sb.append("\n");
        return sb.toString();
    }

    // ===============================================================
    // LECTURA DEL ARCHIVO DE 3D
    // ===============================================================

    static void leerArchivo(String path) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(path));
        String linea;
        while ((linea = br.readLine()) != null) {
            String limpia = linea.trim();
            // Ignorar lineas vacias y los marcadores de inicio/fin de archivo
            if (limpia.isEmpty()) continue;
            if (limpia.startsWith("#")) continue;
            lineas3D.add(limpia);
        }
        br.close();
    }

    // ===============================================================
    // PRIMERA PASADA: recolectar variables, temporales y strings
    // ===============================================================

    static void primeraPasada() {
        for (String linea : lineas3D) {

            // 1. Declaraciones explicitas: "declare nombre, tipo"
            if (linea.startsWith("declare ")) {
                // Ejemplo: declare x, int   |  declare arr, int[1][2]
                String resto = linea.substring("declare ".length());
                String[] partes = resto.split(",", 2);
                String nombre = partes[0].trim();
                String tipo = partes[1].trim();

                if (tipo.contains("[")) {
                    // Es un arreglo: int[1][2] -> dimensiones 1 y 2
                    String tipoBase = tipo.substring(0, tipo.indexOf('['));
                    Matcher m = Pattern.compile("\\[(\\d+)\\]\\[(\\d+)\\]").matcher(tipo);
                    if (m.find()) {
                        int filas = Integer.parseInt(m.group(1));
                        int cols = Integer.parseInt(m.group(2));
                        arreglos.put(nombre, filas * cols);
                        simbolos.put(nombre, tipoBase + "[]"); // marca como arreglo
                    }
                } else {
                    simbolos.put(nombre, tipo);
                }
                continue;
            }

            // 2. Strings literales: cualquier linea con "..." entre comillas
            Matcher mStr = Pattern.compile("\"([^\"]*)\"").matcher(linea);
            if (mStr.find()) {
                String contenido = mStr.group(1);
                if (!stringsLiterales.containsKey(contenido)) {
                    String etiqueta = "str" + contadorStrings++;
                    stringsLiterales.put(contenido, etiqueta);
                }
            }

            // 3. Temporales: t0, t1, f0, f1, etc. (si no fueron declarados
            // arriba con "declare"). Solo se reconocen nombres que sigan
            // estrictamente el patron [tf]\d+ (la convencion de temporales
            // generados por el front-end). Cualquier otra variable interna
            // (como "tsw1" del switch) DEBE llegar con su propio "declare"
            // desde el .cup; si no lo hace, este metodo ya NO la infiere
            // automaticamente, y el .asm resultante mostrara el problema
            // (etiqueta usada pero no declarada) en vez de ocultarlo.
            Matcher mTemp = Pattern.compile("^([tf]\\d+)\\s*=\\s*(.*)$").matcher(linea);
            if (mTemp.matches()) {
                String nombreTemp = mTemp.group(1);
                String ladoDerecho = mTemp.group(2);
                if (!simbolos.containsKey(nombreTemp)) {
                    String tipoInferido;
                    if (ladoDerecho.matches("\"(.*)\"")) {
                        // t3 = "Hola mundo" -> el temporal es de tipo string
                        tipoInferido = "string";
                    } else if (ladoDerecho.matches("(true|false)")) {
                        // t2 = true / t2 = false -> el temporal es booleano
                        tipoInferido = "bool";
                    } else if (ladoDerecho.matches("'.'")) {
                        // t1 = 'a' -> el temporal es char
                        tipoInferido = "char";
                    } else if (ladoDerecho.matches("-?\\d+\\.\\d+")) {
                        // t1 = 3.14 -> literal con punto decimal: float
                        tipoInferido = "float";
                    } else {
                        // Por convencion: nombres que inician con 'f' son float,
                        // cualquier otro (t0, t1, etc.) se asume entero/bool/char
                        tipoInferido = nombreTemp.startsWith("f") ? "float" : "int";
                    }
                    simbolos.put(nombreTemp, tipoInferido);
                }
            }
        }
    }
}