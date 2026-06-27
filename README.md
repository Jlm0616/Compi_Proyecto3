# Proyecto #3 - Generación Código Destino (MIPS)

## Descripción
Este proyecto implementa la fase de generación de código destino MIPS para un compilador de un lenguaje imperativo. El sistema toma un archivo fuente escrito en el lenguaje definido, realiza análisis léxico, sintáctico y semántico, genera código intermedio de tres direcciones y finalmente produce código ensamblador MIPS ejecutable en el simulador QtSpim.

## Tecnologías
| Tecnología | Versión |
|------------|---------|
| Java | OpenJDK 25.0.2+10 |
| JFlex | 1.9.1 |
| CUP | 11b (20160615) |

## Archivos del proyecto

| Archivo | Tipo | Descripción |
|---------|------|-------------|
| `lenguaje.flex` | Fuente | Especificación de tokens para JFlex |
| `lenguaje.cup` | Fuente | Especificación de la gramática para CUP |
| `Main.java` | Fuente | Programa principal con tabla de símbolos |
| `TablaSimbolos.java` | Fuente | Clase para la tabla de símbolos |
| `prueba.txt` | Datos | Archivo de ejemplo para probar |
| `lib/jflex-full-1.9.1.jar` | Herramienta | Generador de lexers JFlex |
| `java-cup-11b-runtime.jar` | Librería | Runtime de CUP |
| `java-cup-11b.jar` | Herramienta | Generador de parser CUP |
| `GeneradorCodigo.java` | Fuente	| Generador de código intermedio de tres direcciones |
| `GeneradorMIPS.java` | Fuente	| Generador de código destino MIPS |
## Cómo ejecutar

1. Generar el lexer

java -jar lib\jflex-full-1.9.1.jar lenguaje.flex

2. Generar el parser

java -jar java-cup-11b.jar -parser parser -symbols sym lenguaje.cup

3. Compilar

javac -cp ".;java-cup-11b-runtime.jar" *.java

4. Ejecutar prueba

java -cp ".;java-cup-11b-runtime.jar" Main prueba.txt
