import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/pref_keys.dart';
import '../../core/constants/fasting_plans.dart';
import '../../providers/settings_provider.dart';
import '../../providers/fast_provider.dart';
import '../../widgets/gradient_button.dart';
import '../home/home_screen.dart';
import '../../l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  late PageController _languagePageController;
  int _currentPage = 0;
  final TextEditingController _nameController = TextEditingController();
  final Set<String> _selectedGoals = {};
  FastingPlan? _selectedPlan;
  bool _doctorConsultAccepted = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _languagePageController = PageController(viewportFraction: 0.4);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _languagePageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_isLoading) return;

    // Validate name on second page before proceeding
    if (_currentPage == 1 && _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.pleaseEnterName),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    if (_isLoading) return;

    if (_selectedPlan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.pleaseSelectPlan),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final settingsProvider = context.read<SettingsProvider>();
    final fastProvider = context.read<FastProvider>();

    try {
      await settingsProvider.setUserName(_nameController.text);
      await fastProvider.setActivePlan(_selectedPlan!);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PrefKeys.onboardingDone, true);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong. Please try again.'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              // Progress bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: LinearProgressIndicator(
                  value: (_currentPage + 1) / 3,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHigh,
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              // Pages
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (page) => setState(() => _currentPage = page),
                  children: [
                    _buildLanguagePage(),
                    _buildWelcomePage(keyboardHeight),
                    _buildGoalsPage(keyboardHeight),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguagePage() {
    final colorScheme = Theme.of(context).colorScheme;
    final settingsProvider = context.watch<SettingsProvider>();

    final languages = [
      {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
      {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
      {'code': 'ja', 'name': '日本語', 'flag': '🇯🇵'},
      {'code': 'ko', 'name': '한국어', 'flag': '🇰🇷'},
      {'code': 'hi', 'name': 'हिन्दी', 'flag': '🇮🇳'},
    ];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: SingleChildScrollView(
        key: ValueKey(settingsProvider.locale.languageCode),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Icon(
              Icons.language_outlined,
              size: 64,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.language,
              style: GoogleFonts.lexend(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.preferredLanguage,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ...languages.map((lang) {
              final isSelected =
                  settingsProvider.locale.languageCode == lang['code'];
              return GestureDetector(
                onTap: () => settingsProvider.setLocale(lang['code']!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primary.withValues(alpha: 0.12)
                        : colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          isSelected ? colorScheme.primary : Colors.transparent,
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color:
                                  colorScheme.primary.withValues(alpha: 0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    children: [
                      Text(
                        lang['flag']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        lang['name']!,
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: colorScheme.primary,
                          size: 22,
                        ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 48),
            GradientButton(
              text: AppLocalizations.of(context)!.continueJourney,
              onPressed: _isLoading ? null : _nextPage,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage(double keyboardHeight) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = context.watch<ThemeProvider>();

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + keyboardHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            AppLocalizations.of(context)!.welcomeTo,
            style: GoogleFonts.lexend(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.appName,
            style: GoogleFonts.lexend(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.welcomeSubtitle,
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            AppLocalizations.of(context)!.howShallWeCallYou,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 56,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterYourName,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              textDirection: TextDirection.ltr,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            AppLocalizations.of(context)!.chooseYourStyle,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildThemeCard(
                AppLocalizations.of(context)!.themeSageMint,
                AppThemeMode.sageMint,
                themeProvider,
              ),
              const SizedBox(width: 12),
              _buildThemeCard(
                AppLocalizations.of(context)!.themeObsidian,
                AppThemeMode.kineticObsidian,
                themeProvider,
              ),
              const SizedBox(width: 12),
              _buildThemeCard(
                AppLocalizations.of(context)!.themeMinimal,
                AppThemeMode.minimalMono,
                themeProvider,
              ),
            ],
          ),
          const SizedBox(height: 40),
          GradientButton(
            text: AppLocalizations.of(context)!.startJourney,
            onPressed: _isLoading ? null : _nextPage,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard(
    String name,
    AppThemeMode mode,
    ThemeProvider themeProvider,
  ) {
    final isSelected = themeProvider.mode == mode;
    final colorScheme = Theme.of(context).colorScheme;

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

  Widget _buildGoalsPage(double keyboardHeight) {
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;
    final goals = [
      {
        'key': 'weight',
        'label': loc.goalWeightLoss,
        'icon': Icons.monitor_weight_outlined
      },
      {
        'key': 'metabolic',
        'label': loc.goalMetabolic,
        'icon': Icons.favorite_border
      },
      {
        'key': 'clarity',
        'label': loc.goalClarity,
        'icon': Icons.psychology_outlined
      },
      {'key': 'longevity', 'label': loc.goalLongevity, 'icon': Icons.timelapse},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.chooseGoals,
            style: GoogleFonts.lexend(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.2,
            children: goals.map((goal) {
              final isSelected = _selectedGoals.contains(goal['key']);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedGoals.remove(goal['key'] as String);
                    } else {
                      _selectedGoals.add(goal['key'] as String);
                    }
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primary.withValues(alpha: 0.12)
                        : colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color:
                          isSelected ? colorScheme.primary : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        goal['icon'] as IconData,
                        size: 18,
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          goal['label'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurface,
                          ),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.selectFastingPlan,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: fastingPlans.length - 1,
              itemBuilder: (context, index) {
                final plan = fastingPlans[index];
                final isSelected = _selectedPlan?.ratio == plan.ratio;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPlan = plan),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.primary.withValues(alpha: 0.1)
                          : colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? colorScheme.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          plan.ratio,
                          style: GoogleFonts.lexend(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                () {
                                  final loc = AppLocalizations.of(context)!;
                                  switch (plan.nameKey) {
                                    case 'planCircadian':
                                      return loc.planCircadian;
                                    case 'planGentle':
                                      return loc.planGentle;
                                    case 'planLeangains':
                                      return loc.planLeangains;
                                    case 'planFatBurner':
                                      return loc.planFatBurner;
                                    case 'planWarrior':
                                      return loc.planWarrior;
                                    case 'planOMAD':
                                      return loc.planOMAD;
                                    default:
                                      return plan.nameKey;
                                  }
                                }(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                () {
                                  final loc = AppLocalizations.of(context)!;
                                  switch (plan.difficultyKey) {
                                    case 'diffBeginner':
                                      return loc.diffBeginner;
                                    case 'diffBalanced':
                                      return loc.diffBalanced;
                                    case 'diffModerate':
                                      return loc.diffModerate;
                                    case 'diffIntense':
                                      return loc.diffIntense;
                                    case 'diffAdvanced':
                                      return loc.diffAdvanced;
                                    default:
                                      return plan.difficultyKey;
                                  }
                                }(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: colorScheme.primary,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Doctor Consultation Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                _doctorConsultAccepted = !_doctorConsultAccepted;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _doctorConsultAccepted,
                  onChanged: (value) {
                    setState(() {
                      _doctorConsultAccepted = value ?? false;
                    });
                  },
                  activeColor: colorScheme.primary,
                  visualDensity: VisualDensity.compact,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      AppLocalizations.of(context)!.medicalDisclaimer,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          GradientButton(
            text: AppLocalizations.of(context)!.startJourney,
            onPressed: _doctorConsultAccepted ? _nextPage : () {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
