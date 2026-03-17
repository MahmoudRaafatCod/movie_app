import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/tv_details/data/tv_details_repo.dart';
import 'package:movie/features/tv_details/logic/tv_details/tv_details_state.dart';

class TvDetailsCubit extends Cubit<TvDetailsState> {
  final TvDetailsRepo _repo;
  final int id;
  TvDetailsCubit(this._repo , {required this.id}) : super(TvDetailsInitial()){
    getTvShowDetails();
  }

  int selectedSeason = 1;

  void selectSeason(int seasonNumber) {
    selectedSeason = seasonNumber;
  }

  void getTvShowDetails()  {
    emit(TvDetailsLoading());
    try {
      _repo.getTvShowDetails(id).then((value) {
        emit(TvDetailsSuccess(value));
      });
    } catch (e) {
      emit(TvDetailsError(e.toString()));
    }
  }
}
