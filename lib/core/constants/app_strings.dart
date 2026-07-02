/// Textos estáticos utilizados en toda la aplicación.
class AppStrings {
  AppStrings._();

  // App general
  static const String appName = 'DevDeck';
  static const String appSlogan = 'Every card unlocks a new tool.';

  // Splash
  static const String tapToDraw = 'Tap to Draw';

  // Dashboard - nombres de cartas
  static const String cardIdentity = 'Identity';
  static const String cardTimeline = 'Timeline';
  static const String cardAcademy = 'Academy';
  static const String cardForecast = 'Forecast';
  static const String cardPokedex = 'Pokédex';
  static const String cardNewsroom = 'Newsroom';
  static const String cardContact = 'Contact';

  // Dashboard - descripciones cortas
  static const String descIdentity = 'Discover gender by name';
  static const String descTimeline = 'Predict age by name';
  static const String descAcademy = 'Find universities worldwide';
  static const String descForecast = 'Live weather in DR';
  static const String descPokedex = 'Explore the Pokémon world';
  static const String descNewsroom = 'Latest news, curated';
  static const String descContact = 'About the developer';

  // Estados genéricos
  static const String loadingMessage = 'Loading...';
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'No connection. Check your internet.';
  static const String emptyGeneric = 'No results found.';
  static const String retry = 'Retry';
  static const String visit = 'Visit';
  static const String search = 'Search';

  // Identity
  static const String identityHint = 'Enter a name';
  static const String identityGender = 'Gender';
  static const String identityProbability = 'Probability';
  static const String identityUnknownLabel = 'Unable to determine';

  // Timeline
  static const String timelineHint = 'Enter a name';
  static const String timelineAge = 'Estimated Age';
  static const String timelineChild = 'Child';
  static const String timelineYoung = 'Young';
  static const String timelineAdult = 'Adult';
  static const String timelineElder = 'Elder';

  // Academy
  static const String academyHint = 'Enter a country (in English)';

  // Forecast
  static const String forecastLocation = 'Dominican Republic';
  static const String forecastHumidity = 'Humidity';
  static const String forecastWind = 'Wind';

  // Pokédex
  static const String pokedexHint = 'Enter a Pokémon name or ID';
  static const String pokedexBaseExperience = 'Base Experience';
  static const String pokedexHeight = 'Height';
  static const String pokedexWeight = 'Weight';
  static const String pokedexTypes = 'Types';
  static const String pokedexAbilities = 'Abilities';

  // Newsroom
  static const String newsroomTitle = 'Latest Articles';

  // Contact
  static const String contactName = 'Sebastian Pilier Mercedes';
  static const String contactId = '2024-0132';
  static const String contactEmail = '20240132@itla.edu.do';
  static const String contactPhone = '849-654-0946';
  static const String contactGithub = 'https://github.com/CBAST-and/';
  static const String contactLinkedin =
      'https://www.linkedin.com/in/sebastian-pilier-mercedes-3827a23aa';
  static const String contactDescription =
      'Software Development Technology student at ITLA, focused on mobile '
      ', web development and UI/UX design.';
}