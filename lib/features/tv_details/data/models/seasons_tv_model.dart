class SeasonsTvModel {
  final DateTime? airDate;
  final String name;
  final String? posterPath;
  final int seasonNumber , episodeCount;
  final double voteAverage;

  SeasonsTvModel({
    this.airDate,
    this.posterPath,
    required this.name,
    required this.seasonNumber,
    required this.episodeCount,
    required this.voteAverage,
  });

  factory SeasonsTvModel.fromJson(Map<String, dynamic> json) {
    return SeasonsTvModel(
      airDate: json["air_date"] != null ? DateTime.parse(json["air_date"]) : null,
      posterPath: json['poster_path'],
      name: json['name'],
      seasonNumber: json['season_number'],
      episodeCount: json['episode_count'],
      voteAverage: json['vote_average'],
    );
  }
}