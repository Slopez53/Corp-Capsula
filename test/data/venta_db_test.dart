import 'package:corp_capsula/core/money.dart';
import 'package:corp_capsula/data/database/database.dart';
import 'package:corp_capsula/domain/pricing.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  Future<int> crearPan({double stock = 100}) =>
      db.crearProducto(ProductosCompanion.insert(
        nombre: 'Pan sobado',
        precioVendedor: const Value(500),
        precioPublico: const Value(800),
        costoProduccion: const Value(300),
        stockActual: Value(stock),
      ));

  test('seed inicial crea categorías y configuración', () async {
    final cats = await db.select(db.categorias).get();
    expect(cats.length, 3);
    expect(await db.getConfig('moneda_simbolo'), r'RD$');
  });

  test('venta pagada descuenta stock y NO crea deuda', () async {
    final panId = await crearPan(stock: 100);

    final ventaId = await db.registrarVenta(
      tipoComprador: TipoComprador.vendedor,
      montoPagado: Money(5000), // 10 × 500 = 5000, pagado completo
      lineas: [
        LineaVentaInput(
          productoId: panId,
          nombreProducto: 'Pan sobado',
          cantidad: 10,
          precioUnitario: Money(500),
          precioTipo: PrecioTipo.vendedor,
          costoUnitario: Money(300),
        ),
      ],
    );

    final venta = await (db.select(db.ventas)
          ..where((v) => v.id.equals(ventaId)))
        .getSingle();
    expect(venta.total, 5000);
    expect(venta.estadoPago, 'pagado');
    expect(venta.costoTotal, 3000);

    final pan =
        await (db.select(db.productos)..where((p) => p.id.equals(panId)))
            .getSingle();
    expect(pan.stockActual, 90); // 100 - 10

    final deudas = await db.select(db.deudas).get();
    expect(deudas, isEmpty);

    final movs = await db.select(db.movimientosInventario).get();
    expect(movs.single.cantidad, -10);
  });

  test('venta a crédito descuenta stock y crea deuda por cobrar', () async {
    final panId = await crearPan(stock: 50);

    final ventaId = await db.registrarVenta(
      tipoComprador: TipoComprador.vendedor,
      montoPagado: Money.zero, // crédito puro
      lineas: [
        LineaVentaInput(
          productoId: panId,
          nombreProducto: 'Pan sobado',
          cantidad: 20,
          precioUnitario: Money(500),
          precioTipo: PrecioTipo.vendedor,
        ),
      ],
    );

    final pan =
        await (db.select(db.productos)..where((p) => p.id.equals(panId)))
            .getSingle();
    expect(pan.stockActual, 30); // descuenta aunque sea a crédito

    final deuda = await db.select(db.deudas).getSingle();
    expect(deuda.direccion, 'por_cobrar');
    expect(deuda.montoOriginal, 10000); // 20 × 500
    expect(deuda.estado, 'pendiente');
    expect(deuda.origenVentaId, ventaId);
  });

  test('venta con pago parcial crea deuda parcial por el saldo', () async {
    final panId = await crearPan();

    await db.registrarVenta(
      tipoComprador: TipoComprador.publico,
      montoPagado: Money(3000), // total 8000, paga 3000
      lineas: [
        LineaVentaInput(
          productoId: panId,
          nombreProducto: 'Pan sobado',
          cantidad: 10,
          precioUnitario: Money(800),
          precioTipo: PrecioTipo.publico,
        ),
      ],
    );

    final deuda = await db.select(db.deudas).getSingle();
    expect(deuda.montoOriginal, 5000); // 8000 - 3000
    expect(deuda.estado, 'parcial');
  });

  test('actualizar precio registra el cambio en el historial', () async {
    final panId = await crearPan();
    final pan =
        await (db.select(db.productos)..where((p) => p.id.equals(panId)))
            .getSingle();

    await db.actualizarProducto(
      pan,
      const ProductosCompanion(precioVendedor: Value(600)),
    );

    final hist = await db.select(db.historialPrecios).get();
    expect(hist.single.tipoPrecio, 'vendedor');
    expect(hist.single.precioAnterior, 500);
    expect(hist.single.precioNuevo, 600);
  });

  test('cierre del día agrega totales y desglose', () async {
    final panId = await crearPan();
    final hoy = DateTime.now();

    await db.registrarVenta(
      tipoComprador: TipoComprador.vendedor,
      montoPagado: Money(5000),
      lineas: [
        LineaVentaInput(
          productoId: panId,
          nombreProducto: 'Pan sobado',
          cantidad: 10,
          precioUnitario: Money(500),
          precioTipo: PrecioTipo.vendedor,
        ),
      ],
    );
    await db.registrarVenta(
      tipoComprador: TipoComprador.publico,
      montoPagado: Money.zero, // crédito
      lineas: [
        LineaVentaInput(
          productoId: panId,
          nombreProducto: 'Pan sobado',
          cantidad: 5,
          precioUnitario: Money(800),
          precioTipo: PrecioTipo.publico,
        ),
      ],
    );

    final cierre = await db.cierreDelDia(hoy);
    expect(cierre.cantidadVentas, 2);
    expect(cierre.totalVendido, Money(9000)); // 5000 + 4000
    expect(cierre.totalCobrado, Money(5000));
    expect(cierre.totalCredito, Money(4000));
    expect(cierre.porProducto['Pan sobado']!.cantidad, 15);
    expect(cierre.porComprador['Vendedor'], Money(5000));
    expect(cierre.porComprador['Público'], Money(4000));
  });

  test('rechaza venta sin líneas', () async {
    expect(
      () => db.registrarVenta(
        tipoComprador: TipoComprador.publico,
        montoPagado: Money.zero,
        lineas: [],
      ),
      throwsArgumentError,
    );
  });
}
