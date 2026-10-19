class Cancha {
  final String id;
  final String nombre;
  final String direccion;
  final double distanciaKm;
  final int precioHora;
  final List<String> deportesDisponibles;
  final bool techada;

  const Cancha({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.distanciaKm,
    required this.precioHora,
    required this.deportesDisponibles,
    required this.techada,
  });
}
