part of 'slider_cubit.dart';

abstract class SliderState {}

final class SliderSuccess extends SliderState {
  List<TrendingMovieResultsModel> results;

  SliderSuccess(this.results);
}

final class SliderFailure extends SliderState {
  String error;

  SliderFailure(this.error);
}


