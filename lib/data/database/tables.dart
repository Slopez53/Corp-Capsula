import 'package:drift/drift.dart';

/// Esquema completo (Fase 0). Todo el dinero se guarda como ENTERO en centavos.
/// Las cantidades (stock, líneas de venta) son `real` para permitir ventas por
/// libra/fracción. Soft-delete vía `deletedAt` en las tablas de negocio.

mixin _Auditable on Table {
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

class Categorias extends Table with _Auditable {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 80)();
  IntColumn get orden => integer().withDefault(const Constant(0))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
}

class Productos extends Table with _Auditable {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 120)();
  IntColumn get categoriaId =>
      integer().nullable().references(Categorias, #id)();
  TextColumn get unidadVenta => text().withDefault(const Constant('pieza'))();
  IntColumn get precioVendedor => integer().withDefault(const Constant(0))();
  IntColumn get precioPublico => integer().withDefault(const Constant(0))();
  IntColumn get costoProduccion => integer().nullable()();
  RealColumn get stockActual => real().withDefault(const Constant(0))();
  RealColumn get stockMinimo => real().withDefault(const Constant(0))();
  // 'activo' | 'descontinuado'
  TextColumn get estado => text().withDefault(const Constant('activo'))();
}

class HistorialPrecios extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productoId => integer().references(Productos, #id)();
  // 'vendedor' | 'publico' | 'costo'
  TextColumn get tipoPrecio => text()();
  IntColumn get precioAnterior => integer().nullable()();
  IntColumn get precioNuevo => integer()();
  TextColumn get motivo => text().nullable()();
  IntColumn get usuarioId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Clientes extends Table with _Auditable {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 120)();
  // 'vendedor_fijo' | 'ocasional' | 'nuevo'
  TextColumn get tipo => text().withDefault(const Constant('ocasional'))();
  TextColumn get contacto => text().nullable()();
  // Días de visita por defecto Lunes–Sábado.
  TextColumn get diasVisita =>
      text().withDefault(const Constant('L,M,X,J,V,S'))();
  TextColumn get notas => text().nullable()();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
}

class Ventas extends Table with _Auditable {
  IntColumn get id => integer().autoIncrement()();
  // null = público anónimo (venta sin perfil)
  IntColumn get clienteId => integer().nullable().references(Clientes, #id)();
  // 'vendedor' | 'publico'
  TextColumn get tipoComprador => text()();
  IntColumn get subtotal => integer().withDefault(const Constant(0))();
  IntColumn get total => integer().withDefault(const Constant(0))();
  // 'pagado' | 'parcial' | 'credito'
  TextColumn get estadoPago => text().withDefault(const Constant('pagado'))();
  IntColumn get montoPagado => integer().withDefault(const Constant(0))();
  IntColumn get costoTotal => integer().nullable()();
  TextColumn get nota => text().nullable()();
  IntColumn get usuarioId => integer().nullable()();
  DateTimeColumn get fecha => dateTime().withDefault(currentDateAndTime)();
}

class DetalleVentas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ventaId =>
      integer().references(Ventas, #id, onDelete: KeyAction.cascade)();
  IntColumn get productoId => integer().references(Productos, #id)();
  TextColumn get nombreProducto => text()();
  RealColumn get cantidad => real()();
  // Precio "fotografiado": no cambia si luego se edita el precio del producto.
  IntColumn get precioUnitario => integer()();
  // 'vendedor' | 'publico' | 'manual'
  TextColumn get precioTipo => text()();
  IntColumn get costoUnitario => integer().nullable()();
  IntColumn get subtotalLinea => integer()();
}

class MovimientosInventario extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productoId => integer().references(Productos, #id)();
  // 'venta' | 'merma' | 'ajuste' | 'produccion'
  TextColumn get tipo => text()();
  RealColumn get cantidad => real()(); // positivo entra, negativo sale
  IntColumn get referenciaId => integer().nullable()();
  TextColumn get nota => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// --- Tablas definidas para Fase 2+ (incluidas en v1 para no migrar luego) ---

class Gastos extends Table with _Auditable {
  IntColumn get id => integer().autoIncrement()();
  // 'fijo' | 'variable' | 'merma'
  TextColumn get tipo => text()();
  TextColumn get categoria => text().nullable()();
  TextColumn get descripcion => text().nullable()();
  IntColumn get monto => integer().withDefault(const Constant(0))();
  DateTimeColumn get fecha => dateTime().withDefault(currentDateAndTime)();
  // 'mensual' | 'semanal' | 'quincenal' | null (para gastos fijos recurrentes)
  TextColumn get periodicidad => text().nullable()();
  IntColumn get productoId => integer().nullable().references(Productos, #id)();
  RealColumn get cantidad => real().nullable()();
  TextColumn get motivo => text().nullable()();
}

class Deudas extends Table with _Auditable {
  IntColumn get id => integer().autoIncrement()();
  // 'por_cobrar' | 'por_pagar'
  TextColumn get direccion => text()();
  IntColumn get clienteId => integer().nullable().references(Clientes, #id)();
  TextColumn get proveedor => text().nullable()();
  IntColumn get origenVentaId => integer().nullable().references(Ventas, #id)();
  IntColumn get montoOriginal => integer()();
  // 'pendiente' | 'parcial' | 'pagado'
  TextColumn get estado => text().withDefault(const Constant('pendiente'))();
  TextColumn get descripcion => text().nullable()();
  DateTimeColumn get fecha => dateTime().withDefault(currentDateAndTime)();
}

class PagosDeuda extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get deudaId =>
      integer().references(Deudas, #id, onDelete: KeyAction.cascade)();
  IntColumn get monto => integer()();
  TextColumn get nota => text().nullable()();
  IntColumn get usuarioId => integer().nullable()();
  DateTimeColumn get fecha => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Usuarios extends Table with _Auditable {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get pinHash => text().nullable()();
  // 'dueno' | 'ayudante'
  TextColumn get rol => text().withDefault(const Constant('dueno'))();
  BoolColumn get biometriaHabilitada =>
      boolean().withDefault(const Constant(false))();
}

class Auditorias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entidad => text()();
  IntColumn get entidadId => integer().nullable()();
  // 'crear' | 'actualizar' | 'borrar' | 'borrado_logico'
  TextColumn get accion => text()();
  TextColumn get campo => text().nullable()();
  TextColumn get valorAnterior => text().nullable()();
  TextColumn get valorNuevo => text().nullable()();
  IntColumn get usuarioId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class PreferenciasVisualizacion extends Table {
  TextColumn get widgetKey => text()();
  // 'tabla' | 'barras' | 'lineas' | 'circular' | 'area'
  TextColumn get tipoVista => text()();
  IntColumn get usuarioId => integer().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {widgetKey};
}

class Configuraciones extends Table {
  TextColumn get clave => text()();
  TextColumn get valor => text()();

  @override
  Set<Column> get primaryKey => {clave};
}
