import 'package:flutter/material.dart';
import '../models/cancha.dart';
import '../theme/app_theme.dart';

/// Componente personalizado y reutilizable #1.
/// Muestra la informacion de una cancha y permite seleccionarla.
class CanchaCard extends StatelessWidget {
  final Cancha cancha;
  final VoidCallback? onTap;
  final bool seleccionada;

  const CanchaCard({
    super.key,
    required this.cancha,
    this.onTap,
    this.seleccionada = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: seleccionada ? AppColors.primario : Colors.transparent,
          width: 2,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.primarioClaro,
          child: Icon(
            cancha.techada ? Icons.home_work : Icons.grass,
            color: AppColors.primario,
          ),
        ),
        title: Text(
          cancha.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${cancha.distanciaKm} km - ${cancha.direccion}\n\$${cancha.precioHora}/hora',
        ),
        isThreeLine: true,
        trailing: seleccionada
            ? const Icon(Icons.check_circle, color: AppColors.primario)
            : null,
      ),
    );
  }
}
