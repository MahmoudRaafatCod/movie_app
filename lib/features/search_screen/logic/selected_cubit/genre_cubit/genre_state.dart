part of 'genre_cubit.dart';

abstract class GenreState {}

final class GenreInitial extends GenreState {}


class GenreLoaded extends GenreState {
  final Map<int, String> genreMap;

  GenreLoaded(this.genreMap);
}