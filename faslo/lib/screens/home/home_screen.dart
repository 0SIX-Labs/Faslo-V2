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
import '../../providers/wellness_provider.dart';
import '../plans/plans_screen.dart';
import '../history/history_screen.dart';
import '../wellness/wellness_screen.dart';
import '../../l10n/app_localizations.dart';

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
  bool _isProcessing = false;

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
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom -
                    80,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // 1. Greeting (small, subtle)
                    _buildGreeting(colorScheme, settingsProvider, fastProvider),
                    const Spacer(),
                    // 2. MAIN FASTING RING (centerpiece) - ~60% of vertical space
                    _buildMainFastingRing(fastProvider, colorScheme, phase),
                    const SizedBox(height: 24),
                    // 2.5 Milestone Progress Bar
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: fastProvider.isFasting
                          ? _buildMilestoneProgressBar(
                              fastProvider, colorScheme)
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 24),
                    // 3. WATER LOGGING WIDGET
                    _buildWaterWidget(),
                    const Spacer(),
                    // 5. PRIMARY BUTTON - Start Fast / End Fast
                    _buildPrimaryButton(fastProvider, colorScheme),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
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
    final userName = settingsProvider.userName;
    final loc = AppLocalizations.of(context)!;

    if (hour < 12) {
      greeting = loc.greetingMorning;
    } else if (hour < 17) {
      greeting = loc.greetingAfternoon;
    } else {
      greeting = loc.greetingEvening;
    }

    if (userName.isNotEmpty) {
      final capitalizedName = userName[0].toUpperCase() + userName.substring(1);
      greeting = '$greeting\n$capitalizedName';
    }

    // Add encouraging message when fasting
    if (fastProvider.isFasting) {
      final hours = fastProvider.elapsed.inHours;
      if (hours >= 12) {
        greeting = loc.encourageKeepGoing;
      } else if (hours >= 8) {
        greeting = loc.encourageDoingGreat;
      } else if (hours >= 4) {
        greeting = loc.encourageStayStrong;
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
              textAlign: TextAlign.center,
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
    final l10n = AppLocalizations.of(context)!;
    return GradientButton(
      text: l10n.startFasting,
      isLoading: _isProcessing,
      onPressed: () async {
        if (_isProcessing) return;
        setState(() => _isProcessing = true);
        try {
          await fastProvider.startFast();
          HapticFeedback.mediumImpact();
        } finally {
          if (mounted) setState(() => _isProcessing = false);
        }
      },
    );
  }

  Widget _buildEndFastButton(
    FastProvider fastProvider,
    ColorScheme colorScheme,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return GradientButton(
      text: l10n.stopFasting,
      isLoading: _isProcessing,
      onPressed: () async {
        if (_isProcessing) return;
        setState(() => _isProcessing = true);
        try {
          final session = await fastProvider.stopFast();
          if (session != null && mounted) {
            _confettiController.play();
            HapticFeedback.heavyImpact();
            _showCompletionSnackBar(session);
          }
        } finally {
          if (mounted) setState(() => _isProcessing = false);
        }
      },
    );
  }

  Widget _buildWaterWidget() {
    final wellnessProvider = context.watch<WellnessProvider>();
    final settingsProvider = context.watch<SettingsProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    final currentWater = wellnessProvider.getTodayWater();
    final progress =
        (currentWater / settingsProvider.waterGoal).clamp(0.0, 1.0);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 2100),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 25 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Minus Button LEFT
                    GestureDetector(
                      onTap: currentWater > 0
                          ? () {
                              wellnessProvider.decrementWater().ignore();
                              HapticFeedback.lightImpact();
                            }
                          : null,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        opacity: currentWater > 0 ? 1.0 : 0.3,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.remove_rounded,
                            color: colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    // CENTER: Water icon + text
                    Row(
                      children: [
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 2.5,
                                backgroundColor:
                                    colorScheme.surfaceContainerHigh,
                                color:
                                    colorScheme.primary.withValues(alpha: 0.7),
                              ),
                              const Text(
                                '💧',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '$currentWater / ${settingsProvider.waterGoal}',
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),

                    // Plus Button RIGHT
                    GestureDetector(
                      onTap: currentWater < 8
                          ? () {
                              wellnessProvider.incrementWater().ignore();
                              HapticFeedback.lightImpact();
                            }
                          : null,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        opacity: currentWater < 8 ? 1.0 : 0.3,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 150),
                          scale: currentWater == 0 ? 1.08 : 1.0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  colorScheme.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              color:
                                  colorScheme.primary.withValues(alpha: 0.85),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMilestoneProgressBar(
      FastProvider fastProvider, ColorScheme colorScheme) {
    final elapsedHours = fastProvider.elapsed.inHours;

    double calculateProgress() {
      if (elapsedHours >= 16) return 1.0;
      if (elapsedHours >= 8) return 0.66 + ((elapsedHours - 8) / 8) * 0.34;
      if (elapsedHours >= 4) return 0.33 + ((elapsedHours - 4) / 4) * 0.33;
      return (elapsedHours / 4) * 0.33;
    }

    final progress = calculateProgress();
    final icons = [
      Icons.bolt_outlined,
      Icons.local_fire_department_outlined,
      Icons.self_improvement_outlined,
      Icons.check_circle_outlined
    ];

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 2000),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 8,
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: colorScheme.surfaceContainerHigh,
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          final isComplete = progress > index / 3;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isComplete
                                  ? colorScheme.primary
                                  : colorScheme.surfaceContainerHigh,
                              shape: BoxShape.circle,
                              boxShadow: isComplete
                                  ? [
                                      BoxShadow(
                                        color: colorScheme.primary
                                            .withValues(alpha: 0.35),
                                        blurRadius: 12,
                                        spreadRadius: 3,
                                      )
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Icon(
                                icons[index],
                                size: 18,
                                color: isComplete
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCompletionSnackBar(dynamic session) {
    final fastProvider = context.read<FastProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final GlobalKey repaintKey = GlobalKey();

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
              RepaintBoundary(
                key: repaintKey,
                child: ShareCard(
                  elapsed: session.elapsed,
                  streak: fastProvider.streak,
                  planRatio: session.planRatio,
                  completedAt: session.endTime ?? DateTime.now(),
                ),
              ),
              const SizedBox(height: 24),
              // Share Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: () {
                    ShareService.shareImage(repaintKey);
                  },
                  icon: const Icon(Icons.share_rounded, size: 20),
                  label: Text(
                    AppLocalizations.of(context)!.shareButton,
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
                    AppLocalizations.of(context)!.shareDone,
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
