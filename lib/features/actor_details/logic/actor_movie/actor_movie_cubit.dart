import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/actor_details/data/actor_repo.dart';
import 'package:movie/features/actor_details/data/models/actor_movie_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

part 'actor_movie_state.dart';

class ActorMovieCubit extends Cubit<ActorMovieState> {
  ActorMovieCubit(int id) : super(ActorMovieInitial()){
    getActorMovies(id);
  }


  void getActorMovies(int id) async {
    emit(ActorMovieLoading());
    ActorRepo().getActorMovies(id).then((value) {
      if (value is ActorMovieModel) {
        emit(ActorMovieSuccess(value.cast));
      } else {
        emit(ActorMovieError(value.toString()));
      }
    });
  }
}
