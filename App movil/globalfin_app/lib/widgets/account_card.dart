import 'package:flutter/material.dart';
import '../models/account.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class AccountCard extends StatelessWidget {
  final Account account;

  const AccountCard({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cardDark,
            AppColors.primaryNavy,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                account.name,
                style: AppTextStyles.headerSmall.copyWith(
                  color: AppColors.textLight,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: account.monthVariation >= 0
                      ? AppColors.success.withOpacity(0.2)
                      : AppColors.error.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      account.monthVariation >= 0
                          ? Icons.trending_up
                          : Icons.trending_down,
                      size: 12,
                      color: account.monthVariation >= 0
                          ? AppColors.success
                          : AppColors.error,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${account.monthVariation.abs()}%',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: account.monthVariation >= 0
                            ? AppColors.success
                            : AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            account.maskedNumber,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textLight.withOpacity(0.7),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '€ ${account.balance.toStringAsFixed(2)}',
            style: AppTextStyles.balanceLarge.copyWith(
              color: AppColors.textLight,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
