import 'crew_model.dart';
import 'guest_star_model.dart';

class TvEpisodeDetailsModel {
  final String? airDate;
  final List<CrewModel>? crew;
  final int? episodeNumber;
  final String? episodeType;
  final List<GuestStarModel>? guestStars;
  final String? name;
  final String? overview;
  final int? id;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;

  TvEpisodeDetailsModel({
    this.airDate,
    this.crew,
    this.episodeNumber,
    this.episodeType,
    this.guestStars,
    this.name,
    this.overview,
    this.id,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  factory TvEpisodeDetailsModel.fromJson(Map<String, dynamic> json) =>
      TvEpisodeDetailsModel(
        airDate: json["air_date"],
        crew: json["crew"] == null
            ? []
            : List<CrewModel>.from(
                json["crew"]!.map((x) => CrewModel.fromJson(x))),
        episodeNumber: json["episode_number"],
        episodeType: json["episode_type"],
        guestStars: json["guest_stars"] == null
            ? []
            : List<GuestStarModel>.from(
                json["guest_stars"]!.map((x) => GuestStarModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        id: json["id"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
}
