import '../models/cancha.dart';

/// Servicio en memoria (sin base de datos ni API) que simula el catalogo
/// de canchas disponibles. Sigue el patron Singleton para que todas las
/// pantallas compartan la misma informacion durante la sesion.
class CanchaService {
  CanchaService._internal();
  static final CanchaService instancia = CanchaService._internal();

  final List<Cancha> _canchas = [
    const Cancha(
      id: 'c1',
      nombre: 'Cancha El Golazo',
      direccion: 'Cra 45 #10-20',
      distanciaKm: 0.8,
      precioHora: 40000,
      deportesDisponibles: ['Futbol'],
      techada: false,
    ),
    const Cancha(
      id: 'c2',
      nombre: 'Polideportivo Norte',
      direccion: 'Cl 72 #50-15',
      distanciaKm: 1.2,
      precioHora: 30000,
      deportesDisponibles: ['Baloncesto', 'Voleibol'],
      techada: true,
    ),
    const Cancha(
      id: 'c3',
      nombre: 'Cancha Los Andes',
      direccion: 'Cra 38 #82-40',
      distanciaKm: 2.0,
      precioHora: 25000,
      deportesDisponibles: ['Futbol', 'Baloncesto'],
      techada: false,
    ),
  ];

  List<Cancha> obtenerCanchas() => List.unmodifiable(_canchas);
}
