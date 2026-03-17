
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';
import 'package:movie/features/movie_details/data/movie_details_repo.dart';

part 'similar_state.dart';

class SimilarCubit extends Cubit<SimilarState> {
  SimilarCubit(int id , String type) : super(SimilarInitial()){
    getSimilar(id , type);
  }

  void getSimilar(int id , String type){
    MovieDetailsRepo().movieSimilar(id , type).then((value) {
      emit(SimilarSuccess(value.results));
    });
  }
}
