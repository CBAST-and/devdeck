import 'dart:convert';
import 'package:http/http.dart' as http;

/// Excepción genérica lanzada por el ApiClient ante fallos de red
/// o respuestas no exitosas del servidor.
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

/// Cliente HTTP centralizado. Todos los Services deben usar esta
/// clase en lugar de llamar `http` directamente, para mantener
/// un único punto de manejo de errores y timeouts.
class ApiClient {
  static const Duration _timeout = Duration(seconds: 12);

  Future<dynamic> get(String url) async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      }

      if (response.statusCode == 404) {
        throw ApiException('Resource not found.');
      }

      throw ApiException('Server error (${response.statusCode}).');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('No connection. Check your internet.');
    }
  }
}