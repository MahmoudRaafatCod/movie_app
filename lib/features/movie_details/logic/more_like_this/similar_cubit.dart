
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';
import 'package:movie/features/movie_details/data/movie_details_repo.dart';

part 'similar_state.dart';

class SimilarCubit extends Cubit<SimilarState> {
  final MovieDetailsRepo _repo;
  final int id;
  final String type;
  SimilarCubit(this._repo , {required this.id , required this.type}) : super(SimilarInitial()){
    getSimilar();
  }

  void getSimilar(){
    _repo.movieSimilar(id , type).then((value) {
      emit(SimilarSuccess(value.results));
    });
  }
}
