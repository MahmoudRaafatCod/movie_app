
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

part 'trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  final HomeRepo _repo;
  TrendingCubit(this._repo) : super(TrendingInitial()){
    getTrending();
  }

  void getTrending() {
    _repo.trendingData("popular").then((value) {
      if(value is TrendingMovieModel){
      emit(TrendingSuccess(value.results));
      } else {
        emit(TrendingFailure(value));
      }
    });
  }
}
