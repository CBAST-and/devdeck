import '../core/network/api_client.dart';
import '../core/constants/app_endpoints.dart';
import '../models/pokemon_model.dart';

/// Service encargado de consumir la PokeAPI.
class PokedexService {
  final ApiClient _client = ApiClient();

  Future<PokemonModel> fetchPokemon(String query) async {
    final normalizedQuery = query.trim().toLowerCase();
    final url = '${AppEndpoints.pokeApiBase}$normalizedQuery';
    final data = await _client.get(url);
    return PokemonModel.fromJson(data as Map<String, dynamic>);
  }
}