import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/settings_provider.dart';
import '../../providers/fast_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final settingsProvider = context.watch<SettingsProvider>();
    final fastProvider = context.watch<FastProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    final languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'de', 'name': 'Deutsch'},
      {'code': 'ja', 'name': '日本語'},
      {'code': 'ko', 'name': '한국어'},
      {'code': 'hi', 'name': 'हिन्दी'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Appearance
            _buildSection(
              'Appearance',
              [
                Row(
                  children: [
                    _buildThemeCard(
                      'Sage Mint',
                      AppThemeMode.sageMint,
                      themeProvider,
                      colorScheme,
                    ),
                    const SizedBox(width: 8),
                    _buildThemeCard(
                      'Kinetic Obsidian',
                      AppThemeMode.kineticObsidian,
                      themeProvider,
                      colorScheme,
                    ),
                    const SizedBox(width: 8),
                    _buildThemeCard(
                      'Minimal Mono',
                      AppThemeMode.minimalMono,
                      themeProvider,
                      colorScheme,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Long-press the timer to toggle Minimal OLED',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              colorScheme,
            ),
            const SizedBox(height: 16),
            // Language
            _buildSection(
              'Language',
              [
                for (final lang in languages)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        settingsProvider.setLocale(lang['code']!);
                      },
                      borderRadius: BorderRadius.circular(14),
                      splashColor: colorScheme.primary.withValues(alpha: 0.2),
                      highlightColor:
                          colorScheme.primary.withValues(alpha: 0.08),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: settingsProvider.locale.languageCode ==
                                  lang['code']
                              ? colorScheme.primary.withValues(alpha: 0.12)
                              : colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: settingsProvider.locale.languageCode ==
                                    lang['code']
                                ? colorScheme.primary
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              lang['name']!,
                              style: GoogleFonts.lexend(
                                fontSize: 15,
                                fontWeight:
                                    settingsProvider.locale.languageCode ==
                                            lang['code']
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                color: settingsProvider.locale.languageCode ==
                                        lang['code']
                                    ? colorScheme.primary
                                    : colorScheme.onSurface,
                              ),
                            ),
                            const Spacer(),
                            if (settingsProvider.locale.languageCode ==
                                lang['code'])
                              Icon(
                                Icons.check_circle,
                                color: colorScheme.primary,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
              colorScheme,
            ),
            const SizedBox(height: 16),
            // Units
            _buildSection(
              'Units',
              [
                SwitchListTile(
                  title: const Text('Metric (kg)'),
                  subtitle: Text(
                    settingsProvider.isMetric
                        ? 'Using kilograms'
                        : 'Using pounds',
                  ),
                  value: settingsProvider.isMetric,
                  onChanged: (v) => settingsProvider.setMetric(v),
                ),
                SwitchListTile(
                  title: const Text('24-hour clock'),
                  subtitle: Text(
                    settingsProvider.is24h
                        ? '24-hour format'
                        : '12-hour format',
                  ),
                  value: settingsProvider.is24h,
                  onChanged: (v) => settingsProvider.set24h(v),
                ),
              ],
              colorScheme,
            ),
            const SizedBox(height: 16),
            // Notifications
            _buildSection(
              'Notifications',
              [
                SwitchListTile(
                  title: const Text('Fast complete alert'),
                  value: settingsProvider.notifFastEnd,
                  onChanged: (v) =>
                      settingsProvider.setNotif('notif_fast_end', v),
                ),
                SwitchListTile(
                  title: const Text('Halfway milestone'),
                  value: settingsProvider.notifHalfway,
                  onChanged: (v) =>
                      settingsProvider.setNotif('notif_halfway', v),
                ),
                SwitchListTile(
                  title: const Text('Ketosis milestone (12h)'),
                  value: settingsProvider.notifKetosis,
                  onChanged: (v) =>
                      settingsProvider.setNotif('notif_ketosis', v),
                ),
                SwitchListTile(
                  title: const Text('Water reminders'),
                  value: settingsProvider.notifWater,
                  onChanged: (v) => settingsProvider.setNotif('notif_water', v),
                ),
              ],
              colorScheme,
            ),
            const SizedBox(height: 16),
            // Data
            _buildSection(
              'Data Management',
              [
                ListTile(
                  leading: const Icon(Icons.download_rounded),
                  title: const Text('Export as CSV'),
                  onTap: () => _exportCSV(context, fastProvider),
                ),
                ListTile(
                  leading: Icon(Icons.delete_forever, color: colorScheme.error),
                  title: Text(
                    'Reset All Data',
                    style: TextStyle(color: colorScheme.error),
                  ),
                  onTap: () => _showResetDialog(context),
                ),
              ],
              colorScheme,
            ),
            const SizedBox(height: 16),
            // About
            _buildSection(
              'About Faslo',
              [
                const ListTile(
                  title: Text('Version 1.0.0'),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'All your data stays on this device.\nNo accounts. No tracking. No ads.',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5),
                  ),
                ),
              ],
              colorScheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<Widget> children,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
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
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? colorScheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 20,
                height: 20,
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

  Future<void> _exportCSV(
      BuildContext context, FastProvider fastProvider) async {
    try {
      final sessions = fastProvider.sessions;
      final buffer = StringBuffer();
      buffer.writeln('id,start,end,plan,targetHours,completed');
      for (final s in sessions) {
        buffer.writeln(
            '${s.id},${s.startTime.toIso8601String()},${s.endTime?.toIso8601String() ?? ''},${s.planRatio},${s.targetHours},${s.completed}');
      }
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/faslo_export.csv');
      await file.writeAsString(buffer.toString());
      await Share.shareXFiles([XFile(file.path)],
          text: 'Faslo fasting data export');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export failed')),
        );
      }
    }
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset All Data'),
          content: const Text(
            'This will delete all your fasting history. Are you sure?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<SettingsProvider>().resetAll();
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
