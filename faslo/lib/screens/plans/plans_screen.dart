import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/fasting_plans.dart';
import '../../providers/fast_provider.dart';
import '../../widgets/gradient_button.dart';
import '../../l10n/app_localizations.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  int _customFastHours = 16;
  int _customEatHours = 8;

  String _getLocalizedName(String key, AppLocalizations l10n) {
    switch (key) {
      case 'planCircadian':
        return l10n.planCircadian;
      case 'planGentle':
        return l10n.planGentle;
      case 'planLeangains':
        return l10n.planLeangains;
      case 'planFatBurner':
        return l10n.planFatBurner;
      case 'planWarrior':
        return l10n.planWarrior;
      case 'planOMAD':
        return l10n.planOMAD;
      case 'planCustom':
        return l10n.planCustom;
      default:
        return key;
    }
  }

  String _getLocalizedDifficulty(String key, AppLocalizations l10n) {
    switch (key) {
      case 'diffBeginner':
        return l10n.diffBeginner;
      case 'diffBalanced':
        return l10n.diffBalanced;
      case 'diffModerate':
        return l10n.diffModerate;
      case 'diffIntense':
        return l10n.diffIntense;
      case 'diffAdvanced':
        return l10n.diffAdvanced;
      case 'diffCustom':
        return l10n.diffCustom;
      default:
        return key;
    }
  }

  String _getLocalizedBenefit(String key, AppLocalizations l10n) {
    switch (key) {
      case 'benefitCircadian':
        return l10n.benefitCircadian;
      case 'benefitGentle':
        return l10n.benefitGentle;
      case 'benefitLeangains':
        return l10n.benefitLeangains;
      case 'benefitFatBurner':
        return l10n.benefitFatBurner;
      case 'benefitWarrior':
        return l10n.benefitWarrior;
      case 'benefitOMAD':
        return l10n.benefitOMAD;
      case 'benefitCustom':
        return l10n.benefitCustom;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fastProvider = context.watch<FastProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Choose your rhythm',
              style: GoogleFonts.lexend(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            // Featured plans
            ...fastingPlans.take(2).map((plan) {
              final isActive = fastProvider.activePlan.ratio == plan.ratio;
              return _buildFeaturedPlanCard(plan, isActive, colorScheme, l10n);
            }),
            const SizedBox(height: 24),
            // Popular protocols
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Protocols',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View all',
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Remaining plans
            ...fastingPlans.skip(2).where((p) => !p.isCustom).map((plan) {
              final isActive = fastProvider.activePlan.ratio == plan.ratio;
              return _buildPlanListItem(plan, isActive, colorScheme, l10n);
            }),
            const SizedBox(height: 24),
            // Customize button
            GradientButton(
              text: 'Customize Your Plan',
              onPressed: () => _showCustomizeSheet(context),
            ),
            const SizedBox(height: 24),
            // Motivational quote
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '"The best time to start is now. The second best time is also now."',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedPlanCard(
    FastingPlan plan,
    bool isActive,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return GestureDetector(
      onTap: () => context.read<FastProvider>().setActivePlan(plan),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isActive
              ? colorScheme.primary.withValues(alpha: 0.1)
              : colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isActive ? colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plan.ratio,
                  style: GoogleFonts.lexend(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.primary,
                  ),
                ),
                if (isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: GoogleFonts.lexend(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimary,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _getLocalizedName(plan.nameKey, l10n),
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getLocalizedDifficulty(plan.difficultyKey, l10n),
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getLocalizedBenefit(plan.benefitKey, l10n),
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanListItem(
    FastingPlan plan,
    bool isActive,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return GestureDetector(
      onTap: () => context.read<FastProvider>().setActivePlan(plan),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive
              ? colorScheme.primary.withValues(alpha: 0.1)
              : colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? colorScheme.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                plan.ratio,
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getLocalizedName(plan.nameKey, l10n),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    _getLocalizedDifficulty(plan.difficultyKey, l10n),
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomizeSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Customize Your Plan',
                    style: GoogleFonts.lexend(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Fasting: $_customFastHours hours',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Slider(
                    value: _customFastHours.toDouble(),
                    min: 1,
                    max: 23,
                    divisions: 22,
                    label: '$_customFastHours h',
                    onChanged: (value) {
                      setSheetState(() => _customFastHours = value.toInt());
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Eating: $_customEatHours hours',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Slider(
                    value: _customEatHours.toDouble(),
                    min: 1,
                    max: 23,
                    divisions: 22,
                    label: '$_customEatHours h',
                    onChanged: (value) {
                      setSheetState(() => _customEatHours = value.toInt());
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 24),
                  GradientButton(
                    text: 'Apply Custom Plan',
                    onPressed: () {
                      final customPlan = FastingPlan(
                        ratio: '$_customFastHours:$_customEatHours',
                        nameKey: 'Custom',
                        fastHours: _customFastHours,
                        eatHours: _customEatHours,
                        difficultyKey: 'CUSTOM',
                        benefitKey: 'Set your own fasting parameters',
                        isCustom: true,
                      );
                      context.read<FastProvider>().setActivePlan(customPlan);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
