import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../core/theme/design_tokens.dart';
import '../../data/database/database.dart';
import '../../domain/pricing.dart';
import '../../providers/providers.dart';

/// Hoja de finalización de la venta: ajustar cantidades/precios, registrar el
/// monto pagado (soporta pago completo, parcial o crédito) y confirmar.
class CobrarSheet extends ConsumerStatefulWidget {
  const CobrarSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
          child: const CobrarSheet(),
        ),
      );

  @override
  ConsumerState<CobrarSheet> createState() => _CobrarSheetState();
}

class _CobrarSheetState extends ConsumerState<CobrarSheet> {
  final _pagado = TextEditingController();
  bool _pagaTodo = true;
  bool _guardando = false;

  @override
  void dispose() {
    _pagado.dispose();
    super.dispose();
  }

  Future<void> _confirmar(Money total) async {
    final montoPagado = _pagaTodo
        ? total
        : (Money.tryParse(_pagado.text) ?? Money.zero);
    if (!_pagaTodo && montoPagado > total) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('El monto pagado no puede superar el total')));
      return;
    }

    setState(() => _guardando = true);
    final carrito = ref.read(carritoProvider);
    final db = ref.read(databaseProvider);
    try {
      await db.registrarVenta(
        clienteId: carrito.clienteId,
        tipoComprador: carrito.tipoComprador,
        montoPagado: montoPagado,
        lineas: carrito.lineas
            .map((l) => LineaVentaInput(
                  productoId: l.productoId,
                  nombreProducto: l.nombreProducto,
                  cantidad: l.cantidad,
                  precioUnitario: l.precioUnitario,
                  precioTipo: l.precioTipo,
                  costoUnitario: l.costoUnitario,
                ))
            .toList(),
      );
      ref.read(carritoProvider.notifier).limpiar();
      ref.invalidate(cierreHoyProvider);
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Venta registrada ✓')));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _guardando = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No se pudo registrar: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final carrito = ref.watch(carritoProvider);
    final notifier = ref.read(carritoProvider.notifier);
    final simbolo = ref.watch(monedaSimboloProvider).valueOrNull ?? r'RD$';
    final total = carrito.total;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Cobrar',
                    style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                Text(carrito.clienteNombre ?? 'Público general',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: AppTokens.space3),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: carrito.lineas.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final l = carrito.lineas[i];
                  return _LineaTile(
                    linea: l,
                    simbolo: simbolo,
                    onCantidad: (q) => notifier.setCantidad(l.productoId, q),
                    onPrecio: (p) =>
                        notifier.setPrecioManual(l.productoId, p),
                    onQuitar: () => notifier.quitar(l.productoId),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              children: [
                Text('Total',
                    style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                Text(total.format(symbol: simbolo),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: AppTokens.space3),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _pagaTodo,
              onChanged: (v) => setState(() => _pagaTodo = v),
              title: const Text('Paga el total ahora'),
              subtitle: Text(_pagaTodo
                  ? 'Venta pagada'
                  : 'Pago parcial o a crédito (genera deuda)'),
            ),
            if (!_pagaTodo)
              TextField(
                controller: _pagado,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Monto pagado',
                  prefixText: '$simbolo ',
                  helperText: 'Deja 0 para venta totalmente a crédito',
                ),
              ),
            const SizedBox(height: AppTokens.space4),
            FilledButton.icon(
              onPressed:
                  carrito.isEmpty || _guardando ? null : () => _confirmar(total),
              icon: _guardando
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.check_circle_outline),
              label: const Text('Confirmar venta'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LineaTile extends StatelessWidget {
  final LineaVenta linea;
  final String simbolo;
  final ValueChanged<double> onCantidad;
  final ValueChanged<Money> onPrecio;
  final VoidCallback onQuitar;

  const _LineaTile({
    required this.linea,
    required this.simbolo,
    required this.onCantidad,
    required this.onPrecio,
    required this.onQuitar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTokens.space2),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(linea.nombreProducto,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: () async {
                    final nuevo = await _editarPrecio(context);
                    if (nuevo != null) onPrecio(nuevo);
                  },
                  child: Row(
                    children: [
                      Text(linea.precioUnitario.format(symbol: simbolo),
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(width: 4),
                      if (linea.precioTipo == PrecioTipo.manual)
                        const Icon(Icons.edit, size: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () => onCantidad(linea.cantidad - 1),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text(_fmtQty(linea.cantidad),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () => onCantidad(linea.cantidad + 1),
            icon: const Icon(Icons.add_circle_outline),
          ),
          SizedBox(
            width: 84,
            child: Text(linea.subtotal.format(symbol: simbolo),
                textAlign: TextAlign.right,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<Money?> _editarPrecio(BuildContext context) {
    final ctrl =
        TextEditingController(text: linea.precioUnitario.major.toString());
    return showDialog<Money>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Precio manual'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(prefixText: '$simbolo '),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')),
          FilledButton(
            onPressed: () {
              final m = Money.tryParse(ctrl.text);
              if (m != null && m.isPositive) Navigator.pop(context, m);
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }

  String _fmtQty(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();
}
