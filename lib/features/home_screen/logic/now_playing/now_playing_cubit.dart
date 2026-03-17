
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final HomeRepo _repo;
  NowPlayingCubit(this._repo) : super(NowPlayingInitial()){
    getNowPlaying();
  }

  void getNowPlaying() {
    _repo.trendingData("now_playing").then((value) {
      if(value is TrendingMovieModel){
      emit(NowPlayingSuccess(value.results));
      } else {
        emit(NowPlayingFailure(value));
      }
    });
  }
}
