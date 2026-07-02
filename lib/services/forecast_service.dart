import '../core/network/api_client.dart';
import '../core/constants/app_endpoints.dart';
import '../models/weather_model.dart';

/// Service encargado de consumir la API de Open-Meteo.
class ForecastService {
  final ApiClient _client = ApiClient();

  Future<WeatherModel> fetchWeather() async {
    final url = '${AppEndpoints.openMeteo}'
        '?latitude=${AppEndpoints.forecastLatitude}'
        '&longitude=${AppEndpoints.forecastLongitude}'
        '&current_weather=true'
        '&hourly=relative_humidity_2m'
        '&timezone=auto';

    final data = await _client.get(url);
    return WeatherModel.fromJson(data as Map<String, dynamic>);
  }
}