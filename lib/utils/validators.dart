/// Funciones de validacion reutilizadas por los formularios de la app.
class Validators {
  static String? requerido(String? valor, {String campo = 'Este campo'}) {
    if (valor == null || valor.trim().isEmpty) {
      return '$campo es obligatorio';
    }
    return null;
  }

  static String? cupos(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Ingresa el numero de cupos';
    }
    final numero = int.tryParse(valor);
    if (numero == null) {
      return 'Debe ser un numero valido';
    }
    if (numero < 2 || numero > 30) {
      return 'Debe estar entre 2 y 30 jugadores';
    }
    return null;
  }
}
