package com.globalfin.dashboard.service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.classic.methods.HttpPost;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.http.ParseException;
import org.apache.hc.core5.http.io.entity.EntityUtils;
import org.apache.hc.core5.http.io.entity.StringEntity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class SupabaseService {
    private static final String PROJECT_URL = "https://etlqpvghtqiqofepukqf.supabase.co";
    private static final String ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV0bHFwdmdodHFpcW9mZXB1a3FmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIyOTE2NTUsImV4cCI6MjA4Nzg2NzY1NX0.ulub2ohijz4Lcq6MtWr65ivmz9ehYnRonVA5osqnyMM";
    private static final String API_BASE_URL = PROJECT_URL + "/rest/v1";
    private static final Gson gson = new Gson();

    /**
     * Obtener todas las operaciones desde Supabase
     */
    public static List<JsonObject> getOperaciones() {
        try {
            return fetchData("/operaciones");
        } catch (Exception e) {
            System.err.println("Error fetching operaciones: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Obtener todos los clientes desde Supabase
     */
    public static List<JsonObject> getClientes() {
        try {
            return fetchData("/clientes");
        } catch (Exception e) {
            System.err.println("Error fetching clientes: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Obtener todas las transacciones desde Supabase
     */
    public static List<JsonObject> getTransacciones() {
        try {
            return fetchData("/transacciones");
        } catch (Exception e) {
            System.err.println("Error fetching transacciones: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Obtener transacciones de un cliente específico
     */
    public static List<JsonObject> getTransaccionesPorCliente(String clienteId) {
        try {
            return fetchData("/transacciones?id_cliente=eq." + clienteId);
        } catch (Exception e) {
            System.err.println("Error fetching transacciones por cliente: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Crear una nueva operación
     */
    public static boolean crearOperacion(JsonObject operacion) {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost request = new HttpPost(API_BASE_URL + "/operaciones");
            request.setHeader("apikey", ANON_KEY);
            request.setHeader("Authorization", "Bearer " + ANON_KEY);
            request.setHeader("Content-Type", "application/json");
            request.setHeader("Prefer", "return=minimal");

            String jsonBody = gson.toJson(operacion);
            request.setEntity(new StringEntity(jsonBody));

            try (CloseableHttpResponse response = httpClient.execute(request)) {
                return response.getCode() >= 200 && response.getCode() < 300;
            }
        } catch (IOException e) {
            System.err.println("Error creating operacion: " + e.getMessage());
            return false;
        }
    }

    /**
     * Actualizar estado de una operación
     */
    public static boolean actualizarEstadoOperacion(String operacionId, String nuevoEstado) {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            String url = API_BASE_URL + "/operaciones?id=eq." + operacionId;
            HttpPost request = new HttpPost(url);
            request.setHeader("apikey", ANON_KEY);
            request.setHeader("Authorization", "Bearer " + ANON_KEY);
            request.setHeader("Content-Type", "application/json");
            request.setHeader("Prefer", "return=minimal");

            JsonObject updateData = new JsonObject();
            updateData.addProperty("estado", nuevoEstado);
            request.setEntity(new StringEntity(gson.toJson(updateData)));

            try (CloseableHttpResponse response = httpClient.execute(request)) {
                return response.getCode() >= 200 && response.getCode() < 300;
            }
        } catch (IOException e) {
            System.err.println("Error updating operacion: " + e.getMessage());
            return false;
        }
    }

    /**
     * Obtener cliente por ID
     */
    public static JsonObject getClienteById(String clienteId) {
        try {
            List<JsonObject> clientes = fetchData("/clientes?id=eq." + clienteId);
            return clientes.isEmpty() ? null : clientes.get(0);
        } catch (Exception e) {
            System.err.println("Error fetching cliente: " + e.getMessage());
            return null;
        }
    }

    /**
     * Obtener saldo de un cliente
     */
    public static double getSaldoCliente(String clienteId) {
        JsonObject cliente = getClienteById(clienteId);
        if (cliente != null && cliente.has("saldo")) {
            return cliente.get("saldo").getAsDouble();
        }
        return 0.0;
    }

    /**
     * Método privado para hacer fetch de datos
     */
    private static List<JsonObject> fetchData(String endpoint) throws IOException, ParseException {
        List<JsonObject> result = new ArrayList<>();

        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            String url = API_BASE_URL + endpoint;
            HttpGet request = new HttpGet(url);
            request.setHeader("apikey", ANON_KEY);
            request.setHeader("Authorization", "Bearer " + ANON_KEY);
            request.setHeader("Content-Type", "application/json");

            try (CloseableHttpResponse response = httpClient.execute(request)) {
                String jsonString = EntityUtils.toString(response.getEntity());
                
                // Try to parse as JsonArray first
                try {
                    JsonArray jsonArray = gson.fromJson(jsonString, JsonArray.class);
                    if (jsonArray != null) {
                        for (JsonElement element : jsonArray) {
                            result.add(element.getAsJsonObject());
                        }
                    }
                } catch (Exception e) {
                    // If it fails, try to parse as a single JsonObject
                    try {
                        JsonObject jsonObject = gson.fromJson(jsonString, JsonObject.class);
                        if (jsonObject != null && jsonObject.has("message")) {
                            System.err.println("[ERROR] Supabase: " + jsonObject.get("message").getAsString());
                        }
                    } catch (Exception e2) {
                        System.err.println("[ERROR] Unable to parse response: " + e2.getMessage());
                    }
                }
            }
        }

        return result;
    }

    /**
     * Probar conexión a Supabase
     */
    public static boolean testConnection() {
        try {
            List<JsonObject> result = fetchData("/clientes?limit=1");
            System.out.println("✓ Conexión a Supabase exitosa");
            return true;
        } catch (Exception e) {
            System.err.println("✗ Error de conexión a Supabase: " + e.getMessage());
            return false;
        }
    }
}
