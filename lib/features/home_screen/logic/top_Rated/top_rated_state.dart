part of 'top_rated_cubit.dart';

abstract class TopRatedState {}

final class TopRatedInitial extends TopRatedState {}

final class TopRatedSuccess extends TopRatedState {
  List<TrendingMovieResultsModel> movies;

  TopRatedSuccess(this.movies);
}

final class TopRatedFailure extends TopRatedState {
  String error;

  TopRatedFailure(this.error);
}
