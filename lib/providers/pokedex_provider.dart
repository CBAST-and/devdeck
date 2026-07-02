import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../core/enums/view_state.dart';
import '../core/network/api_client.dart';
import '../models/pokemon_model.dart';
import '../services/pokedex_service.dart';

/// Provider de la pantalla Pokédex. Controla el ciclo
/// Loading -> Success/Error/Empty y la reproducción del cry oficial.
class PokedexProvider extends ChangeNotifier {
  final PokedexService _service = PokedexService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  ViewState _state = ViewState.empty;
  PokemonModel? _result;
  String _errorMessage = '';
  bool _isPlayingSound = false;

  ViewState get state => _state;
  PokemonModel? get result => _result;
  String get errorMessage => _errorMessage;
  bool get isPlayingSound => _isPlayingSound;

  Future<void> search(String query) async {
    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      _state = ViewState.empty;
      _result = null;
      notifyListeners();
      return;
    }

    _state = ViewState.loading;
    notifyListeners();

    try {
      final pokemon = await _service.fetchPokemon(trimmed);
      _result = pokemon;
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

  Future<void> playCry() async {
    final cryUrl = _result?.cryUrl;
    if (cryUrl == null || _isPlayingSound) return;

    try {
      _isPlayingSound = true;
      notifyListeners();

      await _audioPlayer.play(UrlSource(cryUrl));

      _audioPlayer.onPlayerComplete.first.then((_) {
        _isPlayingSound = false;
        notifyListeners();
      });
    } catch (_) {
      _isPlayingSound = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}