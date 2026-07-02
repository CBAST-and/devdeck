/// URLs base de todas las APIs consumidas por DevDeck.
/// Modificar aquí en caso de que alguna API cambie de dominio.
class AppEndpoints {
  AppEndpoints._();

  static const String genderize = 'https://api.genderize.io/';
  static const String agify = 'https://api.agify.io/';
  static const String academyProxy = 'https://adamix.net/proxy.php';
  static const String openMeteo =
      'https://api.open-meteo.com/v1/forecast';
  static const String pokeApiBase = 'https://pokeapi.co/api/v2/pokemon/';

  /// URL del sitio WordPress a consumir en Newsroom.
  static const String wordpressSite = 'https://steamdeckhq.com';
  static const String wordpressPostsEndpoint =
      '$wordpressSite/wp-json/wp/v2/posts?per_page=3&_embed';

  // Coordenadas fijas para Forecast (Santo Domingo, RD)
  static const double forecastLatitude = 18.4861;
  static const double forecastLongitude = -69.9312;
}