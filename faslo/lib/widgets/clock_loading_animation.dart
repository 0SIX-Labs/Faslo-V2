import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/theme_provider.dart';
import '../core/theme/app_theme.dart';

class ClockLoadingAnimation extends StatefulWidget {
  const ClockLoadingAnimation({super.key});

  @override
  State<ClockLoadingAnimation> createState() => _ClockLoadingAnimationState();
}

class _ClockLoadingAnimationState extends State<ClockLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _hourRotation;
  late Animation<double> _minuteRotation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _hourRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );

    _minuteRotation = Tween<double>(begin: 0.0, end: 12.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = context.watch<ThemeProvider>();
    final showGlow = themeProvider.mode == AppThemeMode.kineticObsidian;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: showGlow
                ? [
                    BoxShadow(
                      color: colorScheme.primary.withValues(
                          alpha: 0.08 + (0.06 * _glowAnimation.value)),
                      blurRadius: 25 + (15 * _glowAnimation.value),
                      spreadRadius: 4 + (4 * _glowAnimation.value),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Clock background circle
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.surfaceContainerHigh,
                ),
              ),

              // Clock border
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
              ),

              // Hour markers
              ..._buildHourMarkers(colorScheme),

              // Hour hand
              Transform.rotate(
                angle: _hourRotation.value * 2 * 3.14159,
                child: Center(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 24),
                      width: 5,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),

              // Minute hand
              Transform.rotate(
                angle: _minuteRotation.value * 2 * 3.14159,
                child: Center(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      width: 3.5,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),

              // Center dot
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildHourMarkers(ColorScheme colorScheme) {
    final markers = <Widget>[];

    for (int i = 0; i < 12; i++) {
      final isMainHour = i % 3 == 0;
      markers.add(
        Transform.rotate(
          angle: i * 30 * 3.14159 / 180,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: isMainHour ? 8 : 10),
              width: isMainHour ? 2.5 : 1.5,
              height: isMainHour ? 8 : 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      );
    }

    return markers;
  }
}
