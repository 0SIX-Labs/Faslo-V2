import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/theme_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/fast_provider.dart';
import 'providers/wellness_provider.dart';
import 'core/constants/pref_keys.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/home/home_screen.dart';
import 'widgets/clock_loading_animation.dart';

class FadeSlideTransition extends PageRouteBuilder {
  final Widget page;

  FadeSlideTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.05);
            const end = Offset.zero;
            const curve = Curves.easeOutCubic;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(tween),
                child: child,
              ),
            );
          },
        );
}

class FasloApp extends StatefulWidget {
  const FasloApp({super.key});

  @override
  State<FasloApp> createState() => _FasloAppState();
}

class _FasloAppState extends State<FasloApp> with WidgetsBindingObserver {
  bool? _onboardingDone;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkOnboarding();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Flush pending debounced saves when app is paused or detached
    // to ensure no data loss
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _flushPendingSaves();
    }
  }

  Future<void> _flushPendingSaves() async {
    try {
      final fastProvider = context.read<FastProvider>();
      final wellnessProvider = context.read<WellnessProvider>();
      await Future.wait([
        fastProvider.flushPendingSaves(),
        wellnessProvider.flushWaterSave(),
      ]);
    } catch (_) {
      // Continue even if flush fails
    }
  }

  Future<void> _checkOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance()
          .timeout(const Duration(seconds: 3));
      setState(() {
        _onboardingDone = prefs.getBool(PrefKeys.onboardingDone) ?? false;
      });
    } catch (e) {
      setState(() {
        _onboardingDone = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final settingsProvider = context.watch<SettingsProvider>();

    return MaterialApp(
      title: 'Faslo',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      locale: settingsProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
        Locale('ja'),
        Locale('ko'),
        Locale('hi'),
      ],
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOutCubic,
        child: _onboardingDone == null
            ? const Scaffold(body: Center(child: ClockLoadingAnimation()))
            : _onboardingDone!
                ? const HomeScreen()
                : const OnboardingScreen(),
      ),
    );
  }
}
