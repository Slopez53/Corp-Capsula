import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/design_tokens.dart';
import '../../core/widgets/glass_card.dart';
import '../../providers/providers.dart';
import '../cierre/cierre_page.dart';
import '../clientes/clientes_page.dart';
import '../inventario/inventario_page.dart';
import '../ventas/ventas_page.dart';

class _Destino {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;
  const _Destino(this.label, this.icon, this.selectedIcon, this.page);
}

const _destinos = <_Destino>[
  _Destino('Ventas', Icons.point_of_sale_outlined, Icons.point_of_sale,
      VentasPage()),
  _Destino('Inventario', Icons.inventory_2_outlined, Icons.inventory_2,
      InventarioPage()),
  _Destino('Clientes', Icons.people_outline, Icons.people, ClientesPage()),
  _Destino('Cierre', Icons.assessment_outlined, Icons.assessment, CierrePage()),
];

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _index = 0;

  void _toggleTheme() => ref.read(themeModeProvider.notifier).toggle();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= AppTokens.breakpointTablet;
    final isDesktop = width >= AppTokens.breakpointDesktop;

    final body = AnimatedSwitcher(
      duration: AppTokens.durMed,
      child: KeyedSubtree(
        key: ValueKey(_index),
        child: _destinos[_index].page,
      ),
    );

    return GlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: isWide
              ? Row(
                  children: [
                    _SideRail(
                      index: _index,
                      extended: isDesktop,
                      onSelect: (i) => setState(() => _index = i),
                      onToggleTheme: _toggleTheme,
                    ),
                    Expanded(child: body),
                  ],
                )
              : body,
        ),
        bottomNavigationBar: isWide
            ? null
            : NavigationBar(
                selectedIndex: _index,
                onDestinationSelected: (i) => setState(() => _index = i),
                destinations: [
                  for (final d in _destinos)
                    NavigationDestination(
                      icon: Icon(d.icon),
                      selectedIcon: Icon(d.selectedIcon),
                      label: d.label,
                    ),
                ],
              ),
      ),
    );
  }
}

class _SideRail extends ConsumerWidget {
  final int index;
  final bool extended;
  final ValueChanged<int> onSelect;
  final VoidCallback onToggleTheme;

  const _SideRail({
    required this.index,
    required this.extended,
    required this.onSelect,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bajoStock = ref.watch(productosBajoStockProvider).valueOrNull ?? [];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(AppTokens.space3),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: AppTokens.space4),
        child: SizedBox(
          width: extended ? 200 : 76,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTokens.space3, vertical: AppTokens.space2),
                child: Row(
                  mainAxisAlignment: extended
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    const Text('🥐', style: TextStyle(fontSize: 24)),
                    if (extended) ...[
                      const SizedBox(width: AppTokens.space2),
                      const Flexible(
                        child: Text('Corp Capsula',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppTokens.space4),
              for (var i = 0; i < _destinos.length; i++)
                _RailItem(
                  destino: _destinos[i],
                  selected: i == index,
                  extended: extended,
                  badge: _destinos[i].label == 'Inventario' &&
                          bajoStock.isNotEmpty
                      ? bajoStock.length
                      : null,
                  onTap: () => onSelect(i),
                ),
              const Spacer(),
              IconButton(
                tooltip: 'Cambiar tema',
                onPressed: onToggleTheme,
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RailItem extends StatelessWidget {
  final _Destino destino;
  final bool selected;
  final bool extended;
  final int? badge;
  final VoidCallback onTap;

  const _RailItem({
    required this.destino,
    required this.selected,
    required this.extended,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final icon = Icon(
      selected ? destino.selectedIcon : destino.icon,
      color: selected ? scheme.primary : scheme.onSurfaceVariant,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space2, vertical: AppTokens.space1),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: AppTokens.brMd,
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppTokens.durFast,
            padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.space3, vertical: AppTokens.space3),
            decoration: BoxDecoration(
              borderRadius: AppTokens.brMd,
              color: selected
                  ? scheme.primaryContainer.withValues(alpha: 0.6)
                  : Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: extended
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Badge(
                  isLabelVisible: badge != null,
                  label: Text('${badge ?? ''}'),
                  child: icon,
                ),
                if (extended) ...[
                  const SizedBox(width: AppTokens.space3),
                  Flexible(
                    child: Text(
                      destino.label,
                      style: TextStyle(
                        fontWeight:
                            selected ? FontWeight.bold : FontWeight.normal,
                        color:
                            selected ? scheme.primary : scheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
