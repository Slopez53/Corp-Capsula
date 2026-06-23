import '../core/money.dart';

/// Tipo de comprador en una venta. Determina el precio por defecto aplicado,
/// pero el precio de cada línea siempre puede editarse manualmente.
enum TipoComprador { vendedor, publico }

/// Origen del precio aplicado a una línea de venta (para auditoría/reportes).
enum PrecioTipo { vendedor, publico, manual }

extension TipoCompradorX on TipoComprador {
  String get label => this == TipoComprador.vendedor ? 'Vendedor' : 'Público';
  String get dbValue => name;
  static TipoComprador fromDb(String value) =>
      value == 'vendedor' ? TipoComprador.vendedor : TipoComprador.publico;
}

extension PrecioTipoX on PrecioTipo {
  String get dbValue => name;
  static PrecioTipo fromDb(String value) => PrecioTipo.values.firstWhere(
        (e) => e.name == value,
        orElse: () => PrecioTipo.manual,
      );
}

/// Precio por defecto de un producto según el tipo de comprador.
Money precioPorTipo({
  required TipoComprador tipo,
  required Money precioVendedor,
  required Money precioPublico,
}) =>
    tipo == TipoComprador.vendedor ? precioVendedor : precioPublico;

/// Una línea de venta para cálculo (modelo puro, sin dependencia de la BD).
class LineaVenta {
  final int productoId;
  final String nombreProducto;
  final double cantidad;
  final Money precioUnitario;
  final PrecioTipo precioTipo;
  final Money? costoUnitario;

  const LineaVenta({
    required this.productoId,
    required this.nombreProducto,
    required this.cantidad,
    required this.precioUnitario,
    required this.precioTipo,
    this.costoUnitario,
  });

  /// Subtotal de la línea = precio unitario × cantidad (redondeado al centavo).
  Money get subtotal => precioUnitario.times(cantidad);

  /// Costo total de la línea (para margen). `null` si no hay costo registrado.
  Money? get costoTotal => costoUnitario?.times(cantidad);

  LineaVenta copyWith({
    double? cantidad,
    Money? precioUnitario,
    PrecioTipo? precioTipo,
  }) =>
      LineaVenta(
        productoId: productoId,
        nombreProducto: nombreProducto,
        cantidad: cantidad ?? this.cantidad,
        precioUnitario: precioUnitario ?? this.precioUnitario,
        precioTipo: precioTipo ?? this.precioTipo,
        costoUnitario: costoUnitario,
      );
}

/// Resultado del cálculo de una venta.
class TotalesVenta {
  final Money subtotal;
  final Money total;
  final Money? costoTotal;

  const TotalesVenta({
    required this.subtotal,
    required this.total,
    this.costoTotal,
  });

  /// Ganancia bruta de la venta (ingreso − costo). `null` si falta algún costo.
  Money? get margen => costoTotal == null ? null : total - costoTotal!;
}

/// Calcula los totales de una venta a partir de sus líneas.
///
/// `total == subtotal` en Fase 1 (sin impuestos ni descuentos globales todavía;
/// se dejará el hueco para añadirlos sin reescribir esta firma).
TotalesVenta calcularTotales(Iterable<LineaVenta> lineas) {
  var subtotal = Money.zero;
  var costo = Money.zero;
  var hayCostoCompleto = lineas.isNotEmpty;

  for (final linea in lineas) {
    subtotal += linea.subtotal;
    final costoLinea = linea.costoTotal;
    if (costoLinea == null) {
      hayCostoCompleto = false;
    } else {
      costo += costoLinea;
    }
  }

  return TotalesVenta(
    subtotal: subtotal,
    total: subtotal,
    costoTotal: hayCostoCompleto ? costo : null,
  );
}

/// Estado de pago de una venta. Soporta el caso "mixto": algunos vendedores
/// pagan al momento (pagado) y otros acumulan deuda (crédito/parcial).
enum EstadoPago { pagado, parcial, credito }

extension EstadoPagoX on EstadoPago {
  String get dbValue => name;
  String get label => switch (this) {
        EstadoPago.pagado => 'Pagado',
        EstadoPago.parcial => 'Parcial',
        EstadoPago.credito => 'Crédito',
      };
  static EstadoPago fromDb(String value) => EstadoPago.values.firstWhere(
        (e) => e.name == value,
        orElse: () => EstadoPago.pagado,
      );
}

/// Determina el estado de pago a partir del monto pagado vs. total.
/// Esta es lógica financiera: cubierta por pruebas.
EstadoPago estadoPagoDe({required Money total, required Money pagado}) {
  if (pagado >= total) return EstadoPago.pagado;
  if (pagado.isPositive) return EstadoPago.parcial;
  return EstadoPago.credito;
}

/// Saldo pendiente de una venta (lo que el cliente aún debe).
Money saldoPendiente({required Money total, required Money pagado}) {
  final saldo = total - pagado;
  return saldo.isNegative ? Money.zero : saldo;
}
