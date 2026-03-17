
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/tv_details/data/models/season_details_model.dart';
import 'package:movie/features/tv_details/data/tv_details_repo.dart';

part 'tv_season_state.dart';

class TvSeasonCubit extends Cubit<TvSeasonState> {
  final TvDetailsRepo _repo;
  final int id;
  TvSeasonCubit(this._repo , {required this.id} ) : super(TvSeasonInitial()){
    getTvShowSeasonDetails();
  }

  int selectedSeason = 1;

  void selectSeason(int seasonNumber) {
    selectedSeason = seasonNumber;
    getTvShowSeasonDetails();
  }


  void getTvShowSeasonDetails()  {
    _repo.getTvShowSeasons(id , selectedSeason).then((value) {
      if(value is SeasonDetailsModel){
        emit(TvSeasonSuccess(value));
      }else{
        emit(TvSeasonError(value));
      }
    });
    }
  }

