import 'package:movie/core/network/api_consumer.dart';
import 'package:movie/features/tv_details/data/models/season_details_model.dart';
import 'package:movie/features/tv_details/data/models/tv_model.dart';

class TvDetailsRepo {
  final ApiConsumer _api;
  TvDetailsRepo(this._api);

  Future<dynamic> getTvShowDetails(int tvShowId) async {
    try {
      final response = await _api.get("/tv/$tvShowId");
      return TvShowDetailsModel.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getTvShowSeasons(int tvShowId , int seasonNumber) async {
    try {
      final response = await _api.get("/tv/$tvShowId/season/$seasonNumber");
      return SeasonDetailsModel.fromJson(response);
      } catch (e) {
      return e.toString();
    }
  }
}
