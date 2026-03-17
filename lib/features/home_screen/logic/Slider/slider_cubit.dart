
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  final HomeRepo _repo;
  SliderCubit(this._repo) : super(SliderSuccess([])){
    getSlider();
  }

  void getSlider() {
    _repo.trendingSlider("day").then((value) {
      if(value is TrendingMovieModel){
      emit(SliderSuccess(value.results));
      } else {
        emit(SliderFailure(value));
      }
    });
  }
}
