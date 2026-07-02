import '../core/network/api_client.dart';
import '../core/constants/app_endpoints.dart';
import '../models/timeline_model.dart';

/// Service encargado de consumir la API agify.io.
class TimelineService {
  final ApiClient _client = ApiClient();

  Future<TimelineModel> fetchAge(String name) async {
    final url = '${AppEndpoints.agify}?name=$name';
    final data = await _client.get(url);
    return TimelineModel.fromJson(data as Map<String, dynamic>);
  }
}