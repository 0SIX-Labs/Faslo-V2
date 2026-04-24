import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/theme/theme_provider.dart';
import 'core/utils/data_pruning.dart';
import 'providers/fast_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/wellness_provider.dart';
import 'services/notification_service.dart';
import 'models/fast_session.dart';
import 'models/water_entry.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Declare providers in outer scope so they are available after try/catch
  ThemeProvider themeProvider = ThemeProvider();
  SettingsProvider settingsProvider = SettingsProvider();
  FastProvider fastProvider = FastProvider();
  WellnessProvider wellnessProvider = WellnessProvider();

  try {
    // Initialize Hive with timeout protection
    await Hive.initFlutter().timeout(const Duration(seconds: 5));
    Hive.registerAdapter(FastSessionAdapter());
    Hive.registerAdapter(WaterEntryAdapter());

    await Future.wait([
      Hive.openBox<FastSession>('fast_sessions')
          .timeout(const Duration(seconds: 3)),
      Hive.openBox<int>('water_entries').timeout(const Duration(seconds: 3)),
    ]).timeout(const Duration(seconds: 5));

    // Initialize notifications with fallback
    try {
      await NotificationService.init().timeout(const Duration(seconds: 4));
    } catch (e) {
      // Continue even if notifications fail to initialize
      debugPrint('Notification init failed: $e');
    }

    // Lock portrait
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).timeout(const Duration(seconds: 2));

    await Future.wait([
      themeProvider.init(),
      settingsProvider.init(),
      fastProvider.init(),
      wellnessProvider.init(),
    ]).timeout(const Duration(seconds: 8), onTimeout: () => []);

    // Prune old data (runs at most once per day)
    try {
      DataPruning.pruneIfNeeded();
    } catch (e) {
      debugPrint('Data pruning failed: $e');
    }
  } catch (e, stackTrace) {
    debugPrint('CRITICAL INIT ERROR: $e');
    debugPrint('Stack trace: $stackTrace');
    // Continue execution even if something breaks - at least app will open
  }

  // Always run the app regardless of init issues
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: settingsProvider),
        ChangeNotifierProvider.value(value: fastProvider),
        ChangeNotifierProvider.value(value: wellnessProvider),
      ],
      child: const FasloApp(),
    ),
  );
}
