part of 'trending_cubit.dart';


abstract class TrendingState {}

final class TrendingInitial extends TrendingState {}
final class TrendingSuccess extends TrendingState {
  List<TrendingMovieResultsModel> movies;

  TrendingSuccess(this.movies);

}

final class TrendingFailure extends TrendingState {
  String error;

  TrendingFailure(this.error);
}