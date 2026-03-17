import 'package:movie/features/home_screen/data/models/genre_model.dart';

class MovieDetailsModel {
  final String title;
  final String overview;
  final int runtime;
  final num voteAverage;
  final DateTime releaseDate;
  final String backdropPath;
  final String posterPath;
  final List<GenreModel> genres;

  MovieDetailsModel({
    required this.title,
    required this.overview,
    required this.runtime,
    required this.voteAverage,
    required this.releaseDate,
    required this.backdropPath,
    required this.posterPath,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) => MovieDetailsModel(
    title: json["title"],
    overview: json["overview"],
    runtime: json["runtime"],
    voteAverage: json["vote_average"],
    releaseDate: DateTime.parse(json['release_date'] ),
    backdropPath: json["backdrop_path"] ,
    posterPath: json["poster_path"],
    genres: List<GenreModel>.from(
      (json["genres"] as List).map((x) => GenreModel.fromJson(x)),
    ),
  );
}
