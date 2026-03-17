
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/movie_details/data/models/cast_model.dart';
import 'package:movie/features/movie_details/data/movie_details_repo.dart';

part 'caste_details_state.dart';

class CasteDetailsCubit extends Cubit<CasteDetailsState> {
  CasteDetailsCubit(int id , String type) : super(CasteDetailsInitial()){
    getCastDetails(id , type);
  }

  void getCastDetails(int id , String type){
    MovieDetailsRepo().movieCast(id , type).then((value) {
      emit(CasteDetailsSuccess(value.cast));
    });
  }
}
