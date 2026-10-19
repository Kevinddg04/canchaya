import '../models/cancha.dart';
import '../models/partido.dart';

/// Maneja los partidos creados durante la sesion, todo en memoria
/// (variables y listas), tal como lo pide la restriccion de la actividad:
/// sin base de datos, sin API, sin backend, sin Firebase.
class PartidoService {
  PartidoService._internal();
  static final PartidoService instancia = PartidoService._internal();

  final List<Partido> _partidos = [];
  int _contador = 0;

  List<Partido> obtenerPartidos() => List.unmodifiable(_partidos.reversed);

  Partido crearPartido({
    required Cancha cancha,
    required String deporte,
    required DateTime fecha,
    required String horaTexto,
    required int cuposTotales,
    required String organizador,
  }) {
    _contador++;
    final nuevo = Partido(
      id: 'p$_contador',
      cancha: cancha,
      deporte: deporte,
      fecha: fecha,
      horaTexto: horaTexto,
      cuposTotales: cuposTotales,
      organizador: organizador,
    );
    _partidos.add(nuevo);
    return nuevo;
  }

  /// Funcionalidad principal: un jugador confirma su cupo en un partido.
  /// Devuelve false si el partido ya esta lleno (y no lo modifica).
  bool unirseAPartido(String id) {
    final partido = _partidos.firstWhere((p) => p.id == id);
    if (partido.estaLleno) return false;
    partido.cuposConfirmados++;
    return true;
  }
}
