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
  String _selectedExperience = 'Beginner';
  final Set<String> _selectedGoals = {};
  FastingPlan? _selectedPlan;
  bool _languageInitialized = false;

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
    // Validate name on second page before proceeding
    if (_currentPage == 1 && _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter your name to continue'),
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
    if (_selectedPlan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a fasting plan to continue'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final settingsProvider = context.read<SettingsProvider>();
    final fastProvider = context.read<FastProvider>();

    await settingsProvider.setUserName(_nameController.text);
    await fastProvider.setActivePlan(_selectedPlan!);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefKeys.onboardingDone, true);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildLanguagePage(),
                  _buildWelcomePage(),
                  _buildGoalsPage(),
                ],
              ),
            ),
          ],
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
              onPressed: _nextPage,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = context.watch<ThemeProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'Welcome to',
            style: GoogleFonts.lexend(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.clarity,
            style: GoogleFonts.lexend(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your journey towards mindful fasting begins here.',
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'HOW SHALL WE CALL YOU?',
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
                hintText: 'Enter your name',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'CHOOSE YOUR STYLE',
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
                'Sage Mint',
                AppThemeMode.sageMint,
                themeProvider,
              ),
              const SizedBox(width: 12),
              _buildThemeCard(
                'Kinetic Obsidian',
                AppThemeMode.kineticObsidian,
                themeProvider,
              ),
              const SizedBox(width: 12),
              _buildThemeCard(
                'Minimal Mono',
                AppThemeMode.minimalMono,
                themeProvider,
              ),
            ],
          ),
          const SizedBox(height: 40),
          GradientButton(
            text: 'Continue Journey',
            onPressed: _nextPage,
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

  Widget _buildLanguageCarousel(
    List<Map<String, String>> languages,
    SettingsProvider settingsProvider,
    ColorScheme colorScheme,
  ) {
    final selectedIndex = languages.indexWhere(
      (lang) => lang['code'] == settingsProvider.locale.languageCode,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_languagePageController.hasClients &&
          selectedIndex >= 0 &&
          !_languageInitialized) {
        _languageInitialized = true;
        _languagePageController.jumpToPage(selectedIndex);
      }
    });

    return SizedBox(
      height: 60,
      child: PageView.builder(
        controller: _languagePageController,
        onPageChanged: (index) {
          settingsProvider.setLocale(languages[index]['code']!);
        },
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final lang = languages[index];
          final isSelected =
              settingsProvider.locale.languageCode == lang['code'];

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontSize: isSelected ? 18 : 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : colorScheme.onSurface,
                ),
                child: Text(lang['name']!),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGoalsPage() {
    final colorScheme = Theme.of(context).colorScheme;
    final goals = [
      {
        'key': 'weight',
        'label': 'Weight Loss',
        'icon': Icons.monitor_weight_outlined
      },
      {
        'key': 'metabolic',
        'label': 'Metabolic Health',
        'icon': Icons.favorite_border
      },
      {
        'key': 'clarity',
        'label': 'Mental Clarity',
        'icon': Icons.psychology_outlined
      },
      {'key': 'longevity', 'label': 'Longevity', 'icon': Icons.timelapse},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'What are your goals?',
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
                      Text(
                        goal['label'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurface,
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
            'Select Fasting Plan',
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
          GradientButton(
            text: 'Continue Journey',
            onPressed: _nextPage,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPlanPage() {
    final colorScheme = Theme.of(context).colorScheme;
    List<FastingPlan> recommendedPlans;

    switch (_selectedExperience) {
      case 'Beginner':
        recommendedPlans = fastingPlans.sublist(0, 3);
        break;
      case 'Intermediate':
        recommendedPlans = fastingPlans.sublist(2, 5);
        break;
      case 'Advanced':
        recommendedPlans = fastingPlans.sublist(3, 6);
        break;
      default:
        recommendedPlans = fastingPlans.sublist(0, 3);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'Recommended Plan',
            style: GoogleFonts.lexend(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          ...recommendedPlans.map((plan) {
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
                    color:
                        isSelected ? colorScheme.primary : Colors.transparent,
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
                            plan.nameKey,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            plan.difficultyKey,
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
          }),
          const SizedBox(height: 40),
          GradientButton(
            text: 'Select this Plan',
            onPressed: _selectedPlan != null ? _completeOnboarding : () {},
          ),
        ],
      ),
    );
  }
}
