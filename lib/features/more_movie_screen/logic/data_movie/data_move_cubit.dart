
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';
import 'package:movie/features/more_movie_screen/data/models/more_movie_args.dart';

part 'data_move_state.dart';

class DataMoveCubit extends Cubit<DataMoveState> {
  final HomeRepo _repo;
  final MoreMovieArgs args;

  DataMoveCubit( this._repo , {required this.args}) : super(DataMoveInitial()){
    getDataMove();
  }


  String get name => args.title;

  int currentPage = 1;
  bool isLoading = false;
  List<TrendingMovieResultsModel> allMovies = [];

  void getDataMove() {
    if (isLoading) return;
    isLoading = true;
    if (args.isTopTen) {
      _repo.trendingSlider(args.category , page: currentPage).then((value) {
        allMovies.addAll(value.results);
        emit(DataMoveLoaded(allMovies));
        isLoading = false;
      });
    }if(args.isTVShow){
      _repo.tvShow(args.category , page: currentPage).then((value) {
        allMovies.addAll(value.results);
        emit(DataMoveLoaded(allMovies));
        isLoading = false;
      });
    } else{
      _repo.trendingData(args.category , page: currentPage).then((value) {
        allMovies.addAll(value.results);
        emit(DataMoveLoaded(allMovies));
        isLoading = false;
      });
    }

  }

  void loadMore() {
    currentPage++;
    getDataMove();
  }

}
