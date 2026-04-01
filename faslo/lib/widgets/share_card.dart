import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareCard extends StatelessWidget {
  final Duration elapsed;
  final int streak;
  final String planRatio;

  const ShareCard({
    super.key,
    required this.elapsed,
    required this.streak,
    required this.planRatio,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hours = elapsed.inHours;
    final minutes = elapsed.inMinutes % 60;
    final durationStr = minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Duration
          Text(
            durationStr,
            style: GoogleFonts.lexend(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: colorScheme.onSurface,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 8),
          // Label
          Text(
            'FAST COMPLETED',
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 24),
          // Divider
          Container(
            width: 40,
            height: 1,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: 24),
          // Streak
          if (streak > 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '🔥',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  '$streak day${streak > 1 ? 's' : ''} streak',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          // Message
          Text(
            'Stay consistent.\nYour body thanks you.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          // Divider
          Container(
            width: 40,
            height: 1,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          // Branding
          Text(
            'FASLO',
            style: GoogleFonts.lexend(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }
}
