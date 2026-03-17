
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/movie_details/data/models/trailer_results_model.dart';
import 'package:movie/features/movie_details/data/movie_details_repo.dart';

part 'trailer_state.dart';

class TrailerCubit extends Cubit<TrailerState> {
  TrailerCubit(int id , String type) : super(TrailerInitial()){
    getTrailer(id , type);
  }

  void getTrailer(int id , String type){
    MovieDetailsRepo().movieTrailer(id , type).then((value) {
      // if(value is TrailerResponseModel) {
      emit(TrailerSuccess(value.results));
      // } else {
      //   emit(TrailerError(value.toString()));
      // }
    });
  }
}
