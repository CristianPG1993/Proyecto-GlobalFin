import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/transaction.dart';

class SupabaseService {
  static const String projectUrl = 'https://etlqpvghtqiqofepukqf.supabase.co';
  static const String anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV0bHFwdmdodHFpcW9mZXB1a3FmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIyOTE2NTUsImV4cCI6MjA4Nzg2NzY1NX0.ulub2ohijz4Lcq6MtWr65ivmz9ehYnRonVA5osqnyMM';

  static final SupabaseClient _client = Supabase.instance.client;

  /// Obtener todos los clientes
  static Future<List<Map<String, dynamic>>> getClientes() async {
    try {
      final response = await _client.from('clientes').select();
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      print('Error fetching clientes: $e');
      return [];
    }
  }

  /// Obtener todas las operaciones
  static Future<List<Map<String, dynamic>>> getOperaciones() async {
    try {
      final response = await _client.from('operaciones').select();
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      print('Error fetching operaciones: $e');
      return [];
    }
  }

  /// Obtener todas las transacciones
  static Future<List<Map<String, dynamic>>> getTransacciones() async {
    try {
      final response = await _client.from('transacciones').select();
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      print('Error fetching transacciones: $e');
      return [];
    }
  }

  /// Obtener transacciones de un cliente específico
  static Future<List<Transaction>> getTransaccionesPorCliente(String clienteId) async {
    try {
      final response = await _client
          .from('transacciones')
          .select()
          .eq('id_cliente', clienteId);

      return (response as List)
          .map((e) {
            final rawTipo = (e['tipo'] ?? '').toString().toLowerCase();
            final isExpense = rawTipo.contains('gasto') || rawTipo.contains('debito') || rawTipo.contains('retiro');
            final amount = double.tryParse((e['monto'] ?? 0).toString()) ?? 0.0;

            return Transaction(
              id: (e['id'] ?? 'unknown').toString(),
              title: (e['descripcion'] ?? 'Transacción').toString(),
              date: (e['fecha'] ?? DateTime.now().toIso8601String()).toString(),
              amount: amount.abs(),
              type: isExpense ? TransactionType.expense : TransactionType.income,
              icon: isExpense ? Icons.arrow_upward : Icons.arrow_downward,
            );
          })
          .toList();
    } catch (e) {
      print('Error fetching transacciones por cliente: $e');
      return [];
    }
  }

  /// Crear una nueva operación
  static Future<bool> crearOperacion({
    required String clienteId,
    required double monto,
    required String tipo,
    required String descripcion,
  }) async {
    try {
      await _client.from('operaciones').insert({
        'id_cliente': clienteId,
        'monto': monto,
        'tipo': tipo,
        'descripcion': descripcion,
        'estado': 'Pendiente',
        'nivel_riesgo': 'Bajo',
        'canal': 'Móvil',
      });
      return true;
    } catch (e) {
      print('Error creating operacion: $e');
      return false;
    }
  }

  /// Obtener cliente por ID
  static Future<Map<String, dynamic>?> getClienteById(String id) async {
    try {
      final response = await _client
          .from('clientes')
          .select()
          .eq('id', id)
          .single();
      return response as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching cliente: $e');
      return null;
    }
  }

  /// Obtener saldo de un cliente
  static Future<double> getSaldoCliente(String clienteId) async {
    try {
      final response = await _client
          .from('clientes')
          .select('saldo')
          .eq('id', clienteId)
          .single();
      return double.tryParse(response['saldo'].toString()) ?? 0.0;
    } catch (e) {
      print('Error fetching saldo: $e');
      return 0.0;
    }
  }

  /// Actualizar estado de una operación
  static Future<bool> actualizarEstadoOperacion(String operacionId, String nuevoEstado) async {
    try {
      await _client
          .from('operaciones')
          .update({'estado': nuevoEstado})
          .eq('id', operacionId);
      return true;
    } catch (e) {
      print('Error updating operacion: $e');
      return false;
    }
  }
}
