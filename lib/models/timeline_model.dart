/// Categorías de edad soportadas por Timeline.
enum AgeCategory { child, young, adult, elder }

/// Modelo de datos de la API agify.io. La categoría no viene de la
/// API: se deriva localmente a partir de la edad devuelta.
class TimelineModel {
  final String name;
  final int? age;
  final int count;

  TimelineModel({
    required this.name,
    required this.age,
    required this.count,
  });

  factory TimelineModel.fromJson(Map<String, dynamic> json) {
    return TimelineModel(
      name: json['name'] as String? ?? '',
      age: (json['age'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }

  bool get isUnknown => age == null;

  AgeCategory get category {
    final a = age ?? 0;
    if (a <= 12) return AgeCategory.child;
    if (a <= 25) return AgeCategory.young;
    if (a <= 59) return AgeCategory.adult;
    return AgeCategory.elder;
  }
}