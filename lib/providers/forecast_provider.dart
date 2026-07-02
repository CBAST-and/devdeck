import 'package:flutter/material.dart';
import '../core/enums/view_state.dart';
import '../core/network/api_client.dart';
import '../models/weather_model.dart';
import '../services/forecast_service.dart';

/// Provider de la pantalla Forecast. Carga el clima actual de
/// República Dominicana automáticamente.
class ForecastProvider extends ChangeNotifier {
  final ForecastService _service = ForecastService();

  ViewState _state = ViewState.loading;
  WeatherModel? _weather;
  String _errorMessage = '';

  ViewState get state => _state;
  WeatherModel? get weather => _weather;
  String get errorMessage => _errorMessage;

  Future<void> loadWeather() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final result = await _service.fetchWeather();
      _weather = result;
      _state = ViewState.success;
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _state = ViewState.error;
    } catch (_) {
      _errorMessage = 'Something went wrong. Please try again.';
      _state = ViewState.error;
    }

    notifyListeners();
  }
}