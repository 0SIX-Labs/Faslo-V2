import 'package:flutter/material.dart';

class FastingPhase {
  final int startHours;
  final String nameKey; // l10n key
  final String emoji;
  final Color color;
  final String descriptionKey; // l10n key

  const FastingPhase({
    required this.startHours,
    required this.nameKey,
    required this.emoji,
    required this.color,
    required this.descriptionKey,
  });
}

const List<FastingPhase> fastingPhases = [
  FastingPhase(
    startHours: 0,
    nameKey: 'phaseFedState',
    emoji: '🍽️',
    color: Color(0xFF9E9E9E),
    descriptionKey: 'phaseFedStateDesc',
  ),
  FastingPhase(
    startHours: 4,
    nameKey: 'phaseCatabolic',
    emoji: '⚙️',
    color: Color(0xFF66BB6A),
    descriptionKey: 'phaseCatabolicDesc',
  ),
  FastingPhase(
    startHours: 8,
    nameKey: 'phaseFatBurning',
    emoji: '🔥',
    color: Color(0xFFFF8A65),
    descriptionKey: 'phaseFatBurningDesc',
  ),
  FastingPhase(
    startHours: 12,
    nameKey: 'phaseKetosis',
    emoji: '💫',
    color: Color(0xFF3D7A5E),
    descriptionKey: 'phaseKetosisDesc',
  ),
  FastingPhase(
    startHours: 18,
    nameKey: 'phaseDeepKetosis',
    emoji: '⚡',
    color: Color(0xFF00E3FD),
    descriptionKey: 'phaseDeepKetosisDesc',
  ),
  FastingPhase(
    startHours: 24,
    nameKey: 'phaseAutophagy',
    emoji: '🧬',
    color: Color(0xFFBEEE00),
    descriptionKey: 'phaseAutophagyDesc',
  ),
  FastingPhase(
    startHours: 72,
    nameKey: 'phaseImmuneReset',
    emoji: '🛡️',
    color: Color(0xFFFFEEA5),
    descriptionKey: 'phaseImmuneResetDesc',
  ),
];

FastingPhase currentPhase(Duration elapsed) {
  final hours = elapsed.inHours;
  FastingPhase result = fastingPhases.first;
  for (final phase in fastingPhases) {
    if (hours >= phase.startHours) result = phase;
  }
  return result;
}
