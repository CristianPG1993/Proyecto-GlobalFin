package com.globalfin.dashboard.data;

import com.globalfin.dashboard.model.Operation;
import com.globalfin.dashboard.model.DashboardMetrics;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class MockDataProvider {

    public static List<Operation> getOperations() {
        List<Operation> operations = new ArrayList<>();
        
        operations.add(new Operation(
            "OP-10245",
            "Ana García López",
            "CLI-5421",
            12500.00,
            Operation.OperationStatus.PENDING,
            LocalDateTime.now().minusMinutes(15),
            Operation.OperationType.TRANSFER,
            Operation.RiskLevel.MEDIUM,
            "Web"
        ));

        operations.add(new Operation(
            "OP-10246",
            "Carlos Ruiz Fernández",
            "CLI-8832",
            450.00,
            Operation.OperationStatus.COMPLETED,
            LocalDateTime.now().minusMinutes(30),
            Operation.OperationType.BIZUM,
            Operation.RiskLevel.LOW,
            "Móvil"
        ));

        operations.add(new Operation(
            "OP-10247",
            "María Martínez Sánchez",
            "CLI-3298",
            75000.00,
            Operation.OperationStatus.REVIEWING,
            LocalDateTime.now().minusMinutes(45),
            Operation.OperationType.TRANSFER,
            Operation.RiskLevel.HIGH,
            "Oficina"
        ));

        operations.add(new Operation(
            "OP-10248",
            "Juan López Torres",
            "CLI-7654",
            230.50,
            Operation.OperationStatus.COMPLETED,
            LocalDateTime.now().minusHours(1),
            Operation.OperationType.PAYMENT,
            Operation.RiskLevel.LOW,
            "Web"
        ));

        operations.add(new Operation(
            "OP-10249",
            "Laura Gómez Díaz",
            "CLI-9021",
            8900.00,
            Operation.OperationStatus.SUSPICIOUS,
            LocalDateTime.now().minusHours(2),
            Operation.OperationType.WITHDRAWAL,
            Operation.RiskLevel.HIGH,
            "Cajero"
        ));

        operations.add(new Operation(
            "OP-10250",
            "Pedro Sánchez Ruiz",
            "CLI-4432",
            1500.00,
            Operation.OperationStatus.PENDING,
            LocalDateTime.now().minusHours(2).minusMinutes(30),
            Operation.OperationType.TRANSFER,
            Operation.RiskLevel.LOW,
            "Móvil"
        ));

        operations.add(new Operation(
            "OP-10251",
            "Elena Rodríguez Pérez",
            "CLI-6678",
            320.00,
            Operation.OperationStatus.REJECTED,
            LocalDateTime.now().minusHours(3),
            Operation.OperationType.BIZUM,
            Operation.RiskLevel.MEDIUM,
            "Web"
        ));

        operations.add(new Operation(
            "OP-10252",
            "Miguel Fernández García",
            "CLI-1123",
            25000.00,
            Operation.OperationStatus.PENDING,
            LocalDateTime.now().minusHours(4),
            Operation.OperationType.DEPOSIT,
            Operation.RiskLevel.MEDIUM,
            "Oficina"
        ));

        operations.add(new Operation(
            "OP-10253",
            "Isabel Torres López",
            "CLI-8845",
            680.00,
            Operation.OperationStatus.COMPLETED,
            LocalDateTime.now().minusHours(5),
            Operation.OperationType.PAYMENT,
            Operation.RiskLevel.LOW,
            "Web"
        ));

        operations.add(new Operation(
            "OP-10254",
            "Francisco Jiménez Mora",
            "CLI-3367",
            15600.00,
            Operation.OperationStatus.REVIEWING,
            LocalDateTime.now().minusHours(6),
            Operation.OperationType.TRANSFER,
            Operation.RiskLevel.HIGH,
            "Móvil"
        ));

        return operations;
    }

    public static DashboardMetrics getMetrics() {
        List<Operation> operations = getOperations();
        
        int total = operations.size();
        int pending = (int) operations.stream()
            .filter(op -> op.getStatus() == Operation.OperationStatus.PENDING)
            .count();
        int alerts = (int) operations.stream()
            .filter(op -> op.getStatus() == Operation.OperationStatus.SUSPICIOUS 
                       || op.getRiskLevel() == Operation.RiskLevel.HIGH)
            .count();
        int failed = (int) operations.stream()
            .filter(op -> op.getStatus() == Operation.OperationStatus.REJECTED)
            .count();
        double volume = operations.stream()
            .filter(op -> op.getStatus() == Operation.OperationStatus.COMPLETED 
                       || op.getStatus() == Operation.OperationStatus.PENDING)
            .mapToDouble(Operation::getAmount)
            .sum();

        return new DashboardMetrics(total, pending, alerts, failed, volume);
    }
}
