import 'cancha.dart';

class Partido {
  final String id;
  final Cancha cancha;
  final String deporte;
  final DateTime fecha;
  final String horaTexto;
  final int cuposTotales;
  final String organizador;
  int cuposConfirmados;

  Partido({
    required this.id,
    required this.cancha,
    required this.deporte,
    required this.fecha,
    required this.horaTexto,
    required this.cuposTotales,
    required this.organizador,
    this.cuposConfirmados = 1,
  });

  int get cuposDisponibles => cuposTotales - cuposConfirmados;

  bool get estaLleno => cuposDisponibles <= 0;

  String get fechaTexto =>
      '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
}
