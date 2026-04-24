import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../core/theme/theme_provider.dart';
import '../core/theme/app_theme.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final double height;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fullWidth = true,
    this.height = 56,
    this.isLoading = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _glowController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    // Scale animation for press feedback with bounce
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.97)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 100,
      ),
    ]).animate(_scaleController);

    // Glow animation for ambient effect
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _glowAnimation = CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    );

    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.isLoading || widget.onPressed == null) return;
    _scaleController.forward();
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(TapUpDetails details) {
    _scaleController.reverse();
  }

  void _handleTapCancel() {
    _scaleController.reverse();
  }

  void _handleTap() {
    if (widget.isLoading || widget.onPressed == null || _isPressed) return;

    setState(() => _isPressed = true);
    HapticFeedback.mediumImpact();
    widget.onPressed!();

    // Debounce: prevent rapid multiple taps
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() => _isPressed = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final isDisabled = widget.isLoading || widget.onPressed == null;

    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _glowAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: isDisabled ? null : _handleTapDown,
            onTapUp: isDisabled ? null : _handleTapUp,
            onTapCancel: isDisabled ? null : _handleTapCancel,
            child: Container(
              width: widget.fullWidth ? double.infinity : null,
              height: widget.height,
              decoration:
                  _getDecoration(themeProvider.mode, colorScheme, isDisabled),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isDisabled ? null : _handleTap,
                  borderRadius: BorderRadius.circular(28),
                  splashColor: colorScheme.onPrimary.withValues(alpha: 0.1),
                  highlightColor: Colors.transparent,
                  child: Center(
                    child: widget.isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                themeProvider.mode == AppThemeMode.minimalMono
                                    ? colorScheme.onSurface
                                    : colorScheme.onPrimary,
                              ),
                            ),
                          )
                        : AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              color:
                                  themeProvider.mode == AppThemeMode.minimalMono
                                      ? colorScheme.onSurface
                                      : colorScheme.onPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                            child: Text(widget.text),
                          ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _getDecoration(
      AppThemeMode mode, ColorScheme colorScheme, bool isDisabled) {
    final glowAlpha = isDisabled ? 0.0 : 0.2 + (0.1 * _glowAnimation.value);
    final primaryColor = isDisabled
        ? colorScheme.primary.withValues(alpha: 0.4)
        : colorScheme.primary;

    switch (mode) {
      case AppThemeMode.sageMint:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              primaryColor.withValues(alpha: 0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: isDisabled
              ? []
              : [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: glowAlpha),
                    blurRadius: 20 + (10 * _glowAnimation.value),
                    spreadRadius: 2 + (2 * _glowAnimation.value),
                    offset: const Offset(0, 4),
                  ),
                ],
        );
      case AppThemeMode.kineticObsidian:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              isDisabled
                  ? colorScheme.primaryContainer.withValues(alpha: 0.4)
                  : colorScheme.primaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDisabled
              ? []
              : [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: glowAlpha),
                    blurRadius: 24 + (12 * _glowAnimation.value),
                    spreadRadius: 3 + (3 * _glowAnimation.value),
                    offset: const Offset(0, 4),
                  ),
                ],
        );
      case AppThemeMode.minimalMono:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: primaryColor,
            width: 1.5,
          ),
        );
      case AppThemeMode.minimalOled:
        return BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDisabled
              ? []
              : [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: glowAlpha),
                    blurRadius: 20 + (10 * _glowAnimation.value),
                    spreadRadius: 2 + (2 * _glowAnimation.value),
                    offset: const Offset(0, 4),
                  ),
                ],
        );
    }
  }
}
