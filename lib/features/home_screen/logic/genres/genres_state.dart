part of 'genres_cubit.dart';


abstract class GenresState {}

final class GenresInitial extends GenresState {}

class GenreLoaded extends GenresState {
  final Map<int, String> genreMap;
  GenreLoaded(this.genreMap);
}

class GenreError extends GenresState {
  final String error;
  GenreError(this.error);
}

class GenreLoading extends GenresState {}
