import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/money.dart';
import '../data/database/database.dart';
import '../domain/pricing.dart';

/// Instancia única de la base de datos para toda la app.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// ------------------------------------------------------------------ Streams BD
final productosProvider = StreamProvider<List<Producto>>(
    (ref) => ref.watch(databaseProvider).watchProductos());

final productosBajoStockProvider = StreamProvider<List<Producto>>(
    (ref) => ref.watch(databaseProvider).watchProductosBajoStock());

final categoriasProvider = StreamProvider<List<Categoria>>(
    (ref) => ref.watch(databaseProvider).watchCategorias());

final clientesProvider = StreamProvider<List<Cliente>>(
    (ref) => ref.watch(databaseProvider).watchClientes());

final cierreHoyProvider = FutureProvider<CierreDia>(
    (ref) => ref.watch(databaseProvider).cierreDelDia(DateTime.now()));

// ----------------------------------------------------------------- Moneda/tema
final monedaSimboloProvider = FutureProvider<String>((ref) async {
  final value = await ref.watch(databaseProvider).getConfig('moneda_simbolo');
  return value ?? r'RD$';
});

/// Modo de tema (claro/oscuro/sistema) controlable desde la UI.
final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;
  void toggle() => state =
      state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  void set(ThemeMode mode) => state = mode;
}

// ----------------------------------------------------- Carrito de venta (POS)
/// Estado de la venta en curso.
class CarritoState {
  final List<LineaVenta> lineas;
  final TipoComprador tipoComprador;
  final int? clienteId;
  final String? clienteNombre;

  const CarritoState({
    this.lineas = const [],
    this.tipoComprador = TipoComprador.vendedor,
    this.clienteId,
    this.clienteNombre,
  });

  Money get total => calcularTotales(lineas).total;
  bool get isEmpty => lineas.isEmpty;

  CarritoState copyWith({
    List<LineaVenta>? lineas,
    TipoComprador? tipoComprador,
    int? clienteId,
    String? clienteNombre,
    bool limpiarCliente = false,
  }) =>
      CarritoState(
        lineas: lineas ?? this.lineas,
        tipoComprador: tipoComprador ?? this.tipoComprador,
        clienteId: limpiarCliente ? null : (clienteId ?? this.clienteId),
        clienteNombre:
            limpiarCliente ? null : (clienteNombre ?? this.clienteNombre),
      );
}

final carritoProvider =
    NotifierProvider<CarritoNotifier, CarritoState>(CarritoNotifier.new);

class CarritoNotifier extends Notifier<CarritoState> {
  @override
  CarritoState build() => const CarritoState();

  void setTipoComprador(TipoComprador tipo) {
    // Reprecia las líneas existentes al precio del nuevo tipo (salvo manuales).
    final nuevas = state.lineas.map((l) {
      if (l.precioTipo == PrecioTipo.manual) return l;
      return l; // el reprecio fino se hace al añadir; aquí solo cambia el tipo
    }).toList();
    state = state.copyWith(tipoComprador: tipo, lineas: nuevas);
  }

  void setCliente(int? id, String? nombre) =>
      state = state.copyWith(clienteId: id, clienteNombre: nombre);

  void limpiarCliente() => state = state.copyWith(limpiarCliente: true);

  /// Añade un producto o incrementa la cantidad si ya está en el carrito.
  void agregar(Producto producto) {
    final precio = state.tipoComprador == TipoComprador.vendedor
        ? Money(producto.precioVendedor)
        : Money(producto.precioPublico);
    final tipo = state.tipoComprador == TipoComprador.vendedor
        ? PrecioTipo.vendedor
        : PrecioTipo.publico;

    final idx = state.lineas.indexWhere((l) => l.productoId == producto.id);
    final lineas = [...state.lineas];
    if (idx >= 0) {
      lineas[idx] =
          lineas[idx].copyWith(cantidad: lineas[idx].cantidad + 1);
    } else {
      lineas.add(LineaVenta(
        productoId: producto.id,
        nombreProducto: producto.nombre,
        cantidad: 1,
        precioUnitario: precio,
        precioTipo: tipo,
        costoUnitario: producto.costoProduccion == null
            ? null
            : Money(producto.costoProduccion!),
      ));
    }
    state = state.copyWith(lineas: lineas);
  }

  void setCantidad(int productoId, double cantidad) {
    final lineas = state.lineas
        .map((l) => l.productoId == productoId
            ? l.copyWith(cantidad: cantidad)
            : l)
        .where((l) => l.cantidad > 0)
        .toList();
    state = state.copyWith(lineas: lineas);
  }

  /// Edición manual del precio de una línea (caso por caso, sección 2.3).
  void setPrecioManual(int productoId, Money precio) {
    final lineas = state.lineas
        .map((l) => l.productoId == productoId
            ? l.copyWith(precioUnitario: precio, precioTipo: PrecioTipo.manual)
            : l)
        .toList();
    state = state.copyWith(lineas: lineas);
  }

  void quitar(int productoId) => state = state.copyWith(
      lineas:
          state.lineas.where((l) => l.productoId != productoId).toList());

  void limpiar() => state = const CarritoState();
}
