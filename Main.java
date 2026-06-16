import java.io.*;

public class Main {

    public static final String ANSI_RESET = "\u001B[0m";
    public static final String ANSI_RED = "\u001B[31m";
    public static final String ANSI_GREEN = "\u001B[32m";
    public static final String ANSI_BLUE = "\u001B[34m";
    public static final String ANSI_DARK_BLUE = "\u001B[34;2m";
    public static final String ANSI_RED_BRIGHT = "\u001B[91m";

    public static void main(String[] args) throws Exception {
        
        if (args.length < 1) {
            System.out.println("Uso: java Main <archivo>");
            return;
        }

        // Nombre base del archivo (sin extension)
        String nombreBase = args[0].contains(".") ? args[0].substring(0, args[0].lastIndexOf('.')) : args[0];
        String archivoTokens = nombreBase + "_tokens.txt";
        String archivoIntermedio = nombreBase + "_codigo_intermedio.txt";

        // ===============================================================
        // PRIMER PASO: ANALISIS LEXICO SILENCIADO
        // ===============================================================
        
        Lexer.silenciarErrores = true;
        Lexer lexerTokens = new Lexer(new FileReader(args[0]));
        PrintWriter tokenWriter = new PrintWriter(new FileWriter(archivoTokens));
        
        tokenWriter.println("=== TOKENS ENCONTRADOS ===\n");
        tokenWriter.println(String.format("%-25s %-20s %s", "Token", "Lexema", "Linea"));
        tokenWriter.println(String.format("%-25s %-20s %s", "-----", "------", "-----"));

        java_cup.runtime.Symbol token;
        while ((token = lexerTokens.next_token()).sym != sym.EOF) {
            String nombreToken = sym.terminalNames[token.sym];
            String valor = token.value != null ? token.value.toString() : "";
            int linea = token.left;
            tokenWriter.println(String.format("%-25s %-20s %d", nombreToken, valor, linea));
        }

        tokenWriter.println("\n=== FIN DEL ANALISIS ===");
        tokenWriter.close();
        System.out.println("Tokens guardados en: " + archivoTokens);

        // ===============================================================
        // SEGUNDO PASO: RESETEAR Y PREPARAR PARA EL PARSER
        // ===============================================================
        
        Lexer.erroresLexicos = 0;
        Lexer.silenciarErrores = false;

        // ===============================================================
        // TERCER PASO: ANALISIS SINTACTICO Y SEMANTICO
        // ===============================================================
        
        Lexer lexerParser = new Lexer(new FileReader(args[0]));
        GeneradorCodigo.iniciar(archivoIntermedio);

        @SuppressWarnings("deprecation")
        parser p = new parser(lexerParser);
        p.parse();

        // ===============================================================
        // CUARTO PASO: MOSTRAR RESUMEN DE RESULTADOS
        // ===============================================================
        
        System.out.println();
        System.out.println("\n=== ANALISIS DE COMPILACION ===" + " (Archivo: " + args[0] + ")");

        String lexicoMsg = (Lexer.erroresLexicos == 0) 
            ? ANSI_GREEN + "Analisis lexico:     EXITOSO" 
            : ANSI_RED + "Analisis lexico:     FALLIDO (" + Lexer.erroresLexicos + " error(es) lexico(s))";
        System.out.println(lexicoMsg + ANSI_RESET);

        String sintacticoMsg = (parser.erroresSintacticos == 0) 
            ? ANSI_BLUE + "Analisis sintactico: EXITOSO" 
            : ANSI_RED + "Analisis sintactico: FALLIDO (" + parser.erroresSintacticos + " error(es) sintactico(s))";
        System.out.println(sintacticoMsg + ANSI_RESET);

        String semanticoMsg = (parser.erroresSemanticos == 0) 
            ? ANSI_RED_BRIGHT + "Analisis semantico:  EXITOSO" 
            : ANSI_RED + "Analisis semantico:  FALLIDO (" + parser.erroresSemanticos + " error(es) semantico(s))";
        System.out.println(semanticoMsg + ANSI_RESET);

        // ===============================================================
        // QUINTO PASO: GENERAR CODIGO INTERMEDIO SOLO SI NO HAY ERRORES
        // ===============================================================
        if (Lexer.erroresLexicos == 0 && parser.erroresSintacticos == 0 && parser.erroresSemanticos == 0) {
            GeneradorCodigo.cerrar();
            System.out.println(ANSI_GREEN + "\nCodigo intermedio generado en: " + archivoIntermedio + ANSI_RESET);
        } else {
            GeneradorCodigo.cerrarConError(archivoIntermedio);
            System.out.println(ANSI_RED + "\n[ERROR] Codigo intermedio no generado debido a errores en el analisis." + ANSI_RESET);
        }
    }
}