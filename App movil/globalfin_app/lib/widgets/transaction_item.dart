import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          // Icono de categoría
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: transaction.isExpense
                  ? AppColors.expense.withOpacity(0.1)
                  : AppColors.income.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              transaction.icon,
              color: transaction.isExpense ? AppColors.expense : AppColors.income,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Nombre y fecha
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: AppTextStyles.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.date,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Importe
          Text(
            '${transaction.isExpense ? '-' : '+'}€ ${transaction.amount.toStringAsFixed(2)}',
            style: transaction.isExpense
                ? AppTextStyles.amountNegative
                : AppTextStyles.amountPositive,
          ),
        ],
      ),
    );
  }
}
