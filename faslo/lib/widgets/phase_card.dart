import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';
import '../core/constants/fasting_phases.dart';

class PhaseCard extends StatelessWidget {
  final FastingPhase phase;
  final bool isActive;
  final bool isFasting;

  const PhaseCard({
    super.key,
    required this.phase,
    required this.isActive,
    required this.isFasting,
  });

  String _getLocalizedName(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'phaseFedState':
        return l10n.phaseFedState;
      case 'phaseCatabolic':
        return l10n.phaseCatabolic;
      case 'phaseFatBurning':
        return l10n.phaseFatBurning;
      case 'phaseKetosis':
        return l10n.phaseKetosis;
      case 'phaseDeepKetosis':
        return l10n.phaseDeepKetosis;
      case 'phaseAutophagy':
        return l10n.phaseAutophagy;
      case 'phaseImmuneReset':
        return l10n.phaseImmuneReset;
      default:
        return key;
    }
  }

  String _getLocalizedDescription(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'phaseFedStateDesc':
        return l10n.phaseFedStateDesc;
      case 'phaseCatabolicDesc':
        return l10n.phaseCatabolicDesc;
      case 'phaseFatBurningDesc':
        return l10n.phaseFatBurningDesc;
      case 'phaseKetosisDesc':
        return l10n.phaseKetosisDesc;
      case 'phaseDeepKetosisDesc':
        return l10n.phaseDeepKetosisDesc;
      case 'phaseAutophagyDesc':
        return l10n.phaseAutophagyDesc;
      case 'phaseImmuneResetDesc':
        return l10n.phaseImmuneResetDesc;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey(phase.nameKey),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(24),
          border: Border(
            left: BorderSide(
              color: phase.color.withValues(alpha: 0.5),
              width: 4,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              phase.emoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _getLocalizedName(context, phase.nameKey),
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (isActive && isFasting) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'ACTIVE',
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getLocalizedDescription(context, phase.descriptionKey),
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
