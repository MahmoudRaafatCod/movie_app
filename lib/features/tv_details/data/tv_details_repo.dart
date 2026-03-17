import 'package:movie/core/network/api_service.dart';
import 'package:movie/features/tv_details/data/models/season_details_model.dart';
import 'package:movie/features/tv_details/data/models/tv_model.dart';

class TvDetailsRepo {
  Future<dynamic> getTvShowDetails(int tvShowId) async {
    try {
      final response = await ApiService.dio.get("/tv/$tvShowId");
      return TvShowDetailsModel.fromJson(response.data);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getTvShowSeasons(int tvShowId , int seasonNumber) async {
    try {
      final response = await ApiService.dio.get("/tv/$tvShowId/season/$seasonNumber");
      return SeasonDetailsModel.fromJson(response.data);
      } catch (e) {
      return e.toString();
    }
  }
}
