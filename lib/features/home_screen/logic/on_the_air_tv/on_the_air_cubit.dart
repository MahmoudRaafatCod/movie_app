
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

part 'on_the_air_state.dart';

class OnTheAirCubit extends Cubit<OnTheAirState> {
  final HomeRepo _repo;
  OnTheAirCubit(this._repo) : super(OnTheAirInitial()){
    getOnTheAir();
  }

  void getOnTheAir() {
    _repo.tvShow("on_the_air").then((value) {
      if(value is TrendingMovieModel){
      emit(OnTheAirSuccess(value.results));
      } else {
        emit(OnTheAirFailure(value));
      }
    });
    }
  }
