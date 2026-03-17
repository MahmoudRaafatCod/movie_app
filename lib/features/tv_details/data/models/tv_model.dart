import 'package:movie/features/home_screen/data/models/genre_model.dart';
import 'package:movie/features/tv_details/data/models/seasons_tv_model.dart';

class TvShowDetailsModel {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final num voteAverage;
  final int voteCount;
  final DateTime? firstAirDate;
  final DateTime? lastAirDate;
  final bool inProduction;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final List<GenreModel> genres;
  final List<SeasonsTvModel> seasons;
  final String? homepage;
  final String status;

  TvShowDetailsModel({
    this.posterPath,
    this.backdropPath,
    this.firstAirDate,
    this.lastAirDate,
    required this.id,
    required this.name,
    required this.seasons,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.inProduction,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.genres,
    this.homepage,
    required this.status,
  });

  factory TvShowDetailsModel.fromJson(Map<String, dynamic> json) {
    return TvShowDetailsModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],

      firstAirDate: json["first_air_date"] != null ? DateTime.parse(json["first_air_date"]) : null,
      lastAirDate: json["last_air_date"] != null ? DateTime.parse(json["last_air_date"]) : null,
      inProduction: json['in_production'],
      numberOfSeasons: json['number_of_seasons'],
      numberOfEpisodes: json['number_of_episodes'],
      genres: (json['genres'] as List).map((i) => GenreModel.fromJson(i)).toList(),
      seasons: (json['seasons'] as List).map((i) => SeasonsTvModel.fromJson(i)).toList(),
      homepage: json['homepage'],
      status: json['status'],
    );
  }

}
