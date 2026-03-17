class EpisodeModel {
  final String?  stillPath;
  final int id , episodeNumber , seasonNumber ;
  final String  name ;

  EpisodeModel({
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.seasonNumber,
    this.stillPath,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      episodeNumber: json['episode_number'],
      id: json['id'],
      name: json['name'],
      seasonNumber: json['season_number'],
      stillPath: json['still_path'],
    );
  }
}
