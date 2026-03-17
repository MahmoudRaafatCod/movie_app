import 'package:movie/features/tv_details/data/models/tv_model.dart';

abstract class TvDetailsState {}

class TvDetailsInitial extends TvDetailsState {}

class TvDetailsLoading extends TvDetailsState {}

class TvDetailsSuccess extends TvDetailsState {
  final TvShowDetailsModel tvShow;
  TvDetailsSuccess(this.tvShow);
}

class TvDetailsError extends TvDetailsState {
  final String message;
  TvDetailsError(this.message);
}
