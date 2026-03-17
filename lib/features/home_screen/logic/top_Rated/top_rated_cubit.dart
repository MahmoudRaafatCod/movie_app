
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  final HomeRepo _repo;
  TopRatedCubit(this._repo) : super(TopRatedInitial()){
    getTopRated();
  }

  void getTopRated() {
    _repo.trendingData("top_rated").then((value) {
      if(value is TrendingMovieModel){
      emit(TopRatedSuccess(value.results));
      } else {
        emit(TopRatedFailure(value));
      }
    });
  }
}
