
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  final HomeRepo _repo;
  UpcomingCubit(this._repo) : super(UpcomingInitial()){
    getUpcoming();
  }

  void getUpcoming() {
    _repo.trendingData("upcoming").then((value) {
      if(value is TrendingMovieModel){
      emit(UpcomingSuccess(value.results));
      }else{
        emit(UpcomingFailure(value));
      }
    });
  }
}
