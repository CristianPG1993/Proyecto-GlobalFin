package com.globalfin.dashboard.model;

public class DashboardMetrics {
    private int totalOperationsToday;
    private int pendingOperations;
    private int activeAlerts;
    private int failedOperations;
    private double totalVolumeToday;

    public DashboardMetrics(int totalOperationsToday, int pendingOperations,
                           int activeAlerts, int failedOperations, double totalVolumeToday) {
        this.totalOperationsToday = totalOperationsToday;
        this.pendingOperations = pendingOperations;
        this.activeAlerts = activeAlerts;
        this.failedOperations = failedOperations;
        this.totalVolumeToday = totalVolumeToday;
    }

    public int getTotalOperationsToday() { return totalOperationsToday; }
    public int getPendingOperations() { return pendingOperations; }
    public int getActiveAlerts() { return activeAlerts; }
    public int getFailedOperations() { return failedOperations; }
    public double getTotalVolumeToday() { return totalVolumeToday; }

    public void setTotalOperationsToday(int totalOperationsToday) {
        this.totalOperationsToday = totalOperationsToday;
    }

    public void setPendingOperations(int pendingOperations) {
        this.pendingOperations = pendingOperations;
    }

    public void setActiveAlerts(int activeAlerts) {
        this.activeAlerts = activeAlerts;
    }

    public void setFailedOperations(int failedOperations) {
        this.failedOperations = failedOperations;
    }

    public void setTotalVolumeToday(double totalVolumeToday) {
        this.totalVolumeToday = totalVolumeToday;
    }

    public String getFormattedVolume() {
        return String.format("€%.2f", totalVolumeToday);
    }
}
