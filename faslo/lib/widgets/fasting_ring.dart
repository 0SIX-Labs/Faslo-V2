import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/constants/fasting_phases.dart';
import '../core/theme/theme_provider.dart';
import '../core/theme/app_theme.dart';

String formatElapsed(Duration d) {
  final h = d.inHours.toString().padLeft(2, '0');
  final m = (d.inMinutes % 60).toString().padLeft(2, '0');
  return '$h:$m';
}

class FastingRing extends StatefulWidget {
  final Duration elapsed;
  final int targetHours;
  final bool isFasting;

  const FastingRing({
    super.key,
    required this.elapsed,
    required this.targetHours,
    required this.isFasting,
  });

  @override
  State<FastingRing> createState() => _FastingRingState();
}

class _FastingRingState extends State<FastingRing>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _pulseController;
  late AnimationController _glowController;
  late AnimationController _colorController;
  late AnimationController _rippleController;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _rippleAnimation;
  Color? _previousPhaseColor;

  @override
  void initState() {
    super.initState();

    // Progress animation
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOutCubic,
    );

    // Subtle pulse animation for active fasting
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.015).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Glow animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _glowAnimation = CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    );

    // Color transition animation
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Ripple animation for tap feedback
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _progressController.forward();
    _glowController.repeat(reverse: true);

    if (widget.isFasting) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(FastingRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFasting != oldWidget.isFasting) {
      if (widget.isFasting) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    }

    // Handle phase color changes
    final oldPhase = currentPhase(oldWidget.elapsed);
    final newPhase = currentPhase(widget.elapsed);
    if (oldPhase.color != newPhase.color) {
      _previousPhaseColor = oldPhase.color;
      _colorController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    _glowController.dispose();
    _colorController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _rippleController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = context.watch<ThemeProvider>();
    final phase = currentPhase(widget.elapsed);
    final progress = widget.targetHours > 0
        ? (widget.elapsed.inSeconds / (widget.targetHours * 3600))
            .clamp(0.0, 1.0)
        : 0.0;

    final showGlow = themeProvider.mode == AppThemeMode.kineticObsidian;

    return AnimatedBuilder(
      animation: Listenable.merge([
        _progressAnimation,
        _pulseAnimation,
        _glowAnimation,
        _colorController,
        _rippleAnimation,
      ]),
      builder: (context, child) {
        return GestureDetector(
          onTap: _handleTap,
          child: Transform.scale(
            scale: widget.isFasting ? _pulseAnimation.value : 1.0,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: showGlow
                    ? [
                        // Primary glow (Obsidian theme only)
                        BoxShadow(
                          color: colorScheme.primary.withValues(
                              alpha: 0.12 + (0.08 * _glowAnimation.value)),
                          blurRadius: 40 + (20 * _glowAnimation.value),
                          spreadRadius: 8 + (8 * _glowAnimation.value),
                        ),
                        // Phase color glow
                        if (widget.isFasting)
                          BoxShadow(
                            color: phase.color.withValues(
                                alpha: 0.08 + (0.06 * _glowAnimation.value)),
                            blurRadius: 60 + (30 * _glowAnimation.value),
                            spreadRadius: 12 + (12 * _glowAnimation.value),
                          ),
                      ]
                    : [
                        // Subtle shadow for non-Obsidian themes
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Stack(
                children: [
                  CustomPaint(
                    painter: _RingPainter(
                      progress: progress * _progressAnimation.value,
                      primaryColor: colorScheme.primary,
                      backgroundColor: colorScheme.surfaceContainerHigh,
                      phaseColor: phase.color,
                      previousPhaseColor: _previousPhaseColor,
                      colorAnimationValue: _colorController.value,
                      isFasting: widget.isFasting,
                      glowIntensity: _glowAnimation.value,
                      showGlow: showGlow,
                    ),
                    child: Center(
                      child: _buildCenterContent(colorScheme, phase),
                    ),
                  ),
                  // Ripple effect on tap
                  if (_rippleAnimation.value > 0)
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _RipplePainter(
                          rippleValue: _rippleAnimation.value,
                          color: phase.color,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCenterContent(ColorScheme colorScheme, FastingPhase phase) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Status label with fade transition
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Text(
            widget.isFasting ? 'FASTING' : 'READY',
            key: ValueKey(widget.isFasting),
            style: GoogleFonts.lexend(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              letterSpacing: 3,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Time display with smooth transition
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 10 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: Text(
                  formatElapsed(widget.elapsed),
                  style: GoogleFonts.lexend(
                    fontSize: 44,
                    fontWeight: FontWeight.w300,
                    color: colorScheme.onSurface,
                    letterSpacing: 2,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // Phase indicator with smooth transition
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey(phase.nameKey),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: phase.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: phase.color.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  phase.emoji,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  phase.nameKey,
                  style: GoogleFonts.lexend(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: phase.color,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color backgroundColor;
  final Color phaseColor;
  final Color? previousPhaseColor;
  final double colorAnimationValue;
  final bool isFasting;
  final double glowIntensity;
  final bool showGlow;

  _RingPainter({
    required this.progress,
    required this.primaryColor,
    required this.backgroundColor,
    required this.phaseColor,
    this.previousPhaseColor,
    required this.colorAnimationValue,
    required this.isFasting,
    required this.glowIntensity,
    required this.showGlow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 24) / 2;
    const strokeWidth = 10.0;

    // Background ring with subtle gradient effect
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    if (progress > 0) {
      // Calculate animated phase color
      Color animatedPhaseColor = phaseColor;
      if (previousPhaseColor != null && colorAnimationValue < 1.0) {
        animatedPhaseColor = Color.lerp(
          previousPhaseColor,
          phaseColor,
          colorAnimationValue,
        )!;
      }

      // Create gradient for progress stroke
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: -90 * (3.14159 / 180),
        endAngle: 270 * (3.14159 / 180),
        colors: [
          primaryColor,
          animatedPhaseColor,
        ],
        stops: const [0.0, 1.0],
      );

      // Progress ring with gradient and glow effect
      final progressPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      if (showGlow) {
        progressPaint.maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          2 + (4 * glowIntensity),
        );
      }

      canvas.drawArc(
        rect,
        -90 * (3.14159 / 180),
        360 * progress * (3.14159 / 180),
        false,
        progressPaint,
      );

      // Draw progress end cap with glow
      if (progress > 0.01) {
        final endAngle =
            -90 * (3.14159 / 180) + 360 * progress * (3.14159 / 180);
        final endX = center.dx + radius * (1 * (endAngle == 0 ? 1 : 1));
        final endY = center.dy + radius * (1 * (endAngle == 0 ? 0 : 1));

        final endCapPaint = Paint()
          ..color = animatedPhaseColor
          ..style = PaintingStyle.fill;

        if (showGlow) {
          endCapPaint.maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            4 + (6 * glowIntensity),
          );
        }

        canvas.drawCircle(Offset(endX, endY), 6, endCapPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.primaryColor != primaryColor ||
      oldDelegate.phaseColor != phaseColor ||
      oldDelegate.previousPhaseColor != previousPhaseColor ||
      oldDelegate.colorAnimationValue != colorAnimationValue ||
      oldDelegate.glowIntensity != glowIntensity ||
      oldDelegate.showGlow != showGlow;
}

class _RipplePainter extends CustomPainter {
  final double rippleValue;
  final Color color;

  _RipplePainter({
    required this.rippleValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    final currentRadius = maxRadius * rippleValue;
    final opacity = (1.0 - rippleValue) * 0.3;

    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0 * (1.0 - rippleValue);

    canvas.drawCircle(center, currentRadius, paint);
  }

  @override
  bool shouldRepaint(_RipplePainter oldDelegate) =>
      oldDelegate.rippleValue != rippleValue || oldDelegate.color != color;
}
