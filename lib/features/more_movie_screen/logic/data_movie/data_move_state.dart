part of 'data_move_cubit.dart';

abstract class DataMoveState {

}

final class DataMoveInitial extends DataMoveState {}

final class DataMoveLoaded extends DataMoveState {
  final List<TrendingMovieResultsModel> movies;

  DataMoveLoaded(this.movies);
}
