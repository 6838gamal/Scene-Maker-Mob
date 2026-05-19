import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'providers/locale_provider.dart';
import 'providers/project_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
      ],
      child: const SceneMakerApp(),
    ),
  );
}

class SceneMakerApp extends StatelessWidget {
  const SceneMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    final isArabic = localeProvider.isArabic;

    return MaterialApp(
      title: 'Scene Maker',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.flutterThemeMode,
      theme: AppTheme.light().copyWith(textTheme: AppTheme.textTheme(isArabic)),
      darkTheme: AppTheme.dark().copyWith(textTheme: AppTheme.textTheme(isArabic)),
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
    );
  }
}
