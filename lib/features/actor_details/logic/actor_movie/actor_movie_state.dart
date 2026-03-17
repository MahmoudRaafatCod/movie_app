part of 'actor_movie_cubit.dart';

abstract class ActorMovieState {}

final class ActorMovieInitial extends ActorMovieState {}

final class ActorMovieLoading extends ActorMovieState{}

final class ActorMovieSuccess extends ActorMovieState{
  final List<TrendingMovieResultsModel> data;

  ActorMovieSuccess(this.data);
}

final class ActorMovieError extends ActorMovieState{
  final String message;

  ActorMovieError(this.message);
}
