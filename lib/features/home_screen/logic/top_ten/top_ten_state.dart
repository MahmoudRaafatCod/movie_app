part of 'top_ten_cubit.dart';

abstract class TopTenState {}

final class TopTenLoading extends TopTenState {}
final class TopTenSuccess extends TopTenState {
  List<TrendingMovieResultsModel> movies;

  TopTenSuccess(this.movies);

}

final class TopTenFailure extends TopTenState {
  String error;

  TopTenFailure(this.error);
}