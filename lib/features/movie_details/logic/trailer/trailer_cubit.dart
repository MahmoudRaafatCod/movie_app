
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/movie_details/data/models/trailer_results_model.dart';
import 'package:movie/features/movie_details/data/movie_details_repo.dart';

part 'trailer_state.dart';

class TrailerCubit extends Cubit<TrailerState> {
  final MovieDetailsRepo _repo;
  final int id;
  final String type;
  TrailerCubit(this._repo , {required this.id , required this.type}) : super(TrailerInitial()){
    getTrailer();
  }

  void getTrailer(){
    _repo.movieTrailer(id , type).then((value) {
      // if(value is TrailerResponseModel) {
      emit(TrailerSuccess(value.results));
      // } else {
      //   emit(TrailerError(value.toString()));
      // }
    });
  }
}
