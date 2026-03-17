part of 'saved_movies_cubit.dart';

abstract class SavedMoviesState {}

class SavedMoviesInitial extends SavedMoviesState {}

class SavedMoviesLoading extends SavedMoviesState {}

class SavedMoviesLoaded extends SavedMoviesState {
  final List<SavedMovieModel> movies;
  final bool hasMovies;
  final bool hasTv;
  final String? selectedType;

  SavedMoviesLoaded(
      this.movies, {
        required this.hasMovies,
        required this.hasTv,
        this.selectedType,
      });
}

class SavedMoviesError extends SavedMoviesState {
  final String message;

  SavedMoviesError(this.message);
}
