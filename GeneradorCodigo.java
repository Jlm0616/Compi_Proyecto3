// ===============================================================
// GENERADOR DE CODIGO INTERMEDIO
// ===============================================================
// Clase responsable de generar codigo intermedio de tres direcciones
// El codigo se escribe en un archivo de texto para su posterior uso
// ===============================================================

import java.io.*;

public class GeneradorCodigo {

    // ===============================================================
    // ATRIBUTOS ESTATICOS
    // ===============================================================
    
    private static int contadorTempInt = 0;      // Contador para enteros: t0, t1, t2...
    private static int contadorTempFloat = 0;    // Contador para flotantes: f0, f1, f2...
    private static int contadorEtiq = 0;         // Contador para etiquetas: L0, L1, L2...
    private static PrintWriter writer = null;    // Archivo de salida

    // ===============================================================
    // INICIAR
    // ===============================================================
    // Abre el archivo donde se escribira el codigo intermedio
    // Recibe: archivo - nombre del archivo de salida
    // ===============================================================
    public static void iniciar(String archivo) {
        try {
            writer = new PrintWriter(new FileWriter(archivo));
            writer.println("# ===== CODIGO INTERMEDIO =====");
        } catch (IOException e) {
            System.err.println("Error al crear archivo de codigo intermedio: " + e.getMessage());
        }
    }

    // ===============================================================
    // EMITIR ETIQUETA
    // ===============================================================
    // Escribe una etiqueta en el codigo intermedio (ej: "L0:")
    // Recibe: etiqueta - nombre de la etiqueta a emitir
    // ===============================================================
    public static void emitirEtiqueta(String etiqueta) {
        emitir(etiqueta + ":");
    }

    // ===============================================================
    // CERRAR
    // ===============================================================
    // Cierra el archivo de codigo intermedio
    // ===============================================================
    public static void cerrar() {
        if (writer != null) {
            writer.println("# ===== FIN DEL CODIGO INTERMEDIO =====");
            writer.flush();
            writer.close();
        }
    }

    // ===============================================================
    // NUEVO TEMPORAL (SOBRECARGADO)
    // ===============================================================
    // Genera un nuevo temporal segun el tipo:
    // - "int"   -> t0, t1, t2...
    // - "float" -> f0, f1, f2...
    // - otros   -> t0, t1, t2... (por defecto entero)
    // Retorna: String - temporal con formato "tX" o "fX"
    // ===============================================================
    public static String nuevoTemp(String tipo) {
        if (tipo != null && tipo.equals("float")) {
            return "f" + (contadorTempFloat++);
        } else {
            return "t" + (contadorTempInt++);
        }
    }

    // ===============================================================
    // NUEVO TEMPORAL (VERSION ANTIGUA PARA COMPATIBILIDAD)
    // ===============================================================
    // Genera un nuevo temporal entero: t0, t1, t2,..., tn
    // Retorna: String - temporal con formato "tX"
    // ===============================================================
    public static String nuevoTemp() {
        return nuevoTemp("int");
    }

    // ===============================================================
    // NUEVA ETIQUETA
    // ===============================================================
    // Genera una nueva etiqueta unica: L0, L1, L2,..., Ln
    // Retorna: String - etiqueta con formato "LX"
    // ===============================================================
    public static String nuevaEtiqueta() {
        return "L" + (contadorEtiq++);
    }

    // ===============================================================
    // EMITIR
    // ===============================================================
    // Escribe una linea de codigo intermedio en el archivo
    // Recibe: instruccion - linea de codigo a emitir
    // ===============================================================
    public static void emitir(String instruccion) {
        if (writer != null) {
            String segura = instruccion.replace("\n", "\\n").replace("\t", "\\t");
            writer.println(segura);
        }
    }
    
    // ===============================================================
    // REINICIAR CONTADORES (PARA MULTIPLES EJECUCIONES)
    // ===============================================================
    public static void reiniciar() {
        contadorTempInt = 0;
        contadorTempFloat = 0;
        contadorEtiq = 0;
    }

    // ===============================================================
    // CERRAR CON ERROR
    // ===============================================================
    // Sobreescribe el archivo con un mensaje de error y lo cierra
    // Recibe: archivo - nombre del archivo, mensaje - mensaje de error
    // ===============================================================
    public static void cerrarConError(String archivo) {
        try {
            // Sobreescribir el archivo con solo el mensaje de error
            PrintWriter writerError = new PrintWriter(new FileWriter(archivo));
            writerError.println("# ===== CODIGO INTERMEDIO =====");
            writerError.println("# Codigo intermedio no generado debido a errores en el analisis.");
            writerError.println("# ===== FIN DEL CODIGO INTERMEDIO =====");
            writerError.flush();
            writerError.close();
            // Cerrar el writer original sin escribir nada mas
            if (writer != null) {
                writer.flush();
                writer.close();
            }
        } catch (IOException e) {
            System.err.println("Error al cerrar archivo: " + e.getMessage());
        }
    }
}