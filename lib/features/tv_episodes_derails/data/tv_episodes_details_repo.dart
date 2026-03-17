import 'package:movie/core/network/api_consumer.dart';
import 'package:movie/features/tv_episodes_derails/data/models/tv_episode_details_model.dart';

class TvEpisodesDerailsRepo {
  final ApiConsumer _repo;
  TvEpisodesDerailsRepo(this._repo);



  Future<dynamic> getTvShowEpisodeDetails(int tvShowId , int seasonNumber , int episodeNumber) async {
    try {
      final response = await _repo.get("/tv/$tvShowId/season/$seasonNumber/episode/$episodeNumber");
      return TvEpisodeDetailsModel.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }
}