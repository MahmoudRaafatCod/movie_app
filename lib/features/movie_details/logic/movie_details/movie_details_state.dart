part of 'movie_details_cubit.dart';

abstract class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}
final class MovieDetailsLoading extends MovieDetailsState {}

final class MovieDetailsSuccess extends MovieDetailsState {
   MovieDetailsModel movie;

  MovieDetailsSuccess(this.movie);

}

class MovieDetailsError extends MovieDetailsState {
  final String message;
  MovieDetailsError(this.message);
}

