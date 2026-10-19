import 'package:flutter/material.dart';
import '../models/cancha.dart';
import '../services/cancha_service.dart';
import '../services/partido_service.dart';
import '../theme/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/cancha_card.dart';
import 'resultados_screen.dart';

/// Pantalla 2: Registro / ingreso de informacion.
/// Formulario para capturar los datos del nuevo partido.
class CrearPartidoScreen extends StatefulWidget {
  const CrearPartidoScreen({super.key});

  @override
  State<CrearPartidoScreen> createState() => _CrearPartidoScreenState();
}

class _CrearPartidoScreenState extends State<CrearPartidoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _cuposController = TextEditingController(text: '10');

  final List<String> _deportes = const ['Futbol', 'Baloncesto', 'Voleibol'];
  String _deporteSeleccionado = 'Futbol';

  Cancha? _canchaSeleccionada;
  DateTime? _fechaSeleccionada;
  TimeOfDay? _horaSeleccionada;
  bool _notificarCupos = true;

  @override
  void initState() {
    super.initState();
    _canchaSeleccionada = CanchaService.instancia.obtenerCanchas().first;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _cuposController.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha() async {
    final hoy = DateTime.now();
    final seleccion = await showDatePicker(
      context: context,
      initialDate: hoy,
      firstDate: hoy,
      lastDate: hoy.add(const Duration(days: 60)),
    );
    if (seleccion != null) {
      setState(() => _fechaSeleccionada = seleccion);
    }
  }

  Future<void> _elegirHora() async {
    final seleccion = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 0),
    );
    if (seleccion != null) {
      setState(() => _horaSeleccionada = seleccion);
    }
  }

  void _guardarPartido() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_fechaSeleccionada == null || _horaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona la fecha y la hora del partido'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    PartidoService.instancia.crearPartido(
      cancha: _canchaSeleccionada!,
      deporte: _deporteSeleccionado,
      fecha: _fechaSeleccionada!,
      horaTexto: _horaSeleccionada!.format(context),
      cuposTotales: int.parse(_cuposController.text),
      organizador: _nombreController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Partido creado con exito'),
        backgroundColor: AppColors.primario,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ResultadosScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canchas = CanchaService.instancia.obtenerCanchas();

    return Scaffold(
      appBar: AppBar(title: const Text('Crear partido')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Tu nombre', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _nombreController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: 'Ej: Kevin Diaz'),
              validator: (v) => Validators.requerido(v, campo: 'Tu nombre'),
            ),
            const SizedBox(height: 20),

            const Text('Deporte', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _deporteSeleccionado,
              items: _deportes
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (valor) {
                setState(() => _deporteSeleccionado = valor!);
              },
            ),
            const SizedBox(height: 20),

            const Text('Cancha', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...canchas.map(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CanchaCard(
                  cancha: c,
                  seleccionada: _canchaSeleccionada?.id == c.id,
                  onTap: () => setState(() => _canchaSeleccionada = c),
                ),
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'Cupos (jugadores necesarios)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: _cuposController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Ej: 10'),
              validator: Validators.cupos,
            ),
            const SizedBox(height: 20),

            const Text('Fecha y hora', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _fechaSeleccionada == null
                          ? 'Elegir fecha'
                          : '${_fechaSeleccionada!.day}/${_fechaSeleccionada!.month}/${_fechaSeleccionada!.year}',
                    ),
                    onPressed: _elegirFecha,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.access_time),
                    label: Text(
                      _horaSeleccionada == null
                          ? 'Elegir hora'
                          : _horaSeleccionada!.format(context),
                    ),
                    onPressed: _elegirHora,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _notificarCupos,
              title: const Text('Avisarme cuando falten pocos cupos'),
              onChanged: (valor) => setState(() => _notificarCupos = valor),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _guardarPartido,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Publicar partido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
