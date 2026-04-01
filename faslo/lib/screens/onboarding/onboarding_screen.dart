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

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final TextEditingController _nameController = TextEditingController();
  String _selectedExperience = 'Beginner';
  final Set<String> _selectedGoals = {};
  FastingPlan? _selectedPlan;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    if (_selectedPlan == null) return;

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
                  _buildWelcomePage(),
                  _buildGoalsPage(),
                  _buildPlanPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    final colorScheme = Theme.of(context).colorScheme;
    final settingsProvider = context.watch<SettingsProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    final languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'de', 'name': 'Deutsch'},
      {'code': 'ja', 'name': '日本語'},
      {'code': 'ko', 'name': '한국어'},
      {'code': 'hi', 'name': 'हिन्दी'},
    ];

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
            'Clarity.',
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
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'PREFERRED LANGUAGE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: languages.map((lang) {
              final isSelected =
                  settingsProvider.locale.languageCode == lang['code'];
              return ChoiceChip(
                label: Text(lang['name']!),
                selected: isSelected,
                onSelected: (_) => settingsProvider.setLocale(lang['code']!),
                selectedColor: colorScheme.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : colorScheme.onSurface,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          Text(
            'CHOOSE YOUR PATH',
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
                'Zen Paper',
                AppThemeMode.zenPaper,
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
      case AppThemeMode.zenPaper:
        return const Color(0xFF3D7A5E);
      case AppThemeMode.minimalOled:
        return Colors.white;
    }
  }

  Widget _buildGoalsPage() {
    final colorScheme = Theme.of(context).colorScheme;
    final goals = [
      {'key': 'weight', 'label': 'Weight Loss'},
      {'key': 'metabolic', 'label': 'Metabolic Health'},
      {'key': 'clarity', 'label': 'Mental Clarity'},
      {'key': 'longevity', 'label': 'Longevity'},
    ];
    final experiences = ['Beginner', 'Intermediate', 'Advanced'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'What are your goals?',
            style: GoogleFonts.lexend(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: goals.map((goal) {
              final isSelected = _selectedGoals.contains(goal['key']);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedGoals.remove(goal['key']);
                    } else {
                      _selectedGoals.add(goal['key']!);
                    }
                  });
                },
                child: Container(
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
                  child: Center(
                    child: Text(
                      goal['label']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          Text(
            'Your experience?',
            style: GoogleFonts.lexend(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: experiences.map((exp) {
              final isSelected = _selectedExperience == exp;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(exp),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedExperience = exp),
                  selectedColor: colorScheme.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : colorScheme.onSurface,
                  ),
                ),
              );
            }).toList(),
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
