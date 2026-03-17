import 'review_model.dart';

class MovieReviewModel {
  final int id;
  final List<ReviewModel> reviews;

  MovieReviewModel({required this.id, required this.reviews});

  factory MovieReviewModel.fromJson(Map<String, dynamic> json) => MovieReviewModel(
        id: json["id"],
        reviews: List<ReviewModel>.from(
          (json["results"] as List).map((x) => ReviewModel.fromJson(x)),
        ),
      );
}
