import 'package:movie/core/network/api_service.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
import 'package:movie/features/movie_details/data/models/movie_cast_model.dart';
import 'package:movie/features/movie_details/data/models/movie_details_model.dart';
import 'package:movie/features/movie_details/data/models/movie_review_model.dart';
import 'package:movie/features/movie_details/data/models/trailer_model.dart';

class MovieDetailsRepo {

  Future<dynamic> movieDetails(int id) async{
    try{
      final res = await ApiService.dio.get("/movie/$id");
      MovieDetailsModel model = MovieDetailsModel.fromJson(res.data);
      return model;
    }catch(e){
      return e.toString();
    }

  }

  Future<MovieCastModel> movieCast(int id , String type) async{
    final res = await ApiService.dio.get("/$type/$id/credits");
        MovieCastModel model = MovieCastModel.fromJson(res.data);
    return model;
  }

  Future<dynamic> movieTrailer(int id , String type) async{
    try {
      final res = await ApiService.dio.get("/$type/$id/videos");
      TrailerModel model = TrailerModel.fromJson(res.data);
      return model;
    } catch (e) {
      return e.toString();
    }
  }

  Future<TrendingMovieModel> movieSimilar(int id , String type) async{
    final res = await ApiService.dio.get("/$type/$id/similar");
        TrendingMovieModel model = TrendingMovieModel.fromJson(res.data);
    return model;
  }
  
  Future<MovieReviewModel> movieReview(int id , String type) async{
    final res = await ApiService.dio.get("/$type/$id/reviews");
        MovieReviewModel model = MovieReviewModel.fromJson(res.data);
    return model;
  }
}