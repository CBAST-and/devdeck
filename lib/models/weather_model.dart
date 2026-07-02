import 'package:flutter/material.dart';

/// Modelo de datos del clima actual, obtenido de Open-Meteo.
class WeatherModel {
  final double temperature;
  final double windSpeed;
  final int humidity;
  final int weatherCode;
  final DateTime date;

  WeatherModel({
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.weatherCode,
    required this.date,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current_weather'] as Map<String, dynamic>;
    final hourly = json['hourly'] as Map<String, dynamic>?;

    int humidityValue = 0;
    if (hourly != null) {
      final times = hourly['time'] as List<dynamic>?;
      final humidities = hourly['relative_humidity_2m'] as List<dynamic>?;
      final currentTime = current['time'] as String;

      if (times != null && humidities != null) {
        final index = times.indexOf(currentTime);
        if (index != -1 && index < humidities.length) {
          humidityValue = (humidities[index] as num).toInt();
        }
      }
    }

    return WeatherModel(
      temperature: (current['temperature'] as num).toDouble(),
      windSpeed: (current['windspeed'] as num).toDouble(),
      humidity: humidityValue,
      weatherCode: (current['weathercode'] as num).toInt(),
      date: DateTime.parse(current['time'] as String),
    );
  }

  /// Descripción legible del código de clima de Open-Meteo (WMO).
  String get description {
    if (weatherCode == 0) return 'Clear sky';
    if (weatherCode <= 2) return 'Partly cloudy';
    if (weatherCode == 3) return 'Overcast';
    if (weatherCode <= 48) return 'Foggy';
    if (weatherCode <= 57) return 'Drizzle';
    if (weatherCode <= 67) return 'Rain';
    if (weatherCode <= 77) return 'Snow';
    if (weatherCode <= 82) return 'Rain showers';
    if (weatherCode <= 86) return 'Snow showers';
    if (weatherCode <= 99) return 'Thunderstorm';
    return 'Unknown';
  }

  IconData get icon {
    if (weatherCode == 0) return Icons.wb_sunny_rounded;
    if (weatherCode <= 2) return Icons.wb_cloudy_rounded;
    if (weatherCode == 3) return Icons.cloud_rounded;
    if (weatherCode <= 48) return Icons.foggy;
    if (weatherCode <= 67) return Icons.grain_rounded;
    if (weatherCode <= 77) return Icons.ac_unit_rounded;
    if (weatherCode <= 86) return Icons.snowing;
    if (weatherCode <= 99) return Icons.thunderstorm_rounded;
    return Icons.cloud_rounded;
  }
}