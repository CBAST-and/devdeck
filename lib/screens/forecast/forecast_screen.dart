import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/enums/view_state.dart';
import '../../core/utils/date_formatter.dart';
import '../../models/weather_model.dart';
import '../../providers/forecast_provider.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_card.dart';
import '../../widgets/deck_card.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ForecastProvider>().loadWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: AppStrings.cardForecast),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spaceM),
          child: Consumer<ForecastProvider>(
            builder: (context, provider, _) {
              switch (provider.state) {
                case ViewState.loading:
                  return const LoadingIndicator();

                case ViewState.error:
                  return ErrorCard(
                    message: provider.errorMessage,
                    onRetry: () => provider.loadWeather(),
                  );

                case ViewState.empty:
                  return const LoadingIndicator();

                case ViewState.success:
                  final WeatherModel weather = provider.weather!;
                  return _WeatherContent(weather: weather);
              }
            },
          ),
        ),
      ),
    );
  }
}

class _WeatherContent extends StatelessWidget {
  final WeatherModel weather;

  const _WeatherContent({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppStrings.forecastLocation, style: AppTextStyles.bodyTextSecondary),
        const SizedBox(height: AppDimens.spaceXS),
        Text(
          DateFormatter.fullDate(weather.date),
          style: AppTextStyles.bodyTextSecondary,
        ),
        const SizedBox(height: AppDimens.spaceXL),
        Icon(weather.icon, size: 96, color: AppColors.electricBlue),
        const SizedBox(height: AppDimens.spaceM),
        Text(
          '${weather.temperature.toStringAsFixed(0)}°C',
          style: AppTextStyles.splashTitle.copyWith(fontSize: 48),
        ),
        const SizedBox(height: AppDimens.spaceXS),
        Text(weather.description, style: AppTextStyles.bodyText),
        const SizedBox(height: AppDimens.spaceXL),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.water_drop_outlined,
                label: AppStrings.forecastHumidity,
                value: '${weather.humidity}%',
              ),
            ),
            const SizedBox(width: AppDimens.spaceM),
            Expanded(
              child: _StatCard(
                icon: Icons.air_rounded,
                label: AppStrings.forecastWind,
                value: '${weather.windSpeed.toStringAsFixed(0)} km/h',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DeckCard(
      padding: const EdgeInsets.all(AppDimens.spaceM),
      child: Column(
        children: [
          Icon(icon, color: AppColors.electricBlue, size: 24),
          const SizedBox(height: AppDimens.spaceS),
          Text(value, style: AppTextStyles.statValue),
          const SizedBox(height: AppDimens.spaceXS),
          Text(label, style: AppTextStyles.statLabel),
        ],
      ),
    );
  }
}