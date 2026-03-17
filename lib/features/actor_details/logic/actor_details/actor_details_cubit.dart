
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/actor_details/data/actor_repo.dart';
import 'package:movie/features/actor_details/data/models/actor_details_model.dart';

part 'actor_details_state.dart';

class ActorDetailsCubit extends Cubit<ActorDetailsState> {
  ActorDetailsCubit(int id) : super(ActorDetailsInitial()){
    getActorDetails(id);
  }

  void getActorDetails(int id) async {
    emit(ActorDetailsLoading());
    ActorRepo().getActorDetails(id).then((value) {
      if (value is ActorDetailsModel) {
        emit(ActorDetailsLoaded(value));
      } else {
        emit(ActorDetailsError(value.toString()));
      }
    });
    }
}
