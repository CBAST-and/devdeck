/// Modelo de una universidad devuelta por la API de Academy.
class UniversityModel {
  final String name;
  final String domain;
  final String website;

  UniversityModel({
    required this.name,
    required this.domain,
    required this.website,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    final domains = json['domains'] as List<dynamic>?;
    final webPages = json['web_pages'] as List<dynamic>?;

    return UniversityModel(
      name: json['name'] as String? ?? 'Unknown University',
      domain: (domains != null && domains.isNotEmpty) ? domains.first as String : '-',
      website: (webPages != null && webPages.isNotEmpty) ? webPages.first as String : '',
    );
  }
}