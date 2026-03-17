class SavedMovieModel {
  int id;
  String title;
  String mediaType;
  String posterPath;
  num? voteAverage;

  SavedMovieModel({
    required this.id,
    required this.title,
    required this.mediaType,
    required this.posterPath,
    required this.voteAverage,
  });

  factory SavedMovieModel.fromMap(Map<String, dynamic> map) => SavedMovieModel(
    id: map["id"],
    title: map["title"],
    mediaType: map["media_type"],
    posterPath: map["poster_path"],
    voteAverage: map["vote_average"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "media_type": mediaType,
    "poster_path": posterPath,
    "vote_average": voteAverage,
  };
}