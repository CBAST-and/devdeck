import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_dimens.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/deck_card.dart';

/// Modelo interno (solo de presentación) para cada carta del dashboard.
class _DeckItem {
  final String title;
  final String description;
  final IconData icon;
  final String route;

  const _DeckItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
  });
}

/// Pantalla principal (Dashboard) de DevDeck. Muestra las 7 cartas
/// de herramientas. No contiene lógica de negocio: solo navegación.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const List<_DeckItem> _items = [
    _DeckItem(
      title: AppStrings.cardIdentity,
      description: AppStrings.descIdentity,
      icon: Icons.badge_outlined,
      route: AppRoutes.identity,
    ),
    _DeckItem(
      title: AppStrings.cardTimeline,
      description: AppStrings.descTimeline,
      icon: Icons.hourglass_bottom_rounded,
      route: AppRoutes.timeline,
    ),
    _DeckItem(
      title: AppStrings.cardAcademy,
      description: AppStrings.descAcademy,
      icon: Icons.school_outlined,
      route: AppRoutes.academy,
    ),
    _DeckItem(
      title: AppStrings.cardForecast,
      description: AppStrings.descForecast,
      icon: Icons.cloud_outlined,
      route: AppRoutes.forecast,
    ),
    _DeckItem(
      title: AppStrings.cardPokedex,
      description: AppStrings.descPokedex,
      icon: Icons.catching_pokemon_rounded,
      route: AppRoutes.pokedex,
    ),
    _DeckItem(
      title: AppStrings.cardNewsroom,
      description: AppStrings.descNewsroom,
      icon: Icons.newspaper_outlined,
      route: AppRoutes.newsroom,
    ),
    _DeckItem(
      title: AppStrings.cardContact,
      description: AppStrings.descContact,
      icon: Icons.person_outline_rounded,
      route: AppRoutes.contact,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: AppStrings.appName),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spaceM),
          child: GridView.builder(
            itemCount: _items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimens.spaceM,
              mainAxisSpacing: AppDimens.spaceM,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final item = _items[index];
              return DeckCard(
                onTap: () => Navigator.of(context).pushNamed(item.route),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppDimens.spaceS),
                      decoration: BoxDecoration(
                        color: AppColors.electricBlue.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(AppDimens.radiusS),
                      ),
                      child: Icon(
                        item.icon,
                        color: AppColors.electricBlue,
                        size: AppDimens.cardIconSize,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: AppTextStyles.cardTitle),
                        const SizedBox(height: AppDimens.spaceXS),
                        Text(
                          item.description,
                          style: AppTextStyles.cardSubtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}