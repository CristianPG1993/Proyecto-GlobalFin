package com.globalfin.dashboard;

import com.globalfin.dashboard.model.Operation;
import com.globalfin.dashboard.model.DashboardMetrics;
import com.globalfin.dashboard.data.MockDataProvider;

import javafx.application.Application;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.stage.Stage;

public class DashboardApp extends Application {

    private ObservableList<Operation> operationsData;
    private TableView<Operation> operationsTable;
    private TextArea detailsArea;
    private Label selectedOperationLabel;
    private Operation selectedOperation;

    @Override
    public void start(Stage primaryStage) {
        operationsData = FXCollections.observableArrayList(MockDataProvider.getOperations());

        BorderPane root = new BorderPane();
        root.setTop(createTopBar());
        root.setCenter(createCenterContent());
        root.setRight(createRightPanel());

        Scene scene = new Scene(root, 1400, 800);
        scene.getStylesheets().add(getClass().getResource("/styles/dashboard.css").toExternalForm());

        primaryStage.setTitle("GlobalFin - Dashboard de Operaciones");
        primaryStage.setScene(scene);
        primaryStage.setMinWidth(1200);
        primaryStage.setMinHeight(700);
        primaryStage.show();
    }

    private HBox createTopBar() {
        HBox topBar = new HBox(15);
        topBar.getStyleClass().add("top-bar");
        topBar.setPadding(new Insets(15, 20, 15, 20));
        topBar.setAlignment(Pos.CENTER_LEFT);

        Label title = new Label("GlobalFin | Panel de Operaciones");
        title.getStyleClass().add("main-title");

        MenuButton menuButton = new MenuButton("Menú");
        menuButton.getItems().addAll(
            new MenuItem("Resumen General"),
            new MenuItem("Operaciones"),
            new MenuItem("Clientes"),
            new MenuItem("Alertas de Riesgo")
        );

        TextField searchField = new TextField();
        searchField.setPromptText("Buscar por ID, cliente o referencia...");
        searchField.setPrefWidth(300);
        searchField.getStyleClass().add("search-field");

        Region spacer = new Region();
        HBox.setHgrow(spacer, Priority.ALWAYS);

        Label userLabel = new Label("Usuario: Admin");
        userLabel.getStyleClass().add("user-label");

        topBar.getChildren().addAll(title, menuButton, searchField, spacer, userLabel);
        return topBar;
    }

    private VBox createCenterContent() {
        VBox center = new VBox(15);
        center.setPadding(new Insets(20));
        center.getStyleClass().add("center-content");

        // Panel de métricas KPI
        HBox metricsPanel = createMetricsPanel();
        
        // Barra de filtros
        HBox filtersBar = createFiltersBar();

        // Tabla de operaciones
        operationsTable = createOperationsTable();
        VBox.setVgrow(operationsTable, Priority.ALWAYS);

        center.getChildren().addAll(metricsPanel, filtersBar, operationsTable);
        return center;
    }

    private HBox createMetricsPanel() {
        HBox metricsPanel = new HBox(15);
        metricsPanel.setAlignment(Pos.CENTER_LEFT);
        metricsPanel.getStyleClass().add("metrics-panel");

        DashboardMetrics metrics = MockDataProvider.getMetrics();

        metricsPanel.getChildren().addAll(
            createMetricCard("Volumen Total Hoy", metrics.getFormattedVolume(), "metric-primary"),
            createMetricCard("Operaciones Pendientes", String.valueOf(metrics.getPendingOperations()), "metric-warning"),
            createMetricCard("Alertas Activas", String.valueOf(metrics.getActiveAlerts()), "metric-danger"),
            createMetricCard("Operaciones Fallidas", String.valueOf(metrics.getFailedOperations()), "metric-info")
        );

        return metricsPanel;
    }

    private VBox createMetricCard(String title, String value, String styleClass) {
        VBox card = new VBox(5);
        card.getStyleClass().addAll("metric-card", styleClass);
        card.setPadding(new Insets(15));
        card.setPrefWidth(200);

        Label titleLabel = new Label(title);
        titleLabel.getStyleClass().add("metric-title");

        Label valueLabel = new Label(value);
        valueLabel.getStyleClass().add("metric-value");

        card.getChildren().addAll(titleLabel, valueLabel);
        return card;
    }

    private HBox createFiltersBar() {
        HBox filtersBar = new HBox(10);
        filtersBar.setAlignment(Pos.CENTER_LEFT);
        filtersBar.setPadding(new Insets(10, 0, 10, 0));

        Label filterLabel = new Label("Filtrar por:");

        ComboBox<String> statusFilter = new ComboBox<>();
        statusFilter.getItems().addAll("Todos", "Pendiente", "Completada", "En revisión", "Rechazada", "Sospechosa");
        statusFilter.setValue("Todos");
        statusFilter.setPrefWidth(150);

        ComboBox<String> riskFilter = new ComboBox<>();
        riskFilter.getItems().addAll("Todos", "Bajo", "Medio", "Alto");
        riskFilter.setValue("Todos");
        riskFilter.setPrefWidth(120);

        DatePicker datePicker = new DatePicker();
        datePicker.setPromptText("Fecha");
        datePicker.setPrefWidth(150);

        Button refreshButton = new Button("Actualizar");
        refreshButton.getStyleClass().add("action-button");
        refreshButton.setOnAction(e -> refreshData());

        Region spacer = new Region();
        HBox.setHgrow(spacer, Priority.ALWAYS);

        Label totalLabel = new Label("Total operaciones: " + operationsData.size());
        totalLabel.getStyleClass().add("total-label");

        filtersBar.getChildren().addAll(
            filterLabel, statusFilter, riskFilter, datePicker, refreshButton, spacer, totalLabel
        );

        return filtersBar;
    }

    private TableView<Operation> createOperationsTable() {
        TableView<Operation> table = new TableView<>();
        table.setItems(operationsData);
        table.getStyleClass().add("operations-table");

        TableColumn<Operation, String> idCol = new TableColumn<>("ID Operación");
        idCol.setCellValueFactory(data -> new SimpleStringProperty(data.getValue().getId()));
        idCol.setPrefWidth(120);

        TableColumn<Operation, String> clientCol = new TableColumn<>("Cliente");
        clientCol.setCellValueFactory(data -> new SimpleStringProperty(data.getValue().getClientName()));
        clientCol.setPrefWidth(200);

        TableColumn<Operation, String> amountCol = new TableColumn<>("Importe");
        amountCol.setCellValueFactory(data -> new SimpleStringProperty(data.getValue().getFormattedAmount()));
        amountCol.setPrefWidth(120);

        TableColumn<Operation, String> statusCol = new TableColumn<>("Estado");
        statusCol.setCellValueFactory(data -> new SimpleStringProperty(data.getValue().getStatus().getDisplayName()));
        statusCol.setPrefWidth(130);
        statusCol.setCellFactory(col -> new TableCell<Operation, String>() {
            @Override
            protected void updateItem(String item, boolean empty) {
                super.updateItem(item, empty);
                if (empty || item == null) {
                    setText(null);
                    setStyle("");
                } else {
                    setText(item);
                    Operation op = getTableView().getItems().get(getIndex());
                    String styleClass = "";
                    switch (op.getStatus()) {
                        case PENDING -> styleClass = "-fx-text-fill: #ffc107; -fx-font-weight: bold;";
                        case COMPLETED -> styleClass = "-fx-text-fill: #28a745; -fx-font-weight: bold;";
                        case REVIEWING -> styleClass = "-fx-text-fill: #17a2b8; -fx-font-weight: bold;";
                        case REJECTED -> styleClass = "-fx-text-fill: #6c757d; -fx-font-weight: bold;";
                        case SUSPICIOUS -> styleClass = "-fx-text-fill: #dc3545; -fx-font-weight: bold;";
                    }
                    setStyle(styleClass);
                }
            }
        });

        TableColumn<Operation, String> dateCol = new TableColumn<>("Fecha / Hora");
        dateCol.setCellValueFactory(data -> new SimpleStringProperty(data.getValue().getFormattedDateTime()));
        dateCol.setPrefWidth(140);

        TableColumn<Operation, String> typeCol = new TableColumn<>("Tipo");
        typeCol.setCellValueFactory(data -> new SimpleStringProperty(data.getValue().getType().getDisplayName()));
        typeCol.setPrefWidth(120);

        TableColumn<Operation, String> riskCol = new TableColumn<>("Nivel Riesgo");
        riskCol.setCellValueFactory(data -> new SimpleStringProperty(data.getValue().getRiskLevel().getDisplayName()));
        riskCol.setPrefWidth(110);
        riskCol.setCellFactory(col -> new TableCell<Operation, String>() {
            @Override
            protected void updateItem(String item, boolean empty) {
                super.updateItem(item, empty);
                if (empty || item == null) {
                    setText(null);
                    setStyle("");
                } else {
                    setText(item);
                    Operation op = getTableView().getItems().get(getIndex());
                    setStyle("-fx-text-fill: " + op.getRiskLevel().getColor() + "; -fx-font-weight: bold;");
                }
            }
        });

        TableColumn<Operation, String> channelCol = new TableColumn<>("Canal");
        channelCol.setCellValueFactory(data -> new SimpleStringProperty(data.getValue().getChannel()));
        channelCol.setPrefWidth(100);

        table.getColumns().addAll(idCol, clientCol, amountCol, statusCol, dateCol, typeCol, riskCol, channelCol);

        table.getSelectionModel().selectedItemProperty().addListener((obs, oldSelection, newSelection) -> {
            if (newSelection != null) {
                selectedOperation = newSelection;
                updateDetailsPanel(newSelection);
            }
        });

        return table;
    }

    private VBox createRightPanel() {
        VBox rightPanel = new VBox(15);
        rightPanel.setPadding(new Insets(20));
        rightPanel.setPrefWidth(350);
        rightPanel.getStyleClass().add("right-panel");

        Label title = new Label("Detalle de Operación");
        title.getStyleClass().add("panel-title");

        selectedOperationLabel = new Label("Selecciona una operación");
        selectedOperationLabel.getStyleClass().add("selected-operation-label");
        selectedOperationLabel.setWrapText(true);

        detailsArea = new TextArea();
        detailsArea.setWrapText(true);
        detailsArea.setEditable(false);
        detailsArea.setPrefRowCount(10);
        detailsArea.setText("Selecciona una operación de la tabla para ver sus detalles.");
        VBox.setVgrow(detailsArea, Priority.ALWAYS);

        Label actionsLabel = new Label("Acciones Rápidas:");
        actionsLabel.getStyleClass().add("section-label");

        Button reviewButton = new Button("Marcar como Revisada");
        reviewButton.getStyleClass().add("action-button");
        reviewButton.setMaxWidth(Double.MAX_VALUE);
        reviewButton.setOnAction(e -> markAsReviewed());

        Button suspiciousButton = new Button("Marcar como Sospechosa");
        suspiciousButton.getStyleClass().add("action-button-danger");
        suspiciousButton.setMaxWidth(Double.MAX_VALUE);
        suspiciousButton.setOnAction(e -> markAsSuspicious());

        Button escalateButton = new Button("Escalar a Fraude");
        escalateButton.getStyleClass().add("action-button-danger");
        escalateButton.setMaxWidth(Double.MAX_VALUE);
        escalateButton.setOnAction(e -> escalateToFraud());

        TextArea notesArea = new TextArea();
        notesArea.setPromptText("Añadir notas internas...");
        notesArea.setPrefRowCount(4);

        Button saveNotesButton = new Button("Guardar Nota");
        saveNotesButton.getStyleClass().add("action-button");
        saveNotesButton.setMaxWidth(Double.MAX_VALUE);
        saveNotesButton.setOnAction(e -> {
            if (selectedOperation != null && !notesArea.getText().isEmpty()) {
                selectedOperation.setNotes(notesArea.getText());
                showAlert("Nota guardada", "La nota se ha guardado correctamente.", Alert.AlertType.INFORMATION);
                notesArea.clear();
                updateDetailsPanel(selectedOperation);
            }
        });

        rightPanel.getChildren().addAll(
            title,
            selectedOperationLabel,
            new Separator(),
            detailsArea,
            new Separator(),
            actionsLabel,
            reviewButton,
            suspiciousButton,
            escalateButton,
            new Separator(),
            new Label("Notas:"),
            notesArea,
            saveNotesButton
        );

        return rightPanel;
    }

    private void updateDetailsPanel(Operation operation) {
        selectedOperationLabel.setText(operation.getId() + " - " + operation.getClientName());

        StringBuilder details = new StringBuilder();
        details.append("ID OPERACIÓN: ").append(operation.getId()).append("\n\n");
        details.append("INFORMACIÓN DEL CLIENTE:\n");
        details.append("  Nombre: ").append(operation.getClientName()).append("\n");
        details.append("  ID Cliente: ").append(operation.getClientId()).append("\n\n");
        details.append("DETALLES DE LA OPERACIÓN:\n");
        details.append("  Tipo: ").append(operation.getType().getDisplayName()).append("\n");
        details.append("  Importe: ").append(operation.getFormattedAmount()).append("\n");
        details.append("  Estado: ").append(operation.getStatus().getDisplayName()).append("\n");
        details.append("  Fecha/Hora: ").append(operation.getFormattedDateTime()).append("\n");
        details.append("  Canal: ").append(operation.getChannel()).append("\n");
        details.append("  Nivel de Riesgo: ").append(operation.getRiskLevel().getDisplayName()).append("\n\n");
        
        if (!operation.getNotes().isEmpty()) {
            details.append("NOTAS INTERNAS:\n");
            details.append(operation.getNotes()).append("\n");
        }

        detailsArea.setText(details.toString());
    }

    private void markAsReviewed() {
        if (selectedOperation != null && selectedOperation.getStatus() != Operation.OperationStatus.COMPLETED) {
            if (showConfirmation("Marcar como Revisada", "¿Confirmar que la operación ha sido revisada?")) {
                selectedOperation.setStatus(Operation.OperationStatus.COMPLETED);
                operationsTable.refresh();
                updateDetailsPanel(selectedOperation);
                showAlert("Operación Actualizada", "La operación ha sido marcada como revisada.", Alert.AlertType.INFORMATION);
            }
        }
    }

    private void markAsSuspicious() {
        if (selectedOperation != null) {
            if (showConfirmation("Marcar como Sospechosa", 
                               "¿Confirmar que deseas marcar esta operación como sospechosa?\n\n" +
                               "Se notificará al equipo de riesgo.")) {
                selectedOperation.setStatus(Operation.OperationStatus.SUSPICIOUS);
                operationsTable.refresh();
                updateDetailsPanel(selectedOperation);
                showAlert("Operación Marcada", "La operación ha sido marcada como sospechosa y el equipo de riesgo ha sido notificado.", Alert.AlertType.WARNING);
            }
        }
    }

    private void escalateToFraud() {
        if (selectedOperation != null) {
            if (showConfirmation("Escalar a Fraude", 
                               "¿Confirmar que deseas escalar esta operación al equipo de fraude?\n\n" +
                               "Esta acción es crítica y generará una alerta inmediata.")) {
                selectedOperation.setStatus(Operation.OperationStatus.REVIEWING);
                selectedOperation.setNotes("ESCALADO A FRAUDE - " + java.time.LocalDateTime.now());
                operationsTable.refresh();
                updateDetailsPanel(selectedOperation);
                showAlert("Escalado a Fraude", 
                         "La operación ha sido escalada al equipo de fraude.\n" +
                         "Se ha generado una alerta de prioridad alta.", 
                         Alert.AlertType.ERROR);
            }
        }
    }

    private void refreshData() {
        operationsData.setAll(MockDataProvider.getOperations());
        showAlert("Datos Actualizados", "Los datos del dashboard han sido actualizados.", Alert.AlertType.INFORMATION);
    }

    private boolean showConfirmation(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        return alert.showAndWait().orElse(ButtonType.CANCEL) == ButtonType.OK;
    }

    private void showAlert(String title, String message, Alert.AlertType type) {
        Alert alert = new Alert(type);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
