import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'routes/app_routes.dart';

import 'providers/identity_provider.dart';
import 'providers/timeline_provider.dart';
import 'providers/academy_provider.dart';
import 'providers/forecast_provider.dart';
import 'providers/pokedex_provider.dart';
import 'providers/newsroom_provider.dart';

void main() {
  runApp(const DevDeckApp());
}

/// Punto de entrada de DevDeck. Configura el árbol de providers,
/// el tema global y el sistema de rutas. No contiene lógica de UI.
class DevDeckApp extends StatelessWidget {
  const DevDeckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IdentityProvider()),
        ChangeNotifierProvider(create: (_) => TimelineProvider()),
        ChangeNotifierProvider(create: (_) => AcademyProvider()),
        ChangeNotifierProvider(create: (_) => ForecastProvider()),
        ChangeNotifierProvider(create: (_) => PokedexProvider()),
        ChangeNotifierProvider(create: (_) => NewsroomProvider()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}