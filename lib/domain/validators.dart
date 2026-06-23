import '../core/money.dart';

/// Validaciones de formularios y reglas de negocio. Devuelven `null` cuando el
/// valor es válido, o un mensaje de error legible cuando no lo es. Puras y
/// testeables, sin dependencia de Flutter.
class Validators {
  Validators._();

  /// Nombre obligatorio, sin espacios sobrantes.
  static String? nombre(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre es obligatorio';
    }
    if (value.trim().length > 120) {
      return 'El nombre es demasiado largo';
    }
    return null;
  }

  /// Precio: debe ser un número válido y mayor que cero (no se permite 0).
  static String? precio(String? value) {
    final money = Money.tryParse(value ?? '');
    if (money == null) return 'Precio inválido';
    if (money.cents <= 0) return 'El precio debe ser mayor que cero';
    return null;
  }

  /// Costo opcional: si se indica, no puede ser negativo.
  static String? costoOpcional(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final money = Money.tryParse(value);
    if (money == null) return 'Costo inválido';
    if (money.isNegative) return 'El costo no puede ser negativo';
    return null;
  }

  /// Cantidad de stock o de venta: número válido, no negativo.
  static String? cantidadNoNegativa(String? value) {
    if (value == null || value.trim().isEmpty) return 'Cantidad requerida';
    final n = num.tryParse(value.trim());
    if (n == null) return 'Cantidad inválida';
    if (n < 0) return 'La cantidad no puede ser negativa';
    return null;
  }

  /// Cantidad de venta: número válido y estrictamente mayor que cero.
  static String? cantidadVenta(String? value) {
    if (value == null || value.trim().isEmpty) return 'Cantidad requerida';
    final n = num.tryParse(value.trim());
    if (n == null) return 'Cantidad inválida';
    if (n <= 0) return 'La cantidad debe ser mayor que cero';
    return null;
  }
}
