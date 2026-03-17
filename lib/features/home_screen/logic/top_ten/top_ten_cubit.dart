
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';

part 'top_ten_state.dart';

class TopTenCubit extends Cubit<TopTenState> {
  final HomeRepo _repo;
  TopTenCubit(this._repo) : super(TopTenLoading()){
    getTopTen();
  }

  void getTopTen() {
    _repo.trendingSlider("week").then((value) {
      if (value is TrendingMovieModel) {
      emit(TopTenSuccess(value.results.take(10).toList()));
      } else {
        emit(TopTenFailure(value));
      }
    });
  }
}
