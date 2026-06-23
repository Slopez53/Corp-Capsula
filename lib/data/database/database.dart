import 'package:drift/drift.dart';

import '../../core/money.dart';
import '../../domain/pricing.dart';
import 'connection.dart';
import 'tables.dart';

part 'database.g.dart';

/// Datos para registrar una línea de venta (entrada a `registrarVenta`).
class LineaVentaInput {
  final int productoId;
  final String nombreProducto;
  final double cantidad;
  final Money precioUnitario;
  final PrecioTipo precioTipo;
  final Money? costoUnitario;

  const LineaVentaInput({
    required this.productoId,
    required this.nombreProducto,
    required this.cantidad,
    required this.precioUnitario,
    required this.precioTipo,
    this.costoUnitario,
  });
}

/// Resumen del cierre del día.
class CierreDia {
  final int cantidadVentas;
  final Money totalVendido;
  final Money totalCobrado;
  final Money totalCredito;
  final Map<String, ({double cantidad, Money total})> porProducto;
  final Map<String, Money> porComprador; // 'Vendedor' / 'Público'

  const CierreDia({
    required this.cantidadVentas,
    required this.totalVendido,
    required this.totalCobrado,
    required this.totalCredito,
    required this.porProducto,
    required this.porComprador,
  });

  static const empty = CierreDia(
    cantidadVentas: 0,
    totalVendido: Money.zero,
    totalCobrado: Money.zero,
    totalCredito: Money.zero,
    porProducto: {},
    porComprador: {},
  );
}

@DriftDatabase(
  tables: [
    Categorias,
    Productos,
    HistorialPrecios,
    Clientes,
    Ventas,
    DetalleVentas,
    MovimientosInventario,
    Gastos,
    Deudas,
    PagosDeuda,
    Usuarios,
    Auditorias,
    PreferenciasVisualizacion,
    Configuraciones,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  /// Constructor para pruebas (inyecta un ejecutor en memoria).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seed();
        },
        beforeOpen: (details) async {
          // Integridad referencial siempre activa.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Datos iniciales mínimos para que la app sea usable desde el primer arranque.
  Future<void> _seed() async {
    await batch((b) {
      b.insertAll(categorias, [
        CategoriasCompanion.insert(nombre: 'Pan salado', orden: const Value(0)),
        CategoriasCompanion.insert(nombre: 'Pan dulce', orden: const Value(1)),
        CategoriasCompanion.insert(nombre: 'Otros', orden: const Value(2)),
      ]);
      b.insertAll(configuraciones, [
        ConfiguracionesCompanion.insert(clave: 'moneda_codigo', valor: 'DOP'),
        ConfiguracionesCompanion.insert(clave: 'moneda_simbolo', valor: r'RD$'),
        ConfiguracionesCompanion.insert(clave: 'tema', valor: 'system'),
      ]);
      b.insert(
        usuarios,
        UsuariosCompanion.insert(nombre: 'Dueño', rol: const Value('dueno')),
      );
    });
  }

  // ---------------------------------------------------------------- Categorías
  Stream<List<Categoria>> watchCategorias() => (select(categorias)
        ..where((c) => c.deletedAt.isNull())
        ..orderBy([(c) => OrderingTerm(expression: c.orden)]))
      .watch();

  Future<int> insertCategoria(String nombre) =>
      into(categorias).insert(CategoriasCompanion.insert(nombre: nombre));

  // ----------------------------------------------------------------- Productos
  Stream<List<Producto>> watchProductos() => (select(productos)
        ..where((p) => p.deletedAt.isNull())
        ..orderBy([(p) => OrderingTerm(expression: p.nombre)]))
      .watch();

  Future<List<Producto>> productosActivos() => (select(productos)
        ..where((p) => p.deletedAt.isNull() & p.estado.equals('activo')))
      .get();

  Future<int> crearProducto(ProductosCompanion data) =>
      into(productos).insert(data);

  /// Actualiza un producto y registra en el historial cualquier cambio de
  /// precio o costo (auditoría exigida en 2.1).
  Future<void> actualizarProducto(
    Producto anterior,
    ProductosCompanion cambios,
  ) async {
    await transaction(() async {
      await (update(productos)..where((p) => p.id.equals(anterior.id)))
          .write(cambios.copyWith(updatedAt: Value(DateTime.now())));

      Future<void> registrar(
        String tipo,
        int? viejo,
        Value<int?> nuevoVal,
      ) async {
        if (!nuevoVal.present) return;
        final nuevo = nuevoVal.value;
        if (nuevo == null || nuevo == viejo) return;
        await into(historialPrecios).insert(HistorialPreciosCompanion.insert(
          productoId: anterior.id,
          tipoPrecio: tipo,
          precioAnterior: Value(viejo),
          precioNuevo: nuevo,
        ));
      }

      await registrar('vendedor', anterior.precioVendedor,
          cambios.precioVendedor.present
              ? Value(cambios.precioVendedor.value)
              : const Value.absent());
      await registrar('publico', anterior.precioPublico,
          cambios.precioPublico.present
              ? Value(cambios.precioPublico.value)
              : const Value.absent());
      await registrar(
          'costo', anterior.costoProduccion, cambios.costoProduccion);
    });
  }

  /// Borrado lógico (papelera).
  Future<void> eliminarProducto(int id) =>
      (update(productos)..where((p) => p.id.equals(id)))
          .write(ProductosCompanion(deletedAt: Value(DateTime.now())));

  Stream<List<HistorialPrecio>> watchHistorialPrecios(int productoId) =>
      (select(historialPrecios)
            ..where((h) => h.productoId.equals(productoId))
            ..orderBy([
              (h) => OrderingTerm(
                  expression: h.createdAt, mode: OrderingMode.desc)
            ]))
          .watch();

  /// Productos cuyo stock está en o por debajo del mínimo (alerta visual).
  Stream<List<Producto>> watchProductosBajoStock() => (select(productos)
        ..where((p) =>
            p.deletedAt.isNull() &
            p.estado.equals('activo') &
            p.stockActual.isSmallerOrEqual(p.stockMinimo)))
      .watch();

  // ------------------------------------------------------------------ Clientes
  Stream<List<Cliente>> watchClientes() => (select(clientes)
        ..where((c) => c.deletedAt.isNull())
        ..orderBy([(c) => OrderingTerm(expression: c.nombre)]))
      .watch();

  /// Alta rápida de comprador (vendedor nuevo / ocasional) en segundos.
  Future<int> crearClienteRapido({
    required String nombre,
    String tipo = 'nuevo',
    String? contacto,
  }) =>
      into(clientes).insert(ClientesCompanion.insert(
        nombre: nombre,
        tipo: Value(tipo),
        contacto: Value(contacto),
      ));

  Future<int> crearCliente(ClientesCompanion data) =>
      into(clientes).insert(data);

  Future<void> eliminarCliente(int id) =>
      (update(clientes)..where((c) => c.id.equals(id)))
          .write(ClientesCompanion(deletedAt: Value(DateTime.now())));

  // -------------------------------------------------------------------- Ventas
  /// Registra una venta completa de forma atómica:
  ///  - cabecera + detalles (con precios fotografiados)
  ///  - descuento de inventario + movimiento por cada línea
  ///  - si queda saldo, crea la deuda por cobrar asociada (caso "mixto")
  Future<int> registrarVenta({
    int? clienteId,
    required TipoComprador tipoComprador,
    required List<LineaVentaInput> lineas,
    required Money montoPagado,
    String? nota,
    DateTime? fecha,
  }) async {
    if (lineas.isEmpty) {
      throw ArgumentError('Una venta debe tener al menos una línea');
    }

    return transaction(() async {
      final dominio = lineas
          .map((l) => LineaVenta(
                productoId: l.productoId,
                nombreProducto: l.nombreProducto,
                cantidad: l.cantidad,
                precioUnitario: l.precioUnitario,
                precioTipo: l.precioTipo,
                costoUnitario: l.costoUnitario,
              ))
          .toList();
      final totales = calcularTotales(dominio);
      final estado =
          estadoPagoDe(total: totales.total, pagado: montoPagado);
      final cuando = fecha ?? DateTime.now();

      final ventaId = await into(ventas).insert(VentasCompanion.insert(
        clienteId: Value(clienteId),
        tipoComprador: tipoComprador.dbValue,
        subtotal: Value(totales.subtotal.cents),
        total: Value(totales.total.cents),
        estadoPago: Value(estado.dbValue),
        montoPagado: Value(montoPagado.cents),
        costoTotal: Value(totales.costoTotal?.cents),
        nota: Value(nota),
        fecha: Value(cuando),
      ));

      for (final l in lineas) {
        final subtotalLinea = l.precioUnitario.times(l.cantidad);
        await into(detalleVentas).insert(DetalleVentasCompanion.insert(
          ventaId: ventaId,
          productoId: l.productoId,
          nombreProducto: l.nombreProducto,
          cantidad: l.cantidad,
          precioUnitario: l.precioUnitario.cents,
          precioTipo: l.precioTipo.dbValue,
          costoUnitario: Value(l.costoUnitario?.cents),
          subtotalLinea: subtotalLinea.cents,
        ));

        // Descontar stock (la venta a crédito también descuenta inventario).
        await (update(productos)..where((p) => p.id.equals(l.productoId)))
            .write(ProductosCompanion.custom(
          stockActual: productos.stockActual - Variable<double>(l.cantidad),
          updatedAt: Variable<DateTime>(DateTime.now()),
        ));

        await into(movimientosInventario)
            .insert(MovimientosInventarioCompanion.insert(
          productoId: l.productoId,
          tipo: 'venta',
          cantidad: -l.cantidad,
          referenciaId: Value(ventaId),
        ));
      }

      // Deuda por cobrar si la venta no quedó totalmente pagada.
      final saldo = saldoPendiente(total: totales.total, pagado: montoPagado);
      if (saldo.isPositive) {
        await into(deudas).insert(DeudasCompanion.insert(
          direccion: 'por_cobrar',
          clienteId: Value(clienteId),
          origenVentaId: Value(ventaId),
          montoOriginal: saldo.cents,
          estado: Value(montoPagado.isPositive ? 'parcial' : 'pendiente'),
          descripcion: Value('Venta a crédito #$ventaId'),
          fecha: Value(cuando),
        ));
      }

      return ventaId;
    });
  }

  /// Cierre del día: totales, desglose por producto y por tipo de comprador.
  Future<CierreDia> cierreDelDia(DateTime dia) async {
    final inicio = DateTime(dia.year, dia.month, dia.day);
    final fin = inicio.add(const Duration(days: 1));

    final ventasDia = await (select(ventas)
          ..where((v) =>
              v.deletedAt.isNull() &
              v.fecha.isBiggerOrEqualValue(inicio) &
              v.fecha.isSmallerThanValue(fin)))
        .get();

    if (ventasDia.isEmpty) return CierreDia.empty;

    var totalVendido = Money.zero;
    var totalCobrado = Money.zero;
    final porComprador = <String, Money>{};

    for (final v in ventasDia) {
      totalVendido += Money(v.total);
      totalCobrado += Money(v.montoPagado);
      final etiqueta = TipoCompradorX.fromDb(v.tipoComprador).label;
      porComprador[etiqueta] =
          (porComprador[etiqueta] ?? Money.zero) + Money(v.total);
    }

    final ids = ventasDia.map((v) => v.id).toList();
    final detalles = await (select(detalleVentas)
          ..where((d) => d.ventaId.isIn(ids)))
        .get();

    final porProducto = <String, ({double cantidad, Money total})>{};
    for (final d in detalles) {
      final prev = porProducto[d.nombreProducto] ??
          (cantidad: 0.0, total: Money.zero);
      porProducto[d.nombreProducto] = (
        cantidad: prev.cantidad + d.cantidad,
        total: prev.total + Money(d.subtotalLinea),
      );
    }

    return CierreDia(
      cantidadVentas: ventasDia.length,
      totalVendido: totalVendido,
      totalCobrado: totalCobrado,
      totalCredito: totalVendido - totalCobrado,
      porProducto: porProducto,
      porComprador: porComprador,
    );
  }

  // ------------------------------------------------------------ Configuración
  Future<String?> getConfig(String clave) async {
    final row = await (select(configuraciones)
          ..where((c) => c.clave.equals(clave)))
        .getSingleOrNull();
    return row?.valor;
  }

  Future<void> setConfig(String clave, String valor) => into(configuraciones)
      .insertOnConflictUpdate(
          ConfiguracionesCompanion.insert(clave: clave, valor: valor));
}
