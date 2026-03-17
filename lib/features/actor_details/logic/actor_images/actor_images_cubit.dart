import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/actor_details/data/actor_repo.dart';
import 'package:movie/features/actor_details/data/models/actor_images_model.dart';

part 'actor_images_state.dart';

class ActorImagesCubit extends Cubit<ActorImagesState> {
  ActorImagesCubit(int id) : super(ActorImagesInitial()){
    getActorImages(id);
  }
  
  void getActorImages(int id) async {
    emit(ActorImagesLoading());
    ActorRepo().getActorImages(id).then((value) {
      if (value is ActorImagesModel) {
        emit(ActorImagesSuccess(value));
      } else {
        emit(ActorImagesError(value.toString()));
      }
    });
  }
}
