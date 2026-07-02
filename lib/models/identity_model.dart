/// Modelo de datos de la API genderize.io.
class IdentityModel {
  final String name;
  final String? gender;
  final double? probability;
  final int count;

  IdentityModel({
    required this.name,
    required this.gender,
    required this.probability,
    required this.count,
  });

  factory IdentityModel.fromJson(Map<String, dynamic> json) {
    return IdentityModel(
      name: json['name'] as String? ?? '',
      gender: json['gender'] as String?,
      probability: (json['probability'] as num?)?.toDouble(),
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }

  bool get isUnknown => gender == null;
  bool get isMale => gender == 'male';
  bool get isFemale => gender == 'female';
}