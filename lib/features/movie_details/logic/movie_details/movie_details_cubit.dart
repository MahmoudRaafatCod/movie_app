
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/movie_details/data/models/movie_details_model.dart';
import 'package:movie/features/movie_details/data/movie_details_repo.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsRepo _repo;
  final int id;
  MovieDetailsCubit(this._repo , {required this.id}) : super(MovieDetailsInitial()) {
    getMovieDetails();
  }


  void getMovieDetails() {
    _repo.movieDetails(id).then((value) {
      emit(MovieDetailsSuccess(value));
    });
  }
}
