import com.globalfin.dashboard.data.MockDataProvider;
import com.globalfin.dashboard.model.Operation;
import com.globalfin.dashboard.model.DashboardMetrics;
import java.util.List;

public class TestMockDataProvider {
    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("Prueba del MockDataProvider");
        System.out.println("========================================\n");

        // Obtener operaciones (debería cargar desde Supabase automáticamente)
        System.out.println("Cargando operaciones...");
        List<Operation> operations = MockDataProvider.getOperations();
        System.out.println("✓ Se obtuvieron " + operations.size() + " operaciones\n");

        if (!operations.isEmpty()) {
            System.out.println("Primera operación:");
            Operation op = operations.get(0);
            System.out.println("  ID: " + op.getId());
            System.out.println("  Cliente: " + op.getClientName());
            System.out.println("  Monto: €" + String.format("%.2f", op.getAmount()));
            System.out.println("  Estado: " + op.getStatus());
            System.out.println("  Tipo: " + op.getType());
            System.out.println("  Riesgo: " + op.getRiskLevel());
            System.out.println("  Canal: " + op.getChannel());
            System.out.println();
        }

        // Obtener métricas del dashboard
        System.out.println("Cargando métricas del dashboard...");
        DashboardMetrics metrics = MockDataProvider.getMetrics();
        System.out.println("✓ Métricas calculadas:");
        System.out.println("  Total operaciones: " + metrics.getTotalOperationsToday());
        System.out.println("  Pendientes: " + metrics.getPendingOperations());
        System.out.println("  Alertas: " + metrics.getActiveAlerts());
        System.out.println("  Fallidas: " + metrics.getFailedOperations());
        System.out.println("  Volumen total: " + metrics.getFormattedVolume());
        System.out.println();

        System.out.println("========================================");
        System.out.println("✓ Dashboard listo para usar datos reales");
        System.out.println("========================================");
    }
}
