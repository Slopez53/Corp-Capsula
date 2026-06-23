import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../core/theme/design_tokens.dart';
import '../../core/widgets/glass_card.dart';
import '../../data/database/database.dart';
import '../../domain/pricing.dart';
import '../../providers/providers.dart';
import '../clientes/clientes_page.dart';
import 'cobrar_sheet.dart';

class VentasPage extends ConsumerWidget {
  const VentasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productosAsync = ref.watch(productosProvider);
    final simbolo = ref.watch(monedaSimboloProvider).valueOrNull ?? r'RD$';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(AppTokens.space4, AppTokens.space4,
                AppTokens.space4, AppTokens.space2),
            child: _VentaHeader(),
          ),
          Expanded(
            child: productosAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (productos) {
                final activos = productos
                    .where((p) => p.estado == 'activo')
                    .toList();
                if (activos.isEmpty) {
                  return const Center(
                      child: Text('Agrega productos en Inventario primero.'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(AppTokens.space4, 0,
                      AppTokens.space4, AppTokens.space4),
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    mainAxisExtent: 110,
                    crossAxisSpacing: AppTokens.space3,
                    mainAxisSpacing: AppTokens.space3,
                  ),
                  itemCount: activos.length,
                  itemBuilder: (_, i) =>
                      _ProductoChip(producto: activos[i], simbolo: simbolo),
                );
              },
            ),
          ),
          const _CarritoBar(),
        ],
      ),
    );
  }
}

class _VentaHeader extends ConsumerWidget {
  const _VentaHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carrito = ref.watch(carritoProvider);
    final notifier = ref.read(carritoProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Registrar venta',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: AppTokens.space3),
        Row(
          children: [
            SegmentedButton<TipoComprador>(
              segments: const [
                ButtonSegment(
                    value: TipoComprador.vendedor, label: Text('Vendedor')),
                ButtonSegment(
                    value: TipoComprador.publico, label: Text('Público')),
              ],
              selected: {carrito.tipoComprador},
              onSelectionChanged: (s) =>
                  notifier.setTipoComprador(s.first),
            ),
            const SizedBox(width: AppTokens.space3),
            Expanded(child: _ClienteSelector()),
          ],
        ),
      ],
    );
  }
}

class _ClienteSelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carrito = ref.watch(carritoProvider);
    final notifier = ref.read(carritoProvider.notifier);
    final clientes = ref.watch(clientesProvider).valueOrNull ?? [];

    return ActionChip(
      avatar: const Icon(Icons.person_outline, size: 18),
      label: Text(carrito.clienteNombre ?? 'Público general'),
      onPressed: () async {
        final seleccion = await showModalBottomSheet<Cliente?>(
          context: context,
          isScrollControlled: true,
          builder: (_) => _ClientePicker(clientes: clientes),
        );
        if (seleccion == null) return;
        if (seleccion.id == -1) {
          notifier.limpiarCliente();
        } else {
          notifier.setCliente(seleccion.id, seleccion.nombre);
        }
      },
    );
  }
}

class _ClientePicker extends ConsumerWidget {
  final List<Cliente> clientes;
  const _ClientePicker({required this.clientes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('Público general (anónimo)'),
              onTap: () => Navigator.pop(
                  context,
                  Cliente(
                      id: -1,
                      nombre: 'Público general',
                      tipo: 'ocasional',
                      diasVisita: '',
                      activo: true,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now())),
            ),
            ListTile(
              leading: const Icon(Icons.person_add_alt),
              title: const Text('Registrar cliente nuevo'),
              onTap: () async {
                final id = await ClienteForm.show(context);
                if (id != null && context.mounted) {
                  final nuevo = (ref.read(clientesProvider).valueOrNull ?? [])
                      .where((c) => c.id == id)
                      .firstOrNull;
                  Navigator.pop(context, nuevo);
                }
              },
            ),
            const Divider(),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final c in clientes)
                    ListTile(
                      title: Text(c.nombre),
                      subtitle: Text(tipoLabel(c.tipo)),
                      onTap: () => Navigator.pop(context, c),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductoChip extends ConsumerWidget {
  final Producto producto;
  final String simbolo;
  const _ProductoChip({required this.producto, required this.simbolo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carrito = ref.watch(carritoProvider);
    final precio = carrito.tipoComprador == TipoComprador.vendedor
        ? Money(producto.precioVendedor)
        : Money(producto.precioPublico);
    final enCarrito = carrito.lineas
        .where((l) => l.productoId == producto.id)
        .firstOrNull;

    return GlassCard(
      onTap: () => ref.read(carritoProvider.notifier).agregar(producto),
      padding: const EdgeInsets.all(AppTokens.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(producto.nombre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              if (enCarrito != null)
                CircleAvatar(
                  radius: 12,
                  child: Text(_fmtQty(enCarrito.cantidad),
                      style: const TextStyle(fontSize: 11)),
                ),
            ],
          ),
          Text(precio.format(symbol: simbolo),
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  String _fmtQty(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();
}

class _CarritoBar extends ConsumerWidget {
  const _CarritoBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carrito = ref.watch(carritoProvider);
    final simbolo = ref.watch(monedaSimboloProvider).valueOrNull ?? r'RD$';

    return AnimatedSlide(
      duration: AppTokens.durMed,
      offset: carrito.isEmpty ? const Offset(0, 1.5) : Offset.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space3),
        child: GlassCard(
          onTap: carrito.isEmpty ? null : () => CobrarSheet.show(context),
          child: Row(
            children: [
              Badge(
                label: Text('${carrito.lineas.length}'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              const SizedBox(width: AppTokens.space4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total',
                        style: Theme.of(context).textTheme.bodySmall),
                    Text(carrito.total.format(symbol: simbolo),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              FilledButton.icon(
                onPressed:
                    carrito.isEmpty ? null : () => CobrarSheet.show(context),
                icon: const Icon(Icons.payments_outlined),
                label: const Text('Cobrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
