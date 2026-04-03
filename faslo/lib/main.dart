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

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(FastSessionAdapter());
  Hive.registerAdapter(WaterEntryAdapter());
  await Hive.openBox<FastSession>('fast_sessions');
  await Hive.openBox<WaterEntry>('water_entries');

  await NotificationService.init();

  // Lock portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Init providers
  final themeProvider = ThemeProvider();
  final settingsProvider = SettingsProvider();
  final fastProvider = FastProvider();
  final wellnessProvider = WellnessProvider();

  await Future.wait([
    themeProvider.init(),
    settingsProvider.init(),
    fastProvider.init(),
    wellnessProvider.init(),
  ]);

  // Prune old data (runs at most once per day)
  DataPruning.pruneIfNeeded();

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
