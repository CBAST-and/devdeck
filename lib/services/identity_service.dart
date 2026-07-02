import '../core/network/api_client.dart';
import '../core/constants/app_endpoints.dart';
import '../models/identity_model.dart';

/// Service encargado de consumir la API genderize.io.
class IdentityService {
  final ApiClient _client = ApiClient();

  Future<IdentityModel> fetchIdentity(String name) async {
    final url = '${AppEndpoints.genderize}?name=$name';
    final data = await _client.get(url);
    return IdentityModel.fromJson(data as Map<String, dynamic>);
  }
}