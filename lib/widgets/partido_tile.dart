import 'package:flutter/material.dart';
import '../models/partido.dart';
import '../theme/app_theme.dart';

/// Componente personalizado y reutilizable #2.
/// Muestra un partido creado, con su progreso de cupos y el boton
/// para unirse (la funcionalidad principal de la app).
class PartidoTile extends StatelessWidget {
  final Partido partido;
  final VoidCallback onUnirse;

  const PartidoTile({
    super.key,
    required this.partido,
    required this.onUnirse,
  });

  IconData _iconoDeporte(String deporte) {
    switch (deporte) {
      case 'Baloncesto':
        return Icons.sports_basketball;
      case 'Voleibol':
        return Icons.sports_volleyball;
      default:
        return Icons.sports_soccer;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lleno = partido.estaLleno;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_iconoDeporte(partido.deporte), color: AppColors.primario),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${partido.deporte} - ${partido.cancha.nombre}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text('${partido.fechaTexto} - ${partido.horaTexto}'),
            Text('Organiza: ${partido.organizador}'),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: partido.cuposConfirmados / partido.cuposTotales,
                color: lleno ? Colors.red : AppColors.primario,
                backgroundColor: AppColors.primarioClaro,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lleno
                        ? 'Partido lleno'
                        : '${partido.cuposDisponibles} cupos disponibles de ${partido.cuposTotales}',
                    style: TextStyle(
                      color: lleno ? Colors.red : AppColors.textoSuave,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: lleno ? null : onUnirse,
                  child: const Text('Unirme'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
