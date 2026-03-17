part of 'actor_images_cubit.dart';

abstract class ActorImagesState {}

final class ActorImagesInitial extends ActorImagesState {}

final class ActorImagesLoading extends ActorImagesState{}

final class ActorImagesSuccess extends ActorImagesState{
  final ActorImagesModel data;

  ActorImagesSuccess(this.data);
}

final class ActorImagesError extends ActorImagesState{
  final String message;

  ActorImagesError(this.message);
}
