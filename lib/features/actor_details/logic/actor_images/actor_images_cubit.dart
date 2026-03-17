import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/actor_details/data/actor_repo.dart';
import 'package:movie/features/actor_details/data/models/actor_images_model.dart';

part 'actor_images_state.dart';

class ActorImagesCubit extends Cubit<ActorImagesState> {
  final ActorRepo _repo;
  final int id;
  ActorImagesCubit(this._repo , {required this.id}) : super(ActorImagesInitial()){
    getActorImages();
  }
  
  void getActorImages() async {
    emit(ActorImagesLoading());
    _repo.getActorImages(id).then((value) {
      if (value is ActorImagesModel) {
        emit(ActorImagesSuccess(value));
      } else {
        emit(ActorImagesError(value.toString()));
      }
    });
  }
}
