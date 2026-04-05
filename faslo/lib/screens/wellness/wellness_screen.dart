import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/wellness_provider.dart';
import '../../providers/settings_provider.dart';
import '../../l10n/app_localizations.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({super.key});

  @override
  State<WellnessScreen> createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'de', 'name': 'Deutsch'},
      {'code': 'ja', 'name': '日本語'},
      {'code': 'ko', 'name': '한국어'},
      {'code': 'hi', 'name': 'हिन्दी'},
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Profile',
              style: GoogleFonts.lexend(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),

            // Change Name
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change Name',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: settingsProvider.userName,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          if (_nameController.text.isNotEmpty) {
                            settingsProvider.setUserName(_nameController.text);
                            _nameController.clear();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Language Selector
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Language',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        int tempSelectedIndex = languages.indexWhere((lang) =>
                            lang['code'] ==
                            settingsProvider.locale.languageCode);

                        return ListWheelScrollView.useDelegate(
                          itemExtent: 50,
                          perspective: 0.005,
                          diameterRatio: 1.5,
                          physics: const FixedExtentScrollPhysics(),
                          controller: FixedExtentScrollController(
                            initialItem: tempSelectedIndex,
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() => tempSelectedIndex = index);
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: languages.length,
                            builder: (context, index) {
                              final lang = languages[index];
                              final isVisible = index == tempSelectedIndex;

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOutCubic,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                decoration: BoxDecoration(
                                  color: isVisible
                                      ? colorScheme.primary
                                          .withValues(alpha: 0.12)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    lang['name']!,
                                    style: GoogleFonts.lexend(
                                      fontSize: isVisible ? 18 : 16,
                                      fontWeight: isVisible
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: isVisible
                                          ? colorScheme.primary
                                          : colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        final scrollController =
                            PrimaryScrollController.of(context);
                        if (scrollController is FixedExtentScrollController) {
                          final index = scrollController.selectedItem;
                          settingsProvider.setLocale(languages[index]['code']!);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          'Change Language',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Footer
            Center(
              child: Text(
                'Made for the community\nby zerosix.tech',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
