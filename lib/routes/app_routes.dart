import 'package:flutter/material.dart';
import '../animations/page_transitions.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/identity/identity_screen.dart';
import '../screens/timeline/timeline_screen.dart';
import '../screens/academy/academy_screen.dart';
import '../screens/forecast/forecast_screen.dart';
import '../screens/pokedex/pokedex_screen.dart';
import '../screens/newsroom/newsroom_screen.dart';
import '../screens/contact/contact_screen.dart';

/// Tabla centralizada de rutas de DevDeck. Toda navegación en la app
/// debe usar los nombres definidos aquí, nunca construir rutas
/// directamente desde una screen.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String dashboard = '/dashboard';
  static const String identity = '/identity';
  static const String timeline = '/timeline';
  static const String academy = '/academy';
  static const String forecast = '/forecast';
  static const String pokedex = '/pokedex';
  static const String newsroom = '/newsroom';
  static const String contact = '/contact';

  /// Generador de rutas usado por MaterialApp.onGenerateRoute.
  /// Aplica la transición adecuada según la ruta destino.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return PageTransitions.fade(const SplashScreen());

      case dashboard:
        return PageTransitions.fade(const DashboardScreen());

      case identity:
        return PageTransitions.fadeSlide(const IdentityScreen());

      case timeline:
        return PageTransitions.fadeSlide(const TimelineScreen());

      case academy:
        return PageTransitions.fadeSlide(const AcademyScreen());

      case forecast:
        return PageTransitions.fadeSlide(const ForecastScreen());

      case pokedex:
        return PageTransitions.fadeSlide(const PokedexScreen());

      case newsroom:
        return PageTransitions.fadeSlide(const NewsroomScreen());

      case contact:
        return PageTransitions.fadeSlide(const ContactScreen());

      default:
        return PageTransitions.fade(
          Scaffold(
            body: Center(
              child: Text('Route "${settings.name}" not found'),
            ),
          ),
        );
    }
  }
}