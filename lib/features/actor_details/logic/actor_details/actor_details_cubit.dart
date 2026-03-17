
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/actor_details/data/actor_repo.dart';
import 'package:movie/features/actor_details/data/models/actor_details_model.dart';

part 'actor_details_state.dart';

class ActorDetailsCubit extends Cubit<ActorDetailsState> {
  final ActorRepo _repo;
  final int id;
  ActorDetailsCubit(this._repo , {required this.id}) : super(ActorDetailsInitial()){
    getActorDetails();
  }

  void getActorDetails() async {
    emit(ActorDetailsLoading());
    _repo.getActorDetails(id).then((value) {
      if (value is ActorDetailsModel) {
        emit(ActorDetailsLoaded(value));
      } else {
        emit(ActorDetailsError(value.toString()));
      }
    });
    }
}
