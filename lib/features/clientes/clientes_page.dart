import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/design_tokens.dart';
import '../../core/widgets/glass_card.dart';
import '../../data/database/database.dart';
import '../../domain/validators.dart';
import '../../providers/providers.dart';

class ClientesPage extends ConsumerWidget {
  const ClientesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientesAsync = ref.watch(clientesProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ClienteForm.show(context),
        icon: const Icon(Icons.person_add_alt),
        label: const Text('Cliente'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(AppTokens.space4),
            sliver: SliverToBoxAdapter(
              child: Text('Clientes y vendedores',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          clientesAsync.when(
            loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator())),
            error: (e, _) => SliverFillRemaining(
                child: Center(child: Text('Error: $e'))),
            data: (clientes) {
              if (clientes.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('Sin clientes registrados.')),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(AppTokens.space4, 0,
                    AppTokens.space4, AppTokens.space7 * 2),
                sliver: SliverList.separated(
                  itemCount: clientes.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppTokens.space3),
                  itemBuilder: (_, i) => _ClienteTile(cliente: clientes[i]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

String tipoLabel(String tipo) => switch (tipo) {
      'vendedor_fijo' => 'Vendedor fijo',
      'nuevo' => 'Nuevo',
      _ => 'Ocasional',
    };

IconData _tipoIcon(String tipo) => switch (tipo) {
      'vendedor_fijo' => Icons.local_shipping_outlined,
      'nuevo' => Icons.fiber_new_outlined,
      _ => Icons.person_outline,
    };

class _ClienteTile extends StatelessWidget {
  final Cliente cliente;
  const _ClienteTile({required this.cliente});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GlassCard(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: scheme.primaryContainer,
            child: Icon(_tipoIcon(cliente.tipo),
                color: scheme.onPrimaryContainer),
          ),
          const SizedBox(width: AppTokens.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cliente.nombre,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(
                  cliente.contacto?.isNotEmpty == true
                      ? '${tipoLabel(cliente.tipo)} · ${cliente.contacto}'
                      : tipoLabel(cliente.tipo),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (cliente.tipo == 'vendedor_fijo')
            Chip(
              label: Text(cliente.diasVisita),
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }
}

/// Formulario de alta de cliente. Optimizado para alta rápida (nombre + tipo).
class ClienteForm extends ConsumerStatefulWidget {
  const ClienteForm({super.key});

  static Future<int?> show(BuildContext context) {
    return showModalBottomSheet<int?>(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: const ClienteForm(),
      ),
    );
  }

  @override
  ConsumerState<ClienteForm> createState() => _ClienteFormState();
}

class _ClienteFormState extends ConsumerState<ClienteForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _contacto = TextEditingController();
  String _tipo = 'nuevo';
  bool _guardando = false;

  @override
  void dispose() {
    _nombre.dispose();
    _contacto.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);
    try {
      final id = await ref.read(databaseProvider).crearCliente(
            ClientesCompanion.insert(
              nombre: _nombre.text.trim(),
              tipo: d.Value(_tipo),
              contacto: d.Value(
                  _contacto.text.trim().isEmpty ? null : _contacto.text.trim()),
            ),
          );
      if (mounted) Navigator.of(context).pop(id);
    } catch (e) {
      if (mounted) {
        setState(() => _guardando = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo guardar: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTokens.space5),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Nuevo cliente',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppTokens.space4),
            TextFormField(
              controller: _nombre,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: Validators.nombre,
              onFieldSubmitted: (_) => _guardar(),
            ),
            const SizedBox(height: AppTokens.space3),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'nuevo', label: Text('Nuevo')),
                ButtonSegment(value: 'ocasional', label: Text('Ocasional')),
                ButtonSegment(
                    value: 'vendedor_fijo', label: Text('Vendedor')),
              ],
              selected: {_tipo},
              onSelectionChanged: (s) => setState(() => _tipo = s.first),
            ),
            const SizedBox(height: AppTokens.space3),
            TextFormField(
              controller: _contacto,
              keyboardType: TextInputType.phone,
              decoration:
                  const InputDecoration(labelText: 'Contacto (opcional)'),
            ),
            const SizedBox(height: AppTokens.space4),
            FilledButton.icon(
              onPressed: _guardando ? null : _guardar,
              icon: const Icon(Icons.check),
              label: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
