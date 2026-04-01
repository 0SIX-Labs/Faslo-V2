import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/theme/theme_provider.dart';
import 'providers/fast_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/wellness_provider.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
