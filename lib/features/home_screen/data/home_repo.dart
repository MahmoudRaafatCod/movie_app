import 'package:movie/core/constants/local_storage/local_storage_app.dart';
import 'package:movie/core/network/api_consumer.dart';
import 'package:movie/features/home_screen/data/models/genres_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';

class HomeRepo {
  final ApiConsumer _api;
  HomeRepo(this._api);


  Future<dynamic> trendingSlider(String region, {int page = 1}) async {
    try {
      final res = await _api.get(
        "/trending/movie/$region",
        queryParams: {"page": page},
      );
      TrendingMovieModel model = TrendingMovieModel.fromJson(res);
      return model;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> trendingData(String url, {int page = 1}) async {
    try {
      final res = await _api.get(
        "/movie/$url",
        queryParams: {"page": page},
      );
      TrendingMovieModel model = TrendingMovieModel.fromJson(res);
      return model;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> tvShow(String url, {int page = 1}) async {
    try {
      final res = await _api.get(
        "/tv/$url",
        queryParams: {"page": page},
      );
      TrendingMovieModel model = TrendingMovieModel.fromJson(res);
      return model;
    } catch (e) {
      return e.toString();
    }
  }


  Future<dynamic> genres() async {
    try {
      if (LocalStorageApp.currentGenres != null) {
        return LocalStorageApp.currentGenres!;
      } else {
        final res = await _api.get("/genre/movie/list");
        GenresModel model = GenresModel.fromJson(res);
        LocalStorageApp.setGenres(model);
        return model;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
