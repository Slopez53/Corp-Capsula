import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../core/theme/design_tokens.dart';
import '../../data/database/database.dart';
import '../../domain/validators.dart';
import '../../providers/providers.dart';

/// Hoja de formulario para crear o editar un producto.
class ProductoForm extends ConsumerStatefulWidget {
  final Producto? producto;
  const ProductoForm({super.key, this.producto});

  static Future<void> show(BuildContext context, {Producto? producto}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: ProductoForm(producto: producto),
      ),
    );
  }

  @override
  ConsumerState<ProductoForm> createState() => _ProductoFormState();
}

class _ProductoFormState extends ConsumerState<ProductoForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombre;
  late final TextEditingController _precioVendedor;
  late final TextEditingController _precioPublico;
  late final TextEditingController _costo;
  late final TextEditingController _stock;
  late final TextEditingController _stockMin;
  String _unidad = 'pieza';
  int? _categoriaId;
  bool _activo = true;
  bool _guardando = false;

  static const _unidades = ['pieza', 'libra', 'docena', 'bolsa', 'unidad'];

  Producto? get _editando => widget.producto;

  @override
  void initState() {
    super.initState();
    final p = _editando;
    _nombre = TextEditingController(text: p?.nombre ?? '');
    _precioVendedor = TextEditingController(
        text: p == null ? '' : Money(p.precioVendedor).major.toString());
    _precioPublico = TextEditingController(
        text: p == null ? '' : Money(p.precioPublico).major.toString());
    _costo = TextEditingController(
        text: p?.costoProduccion == null
            ? ''
            : Money(p!.costoProduccion!).major.toString());
    _stock = TextEditingController(text: (p?.stockActual ?? 0).toString());
    _stockMin = TextEditingController(text: (p?.stockMinimo ?? 0).toString());
    _unidad = p?.unidadVenta ?? 'pieza';
    _categoriaId = p?.categoriaId;
    _activo = p?.estado != 'descontinuado';
  }

  @override
  void dispose() {
    for (final c in [
      _nombre,
      _precioVendedor,
      _precioPublico,
      _costo,
      _stock,
      _stockMin
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);
    final db = ref.read(databaseProvider);
    try {
      final companion = ProductosCompanion(
        nombre: d.Value(_nombre.text.trim()),
        categoriaId: d.Value(_categoriaId),
        unidadVenta: d.Value(_unidad),
        precioVendedor: d.Value(Money.tryParse(_precioVendedor.text)!.cents),
        precioPublico: d.Value(Money.tryParse(_precioPublico.text)!.cents),
        costoProduccion:
            d.Value(Money.tryParse(_costo.text)?.cents),
        stockActual: d.Value(double.tryParse(_stock.text) ?? 0),
        stockMinimo: d.Value(double.tryParse(_stockMin.text) ?? 0),
        estado: d.Value(_activo ? 'activo' : 'descontinuado'),
      );
      if (_editando == null) {
        await db.crearProducto(companion);
      } else {
        await db.actualizarProducto(_editando!, companion);
      }
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() => _guardando = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo guardar: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categorias = ref.watch(categoriasProvider).valueOrNull ?? [];
    return Padding(
      padding: const EdgeInsets.all(AppTokens.space5),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(_editando == null ? 'Nuevo producto' : 'Editar producto',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppTokens.space4),
              TextFormField(
                controller: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
                textCapitalization: TextCapitalization.sentences,
                validator: Validators.nombre,
              ),
              const SizedBox(height: AppTokens.space3),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int?>(
                      initialValue: _categoriaId,
                      decoration:
                          const InputDecoration(labelText: 'Categoría'),
                      items: [
                        const DropdownMenuItem(
                            value: null, child: Text('Sin categoría')),
                        for (final c in categorias)
                          DropdownMenuItem(value: c.id, child: Text(c.nombre)),
                      ],
                      onChanged: (v) => setState(() => _categoriaId = v),
                    ),
                  ),
                  const SizedBox(width: AppTokens.space3),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _unidad,
                      decoration: const InputDecoration(labelText: 'Unidad'),
                      items: [
                        for (final u in _unidades)
                          DropdownMenuItem(value: u, child: Text(u)),
                      ],
                      onChanged: (v) => setState(() => _unidad = v ?? 'pieza'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.space3),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _precioVendedor,
                      decoration: const InputDecoration(
                          labelText: 'Precio vendedor', prefixText: r'RD$ '),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      validator: Validators.precio,
                    ),
                  ),
                  const SizedBox(width: AppTokens.space3),
                  Expanded(
                    child: TextFormField(
                      controller: _precioPublico,
                      decoration: const InputDecoration(
                          labelText: 'Precio público', prefixText: r'RD$ '),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      validator: Validators.precio,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.space3),
              TextFormField(
                controller: _costo,
                decoration: const InputDecoration(
                    labelText: 'Costo de producción (opcional)',
                    prefixText: r'RD$ '),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: Validators.costoOpcional,
              ),
              const SizedBox(height: AppTokens.space3),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stock,
                      decoration:
                          const InputDecoration(labelText: 'Stock actual'),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      validator: Validators.cantidadNoNegativa,
                    ),
                  ),
                  const SizedBox(width: AppTokens.space3),
                  Expanded(
                    child: TextFormField(
                      controller: _stockMin,
                      decoration:
                          const InputDecoration(labelText: 'Stock mínimo'),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      validator: Validators.cantidadNoNegativa,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.space3),
              SwitchListTile(
                value: _activo,
                onChanged: (v) => setState(() => _activo = v),
                title: const Text('Activo'),
                subtitle: Text(_activo ? 'En venta' : 'Descontinuado'),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: AppTokens.space4),
              FilledButton.icon(
                onPressed: _guardando ? null : _guardar,
                icon: _guardando
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.check),
                label: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
