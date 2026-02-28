import com.globalfin.dashboard.service.SupabaseService;
import com.google.gson.JsonObject;
import java.util.List;

public class TestSupabaseConnection {
    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("Prueba de Conexión a Supabase");
        System.out.println("========================================\n");

        // Test 1: Conexión básica
        System.out.println("Test 1: Prueba de conexión básica...");
        boolean connected = SupabaseService.testConnection();
        System.out.println("Resultado: " + (connected ? "✓ EXITOSO" : "✗ FALLIDO") + "\n");

        // Test 2: Obtener clientes
        System.out.println("Test 2: Obteniendo clientes desde Supabase...");
        try {
            List<JsonObject> clientes = SupabaseService.getClientes();
            System.out.println("✓ Se obtuvieron " + clientes.size() + " clientes");
            if (!clientes.isEmpty()) {
                System.out.println("Primer cliente: " + clientes.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println("✗ Error: " + e.getMessage());
        }
        System.out.println();

        // Test 3: Obtener operaciones
        System.out.println("Test 3: Obteniendo operaciones desde Supabase...");
        try {
            List<JsonObject> operaciones = SupabaseService.getOperaciones();
            System.out.println("✓ Se obtuvieron " + operaciones.size() + " operaciones");
            if (!operaciones.isEmpty()) {
                System.out.println("Primera operación: " + operaciones.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println("✗ Error: " + e.getMessage());
        }
        System.out.println();

        // Test 4: Obtener transacciones
        System.out.println("Test 4: Obteniendo transacciones desde Supabase...");
        try {
            List<JsonObject> transacciones = SupabaseService.getTransacciones();
            System.out.println("✓ Se obtuvieron " + transacciones.size() + " transacciones");
            if (!transacciones.isEmpty()) {
                System.out.println("Primera transacción: " + transacciones.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println("✗ Error: " + e.getMessage());
        }
        System.out.println();

        System.out.println("========================================");
        System.out.println("Prueba completada");
        System.out.println("========================================");
    }
}
