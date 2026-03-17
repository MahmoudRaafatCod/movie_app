
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

part 'popular_tv_state.dart';

class PopularTvCubit extends Cubit<PopularTvState> {
  final HomeRepo _repo;
  PopularTvCubit(this._repo) : super(PopularTvInitial()){
    getPopularTv();
  }

  void getPopularTv() {
    _repo.tvShow("popular").then((value) {
      if(value is TrendingMovieModel){
      emit(PopularTvSuccess(value.results));
      } else {
        emit(PopularTvFailure(value));
      }
    });
  }
}
