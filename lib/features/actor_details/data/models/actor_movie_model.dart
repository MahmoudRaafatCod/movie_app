
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

class ActorMovieModel {
  List<TrendingMovieResultsModel> cast;

  ActorMovieModel({required this.cast});

  factory ActorMovieModel.fromJson(Map<String, dynamic> json) => ActorMovieModel(
    cast: List<TrendingMovieResultsModel>.from(json["cast"].map((x) => TrendingMovieResultsModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
  };

}