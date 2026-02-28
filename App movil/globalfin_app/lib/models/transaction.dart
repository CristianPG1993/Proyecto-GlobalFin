import 'package:flutter/material.dart';

enum TransactionType { expense, income }

class Transaction {
  final String id;
  final String title;
  final String date;
  final double amount;
  final TransactionType type;
  final IconData icon;

  Transaction({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.icon,
  });

  bool get isExpense => type == TransactionType.expense;

  // Datos mock de ejemplo
  static List<Transaction> getMockTransactions() {
    return [
      Transaction(
        id: '1',
        title: 'Mercadona',
        date: 'Hoy, 14:30',
        amount: 45.80,
        type: TransactionType.expense,
        icon: Icons.shopping_cart,
      ),
      Transaction(
        id: '2',
        title: 'Transferencia recibida',
        date: 'Hoy, 09:15',
        amount: 850.00,
        type: TransactionType.income,
        icon: Icons.arrow_downward,
      ),
      Transaction(
        id: '3',
        title: 'Netflix',
        date: 'Ayer, 18:45',
        amount: 12.99,
        type: TransactionType.expense,
        icon: Icons.tv,
      ),
      Transaction(
        id: '4',
        title: 'Gasolina Repsol',
        date: 'Ayer, 16:20',
        amount: 65.40,
        type: TransactionType.expense,
        icon: Icons.local_gas_station,
      ),
      Transaction(
        id: '5',
        title: 'Nómina',
        date: '25 Feb',
        amount: 2150.00,
        type: TransactionType.income,
        icon: Icons.work,
      ),
      Transaction(
        id: '6',
        title: 'Amazon',
        date: '24 Feb',
        amount: 89.99,
        type: TransactionType.expense,
        icon: Icons.shopping_bag,
      ),
      Transaction(
        id: '7',
        title: 'Restaurante El Patio',
        date: '23 Feb',
        amount: 52.30,
        type: TransactionType.expense,
        icon: Icons.restaurant,
      ),
    ];
  }
}
