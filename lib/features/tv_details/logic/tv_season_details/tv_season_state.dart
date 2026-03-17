part of 'tv_season_cubit.dart';

abstract class TvSeasonState {}

final class TvSeasonInitial extends TvSeasonState {}

final class TvSeasonLoading extends TvSeasonState{}

final class TvSeasonSuccess extends TvSeasonState{
  final SeasonDetailsModel data;
  TvSeasonSuccess(this.data);
}

final class TvSeasonError extends TvSeasonState{
  final String message;
  TvSeasonError(this.message);
}


