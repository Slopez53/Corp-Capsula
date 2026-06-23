import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/design_tokens.dart';
import '../../core/widgets/glass_card.dart';
import '../../providers/providers.dart';

class CierrePage extends ConsumerWidget {
  const CierrePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cierreAsync = ref.watch(cierreHoyProvider);
    final simbolo = ref.watch(monedaSimboloProvider).valueOrNull ?? r'RD$';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(cierreHoyProvider),
        child: cierreAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (cierre) => ListView(
            padding: const EdgeInsets.all(AppTokens.space4),
            children: [
              Text('Cierre del día',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text(_hoy(),
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: AppTokens.space4),
              Row(
                children: [
                  Expanded(
                    child: _Metric(
                      label: 'Vendido',
                      valor: cierre.totalVendido.format(symbol: simbolo),
                      icon: Icons.trending_up,
                    ),
                  ),
                  const SizedBox(width: AppTokens.space3),
                  Expanded(
                    child: _Metric(
                      label: 'Cobrado',
                      valor: cierre.totalCobrado.format(symbol: simbolo),
                      icon: Icons.payments_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.space3),
              Row(
                children: [
                  Expanded(
                    child: _Metric(
                      label: 'A crédito',
                      valor: cierre.totalCredito.format(symbol: simbolo),
                      icon: Icons.schedule,
                    ),
                  ),
                  const SizedBox(width: AppTokens.space3),
                  Expanded(
                    child: _Metric(
                      label: 'Ventas',
                      valor: '${cierre.cantidadVentas}',
                      icon: Icons.receipt_long_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.space4),
              if (cierre.porComprador.isNotEmpty) ...[
                Text('Por tipo de comprador',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppTokens.space2),
                GlassCard(
                  child: Column(
                    children: [
                      for (final e in cierre.porComprador.entries)
                        _Fila(e.key, e.value.format(symbol: simbolo)),
                    ],
                  ),
                ),
                const SizedBox(height: AppTokens.space4),
              ],
              if (cierre.porProducto.isNotEmpty) ...[
                Text('Por producto',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppTokens.space2),
                GlassCard(
                  child: Column(
                    children: [
                      for (final e in cierre.porProducto.entries)
                        _Fila(
                          '${e.key}  ×${_fmtQty(e.value.cantidad)}',
                          e.value.total.format(symbol: simbolo),
                        ),
                    ],
                  ),
                ),
              ],
              if (cierre.cantidadVentas == 0)
                const Padding(
                  padding: EdgeInsets.only(top: AppTokens.space7),
                  child: Center(
                      child: Text('Aún no hay ventas registradas hoy.')),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _hoy() {
    final d = DateTime.now();
    return '${d.day}/${d.month}/${d.year}';
  }

  String _fmtQty(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();
}

class _Metric extends StatelessWidget {
  final String label;
  final String valor;
  final IconData icon;
  const _Metric(
      {required this.label, required this.valor, required this.icon});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: scheme.primary),
          const SizedBox(height: AppTokens.space2),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppTokens.space1),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(valor,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _Fila extends StatelessWidget {
  final String label;
  final String valor;
  const _Fila(this.label, this.valor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTokens.space2),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(valor, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
