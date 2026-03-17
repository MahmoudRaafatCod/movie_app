class ActorDetailsModel {
  String biography , knownForDepartment , name , placeOfBirth , profilePath;
  int id;
  DateTime? birthday , deathday;
  List<String> alsoKnownAs;

  ActorDetailsModel({
    required this.biography,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.profilePath,
    required this.id,
    required this.birthday,
    required this.deathday,
    required this.alsoKnownAs,
  });

  factory ActorDetailsModel.fromJson(Map<String, dynamic> json) {
    return ActorDetailsModel(
      biography: json['biography'],
      knownForDepartment : json['known_for_department'],
      name : json['name'],
      placeOfBirth : json['place_of_birth'],
      profilePath : json['profile_path'],
      id : json['id'],
      birthday: json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      deathday: json['deathday'] != null ? DateTime.parse(json['deathday']) : null,
      alsoKnownAs: List<String>.from(json['also_known_as']),
    );
  }

}