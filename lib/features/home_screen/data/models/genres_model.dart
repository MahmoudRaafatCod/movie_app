import 'package:movie/features/home_screen/data/models/genre_model.dart';

class GenresModel {
  final List<GenreModel> genres;

  GenresModel({required this.genres});

  factory GenresModel.fromJson(Map<String, dynamic> json) => GenresModel(
        genres: List<GenreModel>.from(
          json["genres"].map((x) => GenreModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "genres": genres.map((e) => e.toJson()).toList(),
  };

  Map<int, String> toMap() => {for (var g in genres) g.id: g.name};
}
