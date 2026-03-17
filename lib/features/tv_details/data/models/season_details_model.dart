import 'package:movie/features/tv_details/data/models/episode_model.dart';

class SeasonDetailsModel {

  final List<EpisodeModel> episodes;


  SeasonDetailsModel({
    required this.episodes,

  });

  factory SeasonDetailsModel.fromJson(Map<String, dynamic> json) {
    return SeasonDetailsModel(
      episodes: (json['episodes'] as List).map((i) => EpisodeModel.fromJson(i)).toList(),
    );
  }
}
