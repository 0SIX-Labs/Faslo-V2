import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/settings_provider.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/language_picker.dart';

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
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'de', 'name': 'Deutsch'},
      {'code': 'ja', 'name': '日本語'},
      {'code': 'ko', 'name': '한국어'},
      {'code': 'hi', 'name': 'हिन्दी'},
    ];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + keyboardHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                l10n.wellness,
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
                              settingsProvider
                                  .setUserName(_nameController.text);
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

              // Theme Selector
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
                      l10n.appearance,
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return Row(
                          children: [
                            _buildThemeCard(
                              l10n.themeSageMint,
                              AppThemeMode.sageMint,
                              themeProvider,
                              colorScheme,
                            ),
                            const SizedBox(width: 12),
                            _buildThemeCard(
                              l10n.themeObsidian,
                              AppThemeMode.kineticObsidian,
                              themeProvider,
                              colorScheme,
                            ),
                            const SizedBox(width: 12),
                            _buildThemeCard(
                              l10n.themeMinimal,
                              AppThemeMode.minimalMono,
                              themeProvider,
                              colorScheme,
                            ),
                          ],
                        );
                      },
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
                      l10n.language,
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: LanguagePicker(
                        languages: languages,
                        selectedCode: settingsProvider.locale.languageCode,
                        onSelected: (code) => settingsProvider.setLocale(code),
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
      ),
    );
  }

  Widget _buildThemeCard(
    String name,
    AppThemeMode mode,
    ThemeProvider themeProvider,
    ColorScheme colorScheme,
  ) {
    final isSelected = themeProvider.mode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () => themeProvider.setTheme(mode),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.1)
                : colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? colorScheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _getThemePreviewColor(mode),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getThemePreviewColor(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.sageMint:
        return const Color(0xFF3D7A5E);
      case AppThemeMode.kineticObsidian:
        return const Color(0xFFBEEE00);
      case AppThemeMode.minimalMono:
        return const Color(0xFF000000);
      case AppThemeMode.minimalOled:
        return Colors.white;
    }
  }
}
