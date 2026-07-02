import 'package:flutter/material.dart';
import '../core/enums/view_state.dart';
import '../core/network/api_client.dart';
import '../models/university_model.dart';
import '../services/academy_service.dart';

/// Provider de la pantalla Academy. Controla el ciclo
/// Loading -> Success/Error/Empty al consultar un país.
class AcademyProvider extends ChangeNotifier {
  final AcademyService _service = AcademyService();

  ViewState _state = ViewState.empty;
  List<UniversityModel> _results = [];
  String _errorMessage = '';

  ViewState get state => _state;
  List<UniversityModel> get results => _results;
  String get errorMessage => _errorMessage;

  Future<void> search(String country) async {
    final trimmed = country.trim();

    if (trimmed.isEmpty) {
      _state = ViewState.empty;
      _results = [];
      notifyListeners();
      return;
    }

    _state = ViewState.loading;
    notifyListeners();

    try {
      final universities = await _service.fetchUniversities(trimmed);

      if (universities.isEmpty) {
        _results = [];
        _state = ViewState.empty;
      } else {
        _results = universities;
        _state = ViewState.success;
      }
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