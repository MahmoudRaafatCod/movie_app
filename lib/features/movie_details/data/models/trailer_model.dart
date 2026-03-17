import 'package:movie/features/movie_details/data/models/trailer_results_model.dart';

class TrailerModel {
  int id;
  List<TrailerResultsModel> results;

  TrailerModel({
    required this.id,
    required this.results,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      id: json["id"],
      results: List<TrailerResultsModel>.from(
        json["results"].map((x) => TrailerResultsModel.fromJson(x)),
      ),
    );
  }
}