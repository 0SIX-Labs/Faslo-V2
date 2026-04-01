import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import '../../core/constants/fasting_phases.dart';
import '../../providers/fast_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/fasting_ring.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/phase_card.dart';
import '../../widgets/share_card.dart';
import '../../services/share_service.dart';
import '../plans/plans_screen.dart';
import '../history/history_screen.dart';
import '../wellness/wellness_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late ConfettiController _confettiController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  FastingPhase? _previousPhase;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 1500));
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fastProvider = context.watch<FastProvider>();
    final phase = currentPhase(fastProvider.elapsed);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Subtle phase color sync - very light tint
          gradient: fastProvider.isFasting
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.surface,
                    Color.lerp(
                      colorScheme.surface,
                      phase.color,
                      0.03,
                    )!,
                  ],
                )
              : null,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.02),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _buildCurrentScreen(),
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return const PlansScreen(key: ValueKey('plans'));
      case 2:
        return const HistoryScreen(key: ValueKey('history'));
      case 3:
        return const WellnessScreen(key: ValueKey('wellness'));
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    final fastProvider = context.watch<FastProvider>();
    final settingsProvider = context.watch<SettingsProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final phase = currentPhase(fastProvider.elapsed);

    // Detect phase transition and trigger haptic feedback
    if (_previousPhase != null &&
        _previousPhase!.nameKey != phase.nameKey &&
        fastProvider.isFasting) {
      HapticFeedback.lightImpact();
    }
    _previousPhase = phase;

    return SafeArea(
      child: Stack(
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                const SizedBox(height: 24),
                // 1. Greeting (small, subtle)
                _buildGreeting(colorScheme, settingsProvider, fastProvider),
                const Spacer(),
                // 2. MAIN FASTING RING (centerpiece) - ~60% of vertical space
                _buildMainFastingRing(fastProvider, colorScheme, phase),
                const SizedBox(height: 32),
                // 3. PHASE CARD (below ring) - shows current phase
                _buildPhaseCard(phase, fastProvider),
                const Spacer(),
                // 4. PRIMARY BUTTON - Start Fast / End Fast
                _buildPrimaryButton(fastProvider, colorScheme),
                const SizedBox(height: 32),
              ],
            ),
          ),
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: [
                colorScheme.primary,
                colorScheme.secondary,
                colorScheme.primaryContainer,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(
    ColorScheme colorScheme,
    SettingsProvider settingsProvider,
    FastProvider fastProvider,
  ) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    // Add encouraging message when fasting
    if (fastProvider.isFasting) {
      final hours = fastProvider.elapsed.inHours;
      if (hours >= 12) {
        greeting = 'Keep going';
      } else if (hours >= 8) {
        greeting = 'You\'re doing great';
      } else if (hours >= 4) {
        greeting = 'Stay strong';
      }
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value * 0.7,
            child: Text(
              greeting,
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 1,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainFastingRing(
    FastProvider fastProvider,
    ColorScheme colorScheme,
    FastingPhase phase,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: FastingRing(
                elapsed: fastProvider.elapsed,
                targetHours: fastProvider.activePlan.fastHours,
                isFasting: fastProvider.isFasting,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhaseCard(FastingPhase phase, FastProvider fastProvider) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: PhaseCard(
              phase: phase,
              isActive: true,
              isFasting: fastProvider.isFasting,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPrimaryButton(
    FastProvider fastProvider,
    ColorScheme colorScheme,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 2000),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: fastProvider.isFasting
                  ? _buildEndFastButton(fastProvider, colorScheme)
                  : _buildStartFastButton(fastProvider, colorScheme),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStartFastButton(
    FastProvider fastProvider,
    ColorScheme colorScheme,
  ) {
    return GradientButton(
      text: 'Start Fast',
      onPressed: () {
        fastProvider.startFast();
        HapticFeedback.mediumImpact();
      },
    );
  }

  Widget _buildEndFastButton(
    FastProvider fastProvider,
    ColorScheme colorScheme,
  ) {
    return GradientButton(
      text: 'End Fast',
      onPressed: () async {
        final session = await fastProvider.stopFast();
        if (session != null && mounted) {
          _confettiController.play();
          HapticFeedback.heavyImpact();
          _showCompletionSnackBar(session);
        }
      },
    );
  }

  void _showCompletionSnackBar(dynamic session) {
    final fastProvider = context.read<FastProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              // Share Card
              ShareCard(
                elapsed: session.elapsed,
                streak: fastProvider.streak,
                planRatio: session.planRatio,
              ),
              const SizedBox(height: 24),
              // Share Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: () {
                    ShareService.shareFast(
                      session: session,
                      streak: fastProvider.streak,
                    );
                  },
                  icon: const Icon(Icons.share_rounded, size: 20),
                  label: Text(
                    'Share',
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Done Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Done',
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
