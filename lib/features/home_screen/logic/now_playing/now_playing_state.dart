part of 'now_playing_cubit.dart';

abstract class NowPlayingState {}

final class NowPlayingInitial extends NowPlayingState {}

final class NowPlayingSuccess extends NowPlayingState {
  List<TrendingMovieResultsModel> movies;

  NowPlayingSuccess(this.movies);

}

final class NowPlayingFailure extends NowPlayingState {
  String error;

  NowPlayingFailure(this.error);
}
