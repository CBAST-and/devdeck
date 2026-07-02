/// Modelo de un artículo obtenido de la API REST de WordPress.
class ArticleModel {
  final int id;
  final String title;
  final String excerpt;
  final String imageUrl;
  final String link;

  ArticleModel({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.imageUrl,
    required this.link,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final titleData = json['title'] as Map<String, dynamic>?;
    final excerptData = json['excerpt'] as Map<String, dynamic>?;
    final embedded = json['_embedded'] as Map<String, dynamic>?;

    String extractedImage = '';
    if (embedded != null) {
      final featuredMediaList = embedded['wp:featuredmedia'] as List<dynamic>?;
      if (featuredMediaList != null && featuredMediaList.isNotEmpty) {
        final media = featuredMediaList.first as Map<String, dynamic>;
        extractedImage = media['source_url'] as String? ?? '';
      }
    }

    return ArticleModel(
      id: json['id'] as int,
      title: _stripHtml(titleData?['rendered'] as String? ?? ''),
      excerpt: _stripHtml(excerptData?['rendered'] as String? ?? ''),
      imageUrl: extractedImage,
      link: json['link'] as String? ?? '',
    );
  }

  /// Elimina etiquetas HTML básicas que WordPress incluye en
  /// title.rendered y excerpt.rendered (ej. <p>, </p>, &hellip;).
  static String _stripHtml(String htmlText) {
    return htmlText
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&hellip;', '...')
        .replaceAll('&#8217;', '\'')
        .replaceAll('&#8211;', '-')
        .replaceAll('&amp;', '&')
        .trim();
  }
}

/// Modelo del sitio WordPress (nombre y logo), obtenido del endpoint
/// raíz de la API REST (/wp-json).
class SiteModel {
  final String name;
  final String? logoUrl;

  SiteModel({
    required this.name,
    required this.logoUrl,
  });

  factory SiteModel.fromJson(Map<String, dynamic> json) {
    final siteIcon = json['site_icon_url'] as String?;

    return SiteModel(
      name: json['name'] as String? ?? '',
      logoUrl: (siteIcon != null && siteIcon.isNotEmpty) ? siteIcon : null,
    );
  }
}