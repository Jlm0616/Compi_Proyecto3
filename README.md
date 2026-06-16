# Proyecto #2 - Análisis Semántico y Generación Código Intermedio

## Descripción


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

## Cómo ejecutar

1. Generar el lexer

java -jar lib\jflex-full-1.9.1.jar lenguaje.flex

2. Generar el parser

java -jar java-cup-11b.jar -parser parser -symbols sym lenguaje.cup

3. Compilar

javac -cp ".;java-cup-11b-runtime.jar" *.java

4. Ejecutar prueba

java -cp ".;java-cup-11b-runtime.jar" Main prueba.txt
