class CastModel {
  final int id;
  final String name;
  final String knownForDepartment;
  final String? profilePath;

  CastModel({
    required this.id,
    required this.name,
    required this.knownForDepartment,
    this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        id: json["id"],
        name: json["name"],
        knownForDepartment: json["known_for_department"],
        profilePath: json["profile_path"],
      );
}
