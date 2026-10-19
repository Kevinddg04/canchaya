import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'crear_partido_screen.dart';
import 'resultados_screen.dart';

/// Pantalla 1: Principal.
/// Presenta la app y da acceso a las otras dos pantallas.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CanchaYa')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sports_soccer, size: 90, color: AppColors.primario),
              const SizedBox(height: 16),
              const Text(
                'CanchaYa',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.texto,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Organiza partidos amateur con tus amigos sin tanta vuelta por '
                'WhatsApp: crea un partido, elige la cancha y avisa cuando '
                'falten jugadores.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textoSuave, fontSize: 15),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Crear un partido'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CrearPartidoScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.list_alt),
                  label: const Text('Ver partidos disponibles'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ResultadosScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
