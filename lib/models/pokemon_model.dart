/// Representa un tipo elemental del Pokémon (ej. "fire", "water").
class PokemonType {
  final String name;

  PokemonType({required this.name});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    final typeData = json['type'] as Map<String, dynamic>;
    return PokemonType(name: typeData['name'] as String);
  }
}

/// Representa una habilidad del Pokémon.
class PokemonAbility {
  final String name;

  PokemonAbility({required this.name});

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    final abilityData = json['ability'] as Map<String, dynamic>;
    return PokemonAbility(name: abilityData['name'] as String);
  }
}

/// Modelo completo de un Pokémon, obtenido de pokeapi.co.
class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final int baseExperience;
  final int height;
  final int weight;
  final List<PokemonType> types;
  final List<PokemonAbility> abilities;
  final String? cryUrl;

  PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.cryUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>;
    final otherSprites = sprites['other'] as Map<String, dynamic>?;
    final officialArtwork =
        otherSprites?['official-artwork'] as Map<String, dynamic>?;

    final typesJson = json['types'] as List<dynamic>;
    final abilitiesJson = json['abilities'] as List<dynamic>;

    final cries = json['cries'] as Map<String, dynamic>?;

    return PokemonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: (officialArtwork?['front_default'] as String?) ??
          (sprites['front_default'] as String? ?? ''),
      baseExperience: json['base_experience'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      weight: json['weight'] as int? ?? 0,
      types: typesJson
          .whereType<Map<String, dynamic>>()
          .map((t) => PokemonType.fromJson(t))
          .toList(),
      abilities: abilitiesJson
          .whereType<Map<String, dynamic>>()
          .map((a) => PokemonAbility.fromJson(a))
          .toList(),
      cryUrl: cries?['latest'] as String?,
    );
  }

  /// Altura convertida a metros (la API la entrega en decímetros).
  double get heightInMeters => height / 10;

  /// Peso convertido a kilogramos (la API lo entrega en hectogramos).
  double get weightInKg => weight / 10;
}