import 'package:flutter/material.dart';
import '../core/enums/view_state.dart';
import '../core/network/api_client.dart';
import '../models/timeline_model.dart';
import '../services/timeline_service.dart';

/// Provider de la pantalla Timeline. Controla el ciclo
/// Loading -> Success/Error/Empty al consultar un nombre.
class TimelineProvider extends ChangeNotifier {
  final TimelineService _service = TimelineService();

  ViewState _state = ViewState.empty;
  TimelineModel? _result;
  String _errorMessage = '';

  ViewState get state => _state;
  TimelineModel? get result => _result;
  String get errorMessage => _errorMessage;

  Future<void> search(String name) async {
    final trimmed = name.trim();

    if (trimmed.isEmpty) {
      _state = ViewState.empty;
      _result = null;
      notifyListeners();
      return;
    }

    _state = ViewState.loading;
    notifyListeners();

    try {
      final timeline = await _service.fetchAge(trimmed);

      if (timeline.isUnknown) {
        _result = timeline;
        _state = ViewState.empty;
      } else {
        _result = timeline;
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

  void reset() {
    _state = ViewState.empty;
    _result = null;
    notifyListeners();
  }
}