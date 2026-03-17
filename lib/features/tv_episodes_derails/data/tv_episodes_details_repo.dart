import 'package:movie/core/network/api_service.dart';
import 'package:movie/features/tv_episodes_derails/data/models/tv_episode_details_model.dart';

class TvEpisodesDerailsRepo {

  Future<dynamic> getTvShowEpisodeDetails(int tvShowId , int seasonNumber , int episodeNumber) async {
    try {
      final response = await ApiService.dio.get("/tv/$tvShowId/season/$seasonNumber/episode/$episodeNumber");
      return TvEpisodeDetailsModel.fromJson(response.data);
    } catch (e) {
      return e.toString();
    }
  }
}