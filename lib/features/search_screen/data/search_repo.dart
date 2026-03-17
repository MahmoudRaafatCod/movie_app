import 'package:movie/core/network/api_consumer.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

class SearchRepo {
  final ApiConsumer _api;
  SearchRepo(this._api);

  Future<dynamic> getTrending() async {
    try {
      final res = await _api.get("/trending/all/day");
      TrendingMovieModel model = TrendingMovieModel.fromJson(res);
      return model;
    } catch (error) {
      return error.toString();
    }
  }

  Future<dynamic> search(String query) async {
    try {
      final res = await _api.get("/search/multi",
        queryParams: {"query": query, "language": "en-US",
          "page": 1,},
      );
      final results = (res["results"] as List)
          .where((e) => e["media_type"] == "movie" || e["media_type"] == "tv")
          .map((e) => TrendingMovieResultsModel.fromJson(e))
          .toList();
      return results;
    } catch (error) {
      return error.toString();
    }
  }

  Future<dynamic> filterSearch(List<int>? genreId, String? language, int? year,
      String? type, String sortBy) async {
    try {
      final res = await _api.get("/discover/$type",
          queryParams: {
            "page": 1,
            "sort_by": sortBy,
            if (genreId != null) "with_genres": genreId.join(','),
            if (language != null && language != "all") "language": language,
            if (year != null && year != 0) "year": year,
          }
      );
      TrendingMovieModel model = TrendingMovieModel.fromJson(res);
      return model;
    } catch (error) {
      return error.toString();
    }
  }
}