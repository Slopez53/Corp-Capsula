import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../core/theme/design_tokens.dart';
import '../../core/widgets/glass_card.dart';
import '../../data/database/database.dart';
import '../../providers/providers.dart';
import 'producto_form.dart';

class InventarioPage extends ConsumerWidget {
  const InventarioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productosAsync = ref.watch(productosProvider);
    final simbolo = ref.watch(monedaSimboloProvider).valueOrNull ?? r'RD$';

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ProductoForm.show(context),
        icon: const Icon(Icons.add),
        label: const Text('Producto'),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(AppTokens.space4, AppTokens.space4,
                AppTokens.space4, AppTokens.space2),
            sliver: SliverToBoxAdapter(child: _Header()),
          ),
          productosAsync.when(
            loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator())),
            error: (e, _) => SliverFillRemaining(
              child: Center(child: Text('Error al cargar: $e')),
            ),
            data: (productos) {
              if (productos.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text('Aún no hay productos.\nToca "Producto".',
                        textAlign: TextAlign.center),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(AppTokens.space4, 0,
                    AppTokens.space4, AppTokens.space7 * 2),
                sliver: SliverList.separated(
                  itemCount: productos.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppTokens.space3),
                  itemBuilder: (_, i) =>
                      _ProductoTile(producto: productos[i], simbolo: simbolo),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Text('Inventario',
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontWeight: FontWeight.bold));
  }
}

class _ProductoTile extends ConsumerWidget {
  final Producto producto;
  final String simbolo;
  const _ProductoTile({required this.producto, required this.simbolo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final bajoStock = producto.stockActual <= producto.stockMinimo;
    final descontinuado = producto.estado == 'descontinuado';

    return GlassCard(
      onTap: () => ProductoForm.show(context, producto: producto),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(producto.nombre,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    if (descontinuado) ...[
                      const SizedBox(width: AppTokens.space2),
                      const Chip(
                        label: Text('Descontinuado'),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppTokens.space1),
                Text(
                  'Vend: ${Money(producto.precioVendedor).format(symbol: simbolo)}'
                  '   ·   Púb: ${Money(producto.precioPublico).format(symbol: simbolo)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppTokens.space3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (bajoStock)
                    Icon(Icons.warning_amber_rounded,
                        size: 18, color: scheme.error),
                  const SizedBox(width: 4),
                  Text(
                    '${_fmt(producto.stockActual)} ${producto.unidadVenta}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: bajoStock ? scheme.error : null,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Text('mín. ${_fmt(producto.stockMinimo)}',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  String _fmt(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();
}
