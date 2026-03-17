part of 'episode_details_cubit.dart';

abstract class EpisodeDetailsState {}

final class EpisodeDetailsInitial extends EpisodeDetailsState {}

final class EpisodeDetailsSuccess extends EpisodeDetailsState {
  final TvEpisodeDetailsModel data;

  EpisodeDetailsSuccess(this.data);
}

final class EpisodeDetailsError extends EpisodeDetailsState{
  final String message;

  EpisodeDetailsError(this.message);
}

final class EpisodeDetailsLoading extends EpisodeDetailsState {}

