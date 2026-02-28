package com.globalfin.dashboard.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Operation {
    private final String id;
    private final String clientName;
    private final String clientId;
    private final double amount;
    private OperationStatus status;
    private final LocalDateTime dateTime;
    private final OperationType type;
    private final RiskLevel riskLevel;
    private final String channel;
    private String notes;

    public enum OperationStatus {
        PENDING("Pendiente"),
        COMPLETED("Completada"),
        REVIEWING("En revisión"),
        REJECTED("Rechazada"),
        SUSPICIOUS("Sospechosa");

        private final String displayName;

        OperationStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum OperationType {
        TRANSFER("Transferencia"),
        PAYMENT("Pago"),
        BIZUM("Bizum"),
        WITHDRAWAL("Retirada"),
        DEPOSIT("Ingreso");

        private final String displayName;

        OperationType(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum RiskLevel {
        LOW("Bajo", "#28a745"),
        MEDIUM("Medio", "#ffc107"),
        HIGH("Alto", "#dc3545");

        private final String displayName;
        private final String color;

        RiskLevel(String displayName, String color) {
            this.displayName = displayName;
            this.color = color;
        }

        public String getDisplayName() {
            return displayName;
        }

        public String getColor() {
            return color;
        }
    }

    public Operation(String id, String clientName, String clientId, double amount,
                     OperationStatus status, LocalDateTime dateTime, OperationType type,
                     RiskLevel riskLevel, String channel) {
        this.id = id;
        this.clientName = clientName;
        this.clientId = clientId;
        this.amount = amount;
        this.status = status;
        this.dateTime = dateTime;
        this.type = type;
        this.riskLevel = riskLevel;
        this.channel = channel;
        this.notes = "";
    }

    // Getters
    public String getId() { return id; }
    public String getClientName() { return clientName; }
    public String getClientId() { return clientId; }
    public double getAmount() { return amount; }
    public OperationStatus getStatus() { return status; }
    public LocalDateTime getDateTime() { return dateTime; }
    public OperationType getType() { return type; }
    public RiskLevel getRiskLevel() { return riskLevel; }
    public String getChannel() { return channel; }
    public String getNotes() { return notes; }

    // Setters
    public void setStatus(OperationStatus status) { this.status = status; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getFormattedAmount() {
        return String.format("€%.2f", amount);
    }

    public String getFormattedDateTime() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return dateTime.format(formatter);
    }

    @Override
    public String toString() {
        return String.format("%s - %s - %s - %s", id, clientName, getFormattedAmount(), status.getDisplayName());
    }
}
