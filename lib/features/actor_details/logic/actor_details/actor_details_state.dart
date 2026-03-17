part of 'actor_details_cubit.dart';

abstract class ActorDetailsState {}

final class ActorDetailsInitial extends ActorDetailsState {}

final class ActorDetailsLoading extends ActorDetailsState{}

final class ActorDetailsLoaded extends ActorDetailsState{
  final ActorDetailsModel data;
  ActorDetailsLoaded(this.data);
}

final class ActorDetailsError extends ActorDetailsState{
  final String message;
  ActorDetailsError(this.message);
}