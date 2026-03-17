part of 'trailer_cubit.dart';

abstract class TrailerState {}

final class TrailerInitial extends TrailerState {}

final class TrailerSuccess extends TrailerState {
  final List<TrailerResultsModel> trailers;

  TrailerSuccess(this.trailers);
}

final class TrailerError extends TrailerState {
  final String message;

  TrailerError(this.message);
}