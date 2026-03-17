part of 'on_the_air_cubit.dart';

abstract class OnTheAirState {}

final class OnTheAirInitial extends OnTheAirState {}

final class OnTheAirSuccess extends OnTheAirState {
  List<TrendingMovieResultsModel> results;

  OnTheAirSuccess(this.results);
}

final class OnTheAirFailure extends OnTheAirState{
  String error;

  OnTheAirFailure(this.error);
}

final class OnTheAirLoading extends OnTheAirState{}

