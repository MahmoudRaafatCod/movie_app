part of 'upcoming_cubit.dart';

abstract class UpcomingState {}

final class UpcomingInitial extends UpcomingState {}

final class UpcomingSuccess extends UpcomingState {
  List<TrendingMovieResultsModel> movies;

  UpcomingSuccess(this.movies);
}

final class UpcomingFailure extends UpcomingState {
  String error;

  UpcomingFailure(this.error);
}