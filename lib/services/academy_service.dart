import '../core/network/api_client.dart';
import '../core/constants/app_endpoints.dart';
import '../models/university_model.dart';

/// Service encargado de consumir el proxy de Academy (adamix.net).
class AcademyService {
  final ApiClient _client = ApiClient();

  Future<List<UniversityModel>> fetchUniversities(String country) async {
    final url = '${AppEndpoints.academyProxy}?country=$country';
    final data = await _client.get(url);

    if (data is! List) return [];

    return data
        .whereType<Map<String, dynamic>>()
        .map((json) => UniversityModel.fromJson(json))
        .toList();
  }
}