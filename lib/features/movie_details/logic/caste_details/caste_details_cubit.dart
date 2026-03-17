
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/movie_details/data/models/cast_model.dart';
import 'package:movie/features/movie_details/data/movie_details_repo.dart';

part 'caste_details_state.dart';

class CasteDetailsCubit extends Cubit<CasteDetailsState> {
  final MovieDetailsRepo _repo;
  final int id;
  final String type;
  CasteDetailsCubit(this._repo , {required this.id , required this.type}) : super(CasteDetailsInitial()){
    getCastDetails();
  }

  int get movieId => id;


  void getCastDetails(){
    _repo.movieCast(id , type).then((value) {
      emit(CasteDetailsSuccess(value.cast));
    });
  }
}
