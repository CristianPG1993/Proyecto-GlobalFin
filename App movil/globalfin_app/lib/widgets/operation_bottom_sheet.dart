import 'package:flutter/material.dart';
import '../models/operation_action.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'operation_action_item.dart';

class OperationBottomSheet extends StatelessWidget {
  const OperationBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const OperationBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = OperationAction.getAllActions();

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle visual
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Título
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Realizar operación',
              style: AppTextStyles.headerMedium,
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          // Lista de acciones
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: actions.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: AppColors.border,
                indent: 92,
              ),
              itemBuilder: (context, index) {
                final action = actions[index];
                return OperationActionItem(
                  action: action,
                  onTap: () {
                    Navigator.pop(context);
                    // Aquí se navegaría a la pantalla correspondiente
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Navegando a: ${action.title}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Botón cancelar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text(
                  'Cancelar',
                  style: AppTextStyles.buttonSecondary.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
