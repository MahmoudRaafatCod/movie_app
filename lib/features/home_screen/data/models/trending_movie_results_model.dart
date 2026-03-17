class TrendingMovieResultsModel {
  String? posterPath , mediaType , title;
  int id;
  List<int>? genreIds;
  num voteAverage;
  DateTime? releaseDate;

  TrendingMovieResultsModel({
    required this.id,
    required this.title,
    required this.genreIds,
    required this.mediaType,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory TrendingMovieResultsModel.fromJson(Map<String, dynamic> json) => TrendingMovieResultsModel(
    id: json["id"],
    title: json["title"] ?? json["name"],
    mediaType: json["media_type"],
    posterPath: json["poster_path"],
    releaseDate: (json["release_date"] != null &&
        json["release_date"].toString().isNotEmpty)
        ? DateTime.tryParse(json["release_date"])
        : (json["first_air_date"] != null &&
        json["first_air_date"].toString().isNotEmpty)
        ? DateTime.tryParse(json["first_air_date"])
        : null,
    voteAverage: json["vote_average"],
    genreIds: json["genre_ids"] != null ? List<int>.from(json["genre_ids"]) : [],
  );

  String genreNames(Map<int, String> genreMap) {
    if (genreIds == null) return "";
    return genreIds!.map((id) => genreMap[id] ?? "Unknown").join(", ");
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "media_type": mediaType,
    "poster_path": posterPath,
    "vote_average": voteAverage,
  };
}