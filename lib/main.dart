import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neurocare_app/config/dependency_injection.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/core/localization/app_localizations.dart';
import 'package:neurocare_app/core/routes/app_router.dart';
import 'package:neurocare_app/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize dependency injection
  await configureDependencies();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(
    const ProviderScope(
      child: NeuroCareApp(),
    ),
  );
}

class NeuroCareApp extends StatelessWidget {
  const NeuroCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      locale: const Locale('ar', ''), // Force Arabic locale for RTL
      supportedLocales: const [
        Locale('ar', ''), // Arabic (RTL)
        Locale('en', ''), // English (LTR) - for fallback
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // Always return Arabic locale for RTL support
        return const Locale('ar', '');
      },
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // Force RTL layout for Arabic
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler:
                  const TextScaler.linear(1.0), // Prevent system font scaling
            ),
            child: child!,
          ),
        );
      },
    );
  }
}
