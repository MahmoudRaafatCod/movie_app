part of 'popular_tv_cubit.dart';

abstract class PopularTvState {}

final class PopularTvInitial extends PopularTvState {}

final class PopularTvSuccess extends PopularTvState {
  final List<TrendingMovieResultsModel> movies;

  PopularTvSuccess(this.movies);
}

final class PopularTvFailure extends PopularTvState {
  final String error;

  PopularTvFailure(this.error);
}

final class PopularTvLoading extends PopularTvState {}

