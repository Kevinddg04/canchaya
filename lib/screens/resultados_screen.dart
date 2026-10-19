import 'package:flutter/material.dart';
import '../services/partido_service.dart';
import '../theme/app_theme.dart';
import '../widgets/partido_tile.dart';
import 'crear_partido_screen.dart';

/// Pantalla 3: Consulta y resultados.
/// Muestra los partidos creados en memoria y permite unirse a ellos
/// (la funcionalidad principal que demuestra como la app resuelve
/// el problema de coordinar partidos).
class ResultadosScreen extends StatefulWidget {
  const ResultadosScreen({super.key});

  @override
  State<ResultadosScreen> createState() => _ResultadosScreenState();
}

class _ResultadosScreenState extends State<ResultadosScreen> {
  void _unirse(String id) {
    final exito = PartidoService.instancia.unirseAPartido(id);
    setState(() {});
    if (!exito) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ese partido ya esta lleno'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Te uniste al partido'),
          backgroundColor: AppColors.primario,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final partidos = PartidoService.instancia.obtenerPartidos();

    return Scaffold(
      appBar: AppBar(title: const Text('Partidos disponibles')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CrearPartidoScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo'),
      ),
      body: partidos.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.sports, size: 60, color: AppColors.textoSuave),
                    const SizedBox(height: 12),
                    const Text(
                      'Todavia no hay partidos creados.\n'
                      'Crea el primero con el boton de abajo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textoSuave),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              itemCount: partidos.length,
              itemBuilder: (context, index) {
                final partido = partidos[index];
                return PartidoTile(
                  partido: partido,
                  onUnirse: () => _unirse(partido.id),
                );
              },
            ),
    );
  }
}
