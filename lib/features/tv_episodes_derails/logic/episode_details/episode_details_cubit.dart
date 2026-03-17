
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/tv_episodes_derails/data/models/tv_episode_details_model.dart';
import 'package:movie/features/tv_episodes_derails/data/tv_episodes_details_repo.dart';

part 'episode_details_state.dart';

class EpisodeDetailsCubit extends Cubit<EpisodeDetailsState> {
  EpisodeDetailsCubit() : super(EpisodeDetailsInitial());

  void getEpisodeDetails(int tvShowId , int seasonNumber , int episodeNumber) {
    emit(EpisodeDetailsLoading());
    TvEpisodesDerailsRepo().getTvShowEpisodeDetails(tvShowId, seasonNumber, episodeNumber).then((value) {
      if(value is TvEpisodeDetailsModel) {
        emit(EpisodeDetailsSuccess(value));
      } else {
        emit(EpisodeDetailsError(value.toString()));
      }
    });
  }
}
