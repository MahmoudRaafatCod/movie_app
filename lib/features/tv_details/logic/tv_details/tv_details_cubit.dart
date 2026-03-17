import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/tv_details/data/tv_details_repo.dart';
import 'package:movie/features/tv_details/logic/tv_details/tv_details_state.dart';

class TvDetailsCubit extends Cubit<TvDetailsState> {
  TvDetailsCubit(int id) : super(TvDetailsInitial()){
    getTvShowDetails(id);
  }

  int selectedSeason = 1;

  void selectSeason(int seasonNumber) {
    selectedSeason = seasonNumber;
  }

  void getTvShowDetails(int id)  {
    emit(TvDetailsLoading());
    try {
      TvDetailsRepo().getTvShowDetails(id).then((value) {
        emit(TvDetailsSuccess(value));
      });
    } catch (e) {
      emit(TvDetailsError(e.toString()));
    }
  }
}
