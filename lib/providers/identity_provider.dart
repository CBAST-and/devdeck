import 'package:flutter/material.dart';
import '../core/enums/view_state.dart';
import '../core/network/api_client.dart';
import '../models/identity_model.dart';
import '../services/identity_service.dart';

/// Provider de la pantalla Identity. Controla el ciclo
/// Loading -> Success/Error/Empty al consultar un nombre.
class IdentityProvider extends ChangeNotifier {
  final IdentityService _service = IdentityService();

  ViewState _state = ViewState.empty;
  IdentityModel? _result;
  String _errorMessage = '';

  ViewState get state => _state;
  IdentityModel? get result => _result;
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
      final identity = await _service.fetchIdentity(trimmed);

      if (identity.isUnknown) {
        _result = identity;
        _state = ViewState.empty;
      } else {
        _result = identity;
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