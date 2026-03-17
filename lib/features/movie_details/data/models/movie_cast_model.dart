import 'cast_model.dart';

class MovieCastModel {
  final int id;
  final List<CastModel> cast;

  MovieCastModel({required this.id, required this.cast});

  factory MovieCastModel.fromJson(Map<String, dynamic> json) => MovieCastModel(
        id: json["id"],
        cast: List<CastModel>.from(
          json["cast"].map((x) => CastModel.fromJson(x)),
        ),
      );
}
