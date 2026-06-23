import 'package:corp_capsula/core/money.dart';
import 'package:corp_capsula/domain/pricing.dart';
import 'package:flutter_test/flutter_test.dart';

LineaVenta _linea({
  required double cantidad,
  required int precio,
  PrecioTipo tipo = PrecioTipo.vendedor,
  int? costo,
}) =>
    LineaVenta(
      productoId: 1,
      nombreProducto: 'Pan',
      cantidad: cantidad,
      precioUnitario: Money(precio),
      precioTipo: tipo,
      costoUnitario: costo == null ? null : Money(costo),
    );

void main() {
  group('precioPorTipo', () {
    test('vendedor obtiene precio mayorista, público el de detalle', () {
      expect(
        precioPorTipo(
          tipo: TipoComprador.vendedor,
          precioVendedor: Money(1000),
          precioPublico: Money(1500),
        ),
        Money(1000),
      );
      expect(
        precioPorTipo(
          tipo: TipoComprador.publico,
          precioVendedor: Money(1000),
          precioPublico: Money(1500),
        ),
        Money(1500),
      );
    });
  });

  group('LineaVenta', () {
    test('subtotal = precio × cantidad', () {
      expect(_linea(cantidad: 3, precio: 1500).subtotal, Money(4500));
      expect(_linea(cantidad: 2.5, precio: 1000).subtotal, Money(2500));
    });

    test('costoTotal es null si no hay costo', () {
      expect(_linea(cantidad: 3, precio: 1500).costoTotal, isNull);
      expect(_linea(cantidad: 3, precio: 1500, costo: 800).costoTotal,
          Money(2400));
    });
  });

  group('calcularTotales', () {
    test('suma varias líneas', () {
      final totales = calcularTotales([
        _linea(cantidad: 3, precio: 1500), // 4500
        _linea(cantidad: 2, precio: 1000), // 2000
        _linea(cantidad: 1.5, precio: 800), // 1200
      ]);
      expect(totales.subtotal, Money(7700));
      expect(totales.total, Money(7700));
    });

    test('margen = total − costo cuando todas las líneas tienen costo', () {
      final totales = calcularTotales([
        _linea(cantidad: 10, precio: 1000, costo: 600), // ingreso 10000, costo 6000
        _linea(cantidad: 5, precio: 2000, costo: 1200), // ingreso 10000, costo 6000
      ]);
      expect(totales.total, Money(20000));
      expect(totales.costoTotal, Money(12000));
      expect(totales.margen, Money(8000));
    });

    test('margen es null si falta el costo de alguna línea', () {
      final totales = calcularTotales([
        _linea(cantidad: 10, precio: 1000, costo: 600),
        _linea(cantidad: 5, precio: 2000), // sin costo
      ]);
      expect(totales.costoTotal, isNull);
      expect(totales.margen, isNull);
    });

    test('lista vacía da cero', () {
      final totales = calcularTotales([]);
      expect(totales.total, Money.zero);
    });
  });

  group('estado de pago y saldo (caso mixto)', () {
    test('pagado completo', () {
      expect(estadoPagoDe(total: Money(5000), pagado: Money(5000)),
          EstadoPago.pagado);
      expect(estadoPagoDe(total: Money(5000), pagado: Money(6000)),
          EstadoPago.pagado);
    });

    test('pago parcial', () {
      expect(estadoPagoDe(total: Money(5000), pagado: Money(2000)),
          EstadoPago.parcial);
    });

    test('crédito (no pagó nada)', () {
      expect(estadoPagoDe(total: Money(5000), pagado: Money.zero),
          EstadoPago.credito);
    });

    test('saldo pendiente nunca es negativo', () {
      expect(saldoPendiente(total: Money(5000), pagado: Money(2000)),
          Money(3000));
      expect(saldoPendiente(total: Money(5000), pagado: Money(8000)),
          Money.zero);
    });
  });
}
