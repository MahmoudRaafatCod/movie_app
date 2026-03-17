part of 'similar_cubit.dart';

abstract class SimilarState {}

final class SimilarInitial extends SimilarState {}

final class SimilarSuccess extends SimilarState {

  final List<TrendingMovieResultsModel> movies;

  SimilarSuccess(this.movies);
}
