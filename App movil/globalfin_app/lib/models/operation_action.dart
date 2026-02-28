import 'package:flutter/material.dart';

class OperationAction {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  OperationAction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  // Lista fija de acciones disponibles
  static List<OperationAction> getAllActions() {
    return [
      OperationAction(
        id: 'transfer',
        title: 'Transferir dinero',
        subtitle: 'Envía dinero a otra cuenta bancaria',
        icon: Icons.swap_horiz,
        iconColor: const Color(0xFF2EC4B6),
      ),
      OperationAction(
        id: 'bill',
        title: 'Pagar recibo',
        subtitle: 'Paga facturas y servicios',
        icon: Icons.receipt_long,
        iconColor: const Color(0xFF3F51B5),
      ),
      OperationAction(
        id: 'bizum',
        title: 'Enviar Bizum',
        subtitle: 'Envía dinero instantáneamente',
        icon: Icons.flash_on,
        iconColor: const Color(0xFF00BCD4),
      ),
      OperationAction(
        id: 'check',
        title: 'Ingresar cheque',
        subtitle: 'Ingresa un cheque desde tu móvil',
        icon: Icons.camera_alt,
        iconColor: const Color(0xFF4CAF50),
      ),
      OperationAction(
        id: 'issue',
        title: 'Crear incidencia',
        subtitle: 'Reporta un problema o consulta',
        icon: Icons.support_agent,
        iconColor: const Color(0xFFFF9800),
      ),
    ];
  }
}
