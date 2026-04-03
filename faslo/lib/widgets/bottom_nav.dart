import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../core/theme/theme_provider.dart';
import '../core/theme/app_theme.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    final items = [
      _NavItem(icon: Icons.home_rounded, label: 'Home'),
      _NavItem(icon: Icons.calendar_today_rounded, label: 'Plans'),
      _NavItem(icon: Icons.history_rounded, label: 'History'),
      _NavItem(icon: Icons.favorite_border_rounded, label: 'Wellness'),
    ];

    return Container(
      decoration: _getDecoration(themeProvider.mode, colorScheme),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isActive = index == widget.currentIndex;
              return _buildNavItem(
                item,
                isActive,
                index,
                themeProvider.mode,
                colorScheme,
              );
            }),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration(AppThemeMode mode, ColorScheme colorScheme) {
    switch (mode) {
      case AppThemeMode.sageMint:
        return BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -4),
            ),
          ],
        );
      case AppThemeMode.kineticObsidian:
        return BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.9),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -4),
            ),
          ],
        );
      case AppThemeMode.minimalMono:
        return BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(
            top: BorderSide(
              color: colorScheme.outlineVariant,
              width: 1,
            ),
          ),
        );
      case AppThemeMode.minimalOled:
        return BoxDecoration(
          color: Colors.black.withValues(alpha: 0.95),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.05),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -4),
            ),
          ],
        );
    }
  }

  Widget _buildNavItem(
    _NavItem item,
    bool isActive,
    int index,
    AppThemeMode mode,
    ColorScheme colorScheme,
  ) {
    Color activeColor;
    Color inactiveColor;

    switch (mode) {
      case AppThemeMode.sageMint:
        activeColor = colorScheme.primary;
        inactiveColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.6);
        break;
      case AppThemeMode.kineticObsidian:
        activeColor = colorScheme.primary;
        inactiveColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.6);
        break;
      case AppThemeMode.minimalMono:
        activeColor = colorScheme.primary;
        inactiveColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.6);
        break;
      case AppThemeMode.minimalOled:
        activeColor = Colors.white;
        inactiveColor = Colors.white38;
        break;
    }

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        widget.onTap(index);
      },
      behavior: HitTestBehavior.opaque,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: isActive ? 1.0 : 0.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return SizedBox(
            width: 64,
            height: 52,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with animated container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.all(isActive ? 8 : 6),
                  decoration: BoxDecoration(
                    color: isActive
                        ? activeColor.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    item.icon,
                    color: Color.lerp(inactiveColor, activeColor, value),
                    size: isActive ? 22 : 20,
                  ),
                ),
                const SizedBox(height: 4),
                // Label with animated opacity
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  style: TextStyle(
                    color: Color.lerp(inactiveColor, activeColor, value),
                    fontSize: 10,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    letterSpacing: isActive ? 0.5 : 0,
                  ),
                  child: Text(item.label),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  _NavItem({required this.icon, required this.label});
}
