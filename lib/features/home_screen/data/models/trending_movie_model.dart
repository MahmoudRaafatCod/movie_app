import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

class TrendingMovieModel {
  List<TrendingMovieResultsModel> results;

  TrendingMovieModel({required this.results});

  factory TrendingMovieModel.fromJson(Map<String, dynamic> json) => TrendingMovieModel(
    results: List<TrendingMovieResultsModel>.from(json["results"].map((x) => TrendingMovieResultsModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };

}
