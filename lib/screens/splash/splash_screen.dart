import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_dimens.dart';
import '../../routes/app_routes.dart';
import '../../animations/card_draw_animation.dart';
import '../../animations/page_transitions.dart';

/// Pantalla de bienvenida de DevDeck. Muestra el logo, la carta
/// interactiva y el slogan. Al tocar la carta se dispara la animación
/// y, al completarse, navega al Dashboard.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isNavigating = false;

  void _goToDashboard() {
    if (_isNavigating) return;
    _isNavigating = true;

    Navigator.of(context).pushReplacement(
      PageTransitions.fade(const _DashboardRedirect()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.logo,
                width: 72,
                height: 72,
              ),
              const SizedBox(height: AppDimens.spaceM),
              Text(AppStrings.appName, style: AppTextStyles.splashTitle),
              const SizedBox(height: AppDimens.spaceS),
              Text(
                AppStrings.appSlogan,
                style: AppTextStyles.splashSubtitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.spaceXXL),
              CardDrawAnimation(onAnimationComplete: _goToDashboard),
              const SizedBox(height: AppDimens.spaceXL),
              Text(
                AppStrings.tapToDraw,
                style: AppTextStyles.splashSubtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget puente que redirige inmediatamente a la ruta nombrada del
/// Dashboard. Se usa para que la navegación siga pasando por
/// [AppRoutes] (con su transición ya definida) en lugar de construir
/// el Dashboard directamente aquí.
class _DashboardRedirect extends StatelessWidget {
  const _DashboardRedirect();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
    });
    return const Scaffold(backgroundColor: AppColors.background);
  }
}