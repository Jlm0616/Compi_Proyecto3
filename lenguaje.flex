// ===============================================================
// ANALIZADOR LEXICO
// ===============================================================
// Lenguaje de Configuracion de Chips
// COMPILADORES E INTERPRETES - Proyecto 1
// ===============================================================

import java_cup.runtime.Symbol;

%%
%cup                    // Usar CUP para compatibilidad con parser
%unicode                // Soporte para caracteres Unicode
%class Lexer            // Nombre de la clase generada
%line                   // Habilitar contador de lineas (yyline)
%column                 // Habilitar contador de columnas (yycolumn)

%{

    // ===============================================================
    // CODIGO JAVA EMBEBIDO
    // ===============================================================
    
    // Colores para mensajes de error
    private static final String ANSI_RESET = "\u001B[0m";
    private static final String ANSI_GREEN = "\u001B[32m";

    // Contador de errores lexicos (publico para Main)
    public static int erroresLexicos = 0;
    
    // Silenciar errores en el primer pase (para generar tokens.txt)
    public static boolean silenciarErrores = false;
    
    // Crea un token sin valor asociado
    private Symbol symbol(int type) {
        return new Symbol(type, yyline + 1, yycolumn + 1);
    }
    
    // Crea un token con valor asociado
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline + 1, yycolumn + 1, value);
    }
    
    // Reporta un error lexico (con color)
    private void errorLexico(String mensaje) {
        erroresLexicos++;
        if (!silenciarErrores) {
            System.err.println(ANSI_GREEN + "[ERROR LEXICO] Linea " + (yyline + 1) + ": " + mensaje + ANSI_RESET);
        }
    }
%}

// ===============================================================
// DEFINICIONES DE EXPRESIONES REGULARES
// ===============================================================

/* ========== COMENTARIOS ========== */
ComentarioLinea = "¡¡".*
ComentarioBloque = "{-" ~"-}"

/* ========== ESPACIOS EN BLANCO ========== */
EspacioBlanco = [ \t\r\n]+

/* ========== NUMEROS Y LITERALES NUMERICOS ========== */
Digito = [0-9]
NumeroEntero = {Digito}+
NumeroFlotante = {Digito}+ "." {Digito}+
NotacionCientifica = {Digito}+ "e" {Digito}+
Fraccionario = {Digito}+ "//" {Digito}+

/* ========== IDENTIFICADORES ========== */
Letra = [a-zA-Z]
Identificador = ({Letra}|"_")({Letra}|{Digito}|"_")*

/* ========== CADENAS Y CARACTERES ========== */
Cadena = \"[^\"\n]*\"
Caracter = \'[^\']\'

/* ========== PALABRAS RESERVADAS ========== */
PalabraMain = "__main__"
Int = "int"
Float = "float"
Bool = "bool"
Char = "char"
StringTipo = "string"
If = "if"
Else = "else"
Do = "do"
While = "while"
Switch = "switch"
Case = "case"
Default = "default"
Return = "return"
Break = "break"
Cin = "cin"
Cout = "cout"
True = "true"
False = "false"
Empty = "empty"
Equal = "equal"
NEqual = "n_equal"
LessT = "less_t"
LessTe = "less_te"
GreaterT = "greather_t"
GreaterTe = "greather_te"

/* ========== OPERADORES Y SIMBOLOS ESPECIALES ========== */
Asignacion = "<-"
Separador = "~"
DelimitadorExp = "!"
InicioBloque = "|:"
FinBloque = ":|"
InicioParentesis = "<|"
FinParentesis = "|>"
InicioIndice = "<<"
FinIndice = ">>"
Coma = ","
DosPuntos = ":"
Mas = "+"
Menos = "-"
Multiplicacion = "*"
Division = "/"
Modulo = "%"
Potencia = "^"
Incremento = "++"
Decremento = "--"
OpLogicoBinario = "@"|"#"
OpLogicoUnario = "$"

%%

// ===============================================================
// REGLAS LEXICAS (PATRON - ACCION)
// ===============================================================

/* ========== PALABRAS RESERVADAS ========== */
{PalabraMain}    { return symbol(sym.PALABRA_MAIN, yytext()); }
{Int}            { return symbol(sym.INT, yytext()); }
{Float}          { return symbol(sym.FLOAT, yytext()); }
{Bool}           { return symbol(sym.BOOL, yytext()); }
{Char}           { return symbol(sym.CHAR, yytext()); }
{StringTipo}     { return symbol(sym.STRING, yytext()); }
{If}             { return symbol(sym.IF, yytext()); }
{Else}           { return symbol(sym.ELSE, yytext()); }
{Do}             { return symbol(sym.DO, yytext()); }
{While}          { return symbol(sym.WHILE, yytext()); }
{Switch}         { return symbol(sym.SWITCH, yytext()); }
{Case}           { return symbol(sym.CASE, yytext()); }
{Default}        { return symbol(sym.DEFAULT, yytext()); }
{Return}         { return symbol(sym.RETURN, yytext()); }
{Break}          { return symbol(sym.BREAK, yytext()); }
{Cin}            { return symbol(sym.CIN, yytext()); }
{Cout}           { return symbol(sym.COUT, yytext()); }
{True}           { return symbol(sym.BOOLEANO, Boolean.TRUE); }
{False}          { return symbol(sym.BOOLEANO, Boolean.FALSE); }
{Equal}          { return symbol(sym.EQUAL, yytext()); }
{NEqual}         { return symbol(sym.N_EQUAL, yytext()); }
{LessT}          { return symbol(sym.LESS_T, yytext()); }
{LessTe}         { return symbol(sym.LESS_TE, yytext()); }
{GreaterT}       { return symbol(sym.GREATER_T, yytext()); }
{GreaterTe}      { return symbol(sym.GREATER_TE, yytext()); }
{Empty}          { return symbol(sym.EMPTY, yytext());}

/* ========== OPERADORES Y SIMBOLOS ========== */
{Asignacion}           { return symbol(sym.ASIGNACION, yytext()); }
{Separador}            { return symbol(sym.SEPARADOR, yytext()); }
{DelimitadorExp}       { return symbol(sym.DELIMITADOR_EXP, yytext()); }
{InicioBloque}         { return symbol(sym.INICIO_BLOQUE, yytext()); }
{FinBloque}            { return symbol(sym.FIN_BLOQUE, yytext()); }
{InicioParentesis}     { return symbol(sym.INICIO_PARENTESIS, yytext()); }
{FinParentesis}        { return symbol(sym.FIN_PARENTESIS, yytext()); }
{InicioIndice}         { return symbol(sym.INICIO_INDICE, yytext()); }
{FinIndice}            { return symbol(sym.FIN_INDICE, yytext()); }
{Coma}                 { return symbol(sym.COMA, yytext()); }
{DosPuntos}            { return symbol(sym.DOS_PUNTOS, yytext()); }
{Multiplicacion}       { return symbol(sym.MULTIPLICACION, yytext()); }
{Division}             { return symbol(sym.DIVISION, yytext()); }
{Modulo}               { return symbol(sym.MODULO, yytext()); }
{Potencia}             { return symbol(sym.POTENCIA, yytext()); }
{Incremento}           { return symbol(sym.INCREMENTO, yytext()); }
{Decremento}           { return symbol(sym.DECREMENTO, yytext()); }
{Mas}                  { return symbol(sym.MAS, yytext()); }
{Menos}                { return symbol(sym.MENOS, yytext()); }
{OpLogicoBinario}      { return symbol(sym.OPERADOR_LOGICO_BINARIO, yytext()); }
{OpLogicoUnario}       { return symbol(sym.OPERADOR_LOGICO_UNARIO, yytext()); }

/* ========== LITERALES ========== */
{NumeroEntero}       { return symbol(sym.NUMERO_ENTERO, Integer.parseInt(yytext())); }
{NumeroFlotante}     { return symbol(sym.NUMERO_FLOTANTE, Double.parseDouble(yytext())); }
{NotacionCientifica} { return symbol(sym.NOTACION_CIENTIFICA, yytext()); }
{Fraccionario}       { return symbol(sym.FRACCIONARIO, yytext()); }
{Cadena}             { 
                        String contenido = yytext().substring(1, yytext().length()-1);
                        contenido = contenido.replace("\\n", "\n").replace("\\t", "\t");
                        return symbol(sym.CADENA, contenido);
                      }
{Caracter}           { return symbol(sym.CARACTER, yytext().charAt(1)); }
{Identificador}      { return symbol(sym.IDENTIFICADOR, yytext()); }

/* ========== COMENTARIOS (IGNORAR) ========== */
{ComentarioLinea}    { /* ignorar */ }
{ComentarioBloque}   { /* ignorar */ }

/* ========== ESPACIOS EN BLANCO (IGNORAR) ========== */
{EspacioBlanco}      { /* ignorar */ }

/* ========== ERROR - CARACTER NO RECONOCIDO ========== */
. { errorLexico("Caracter no reconocido: '" + yytext() + "'"); }