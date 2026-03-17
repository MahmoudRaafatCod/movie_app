
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/local_storage/helpers/data_base_helper.dart';
import 'package:movie/features/movie_details/data/models/saved_movie_model.dart';

part 'saved_movies_state.dart';

class SavedMoviesCubit extends Cubit<SavedMoviesState> {
  SavedMoviesCubit() : super(SavedMoviesInitial()){
    loadInstallment();
  }

  final DataBaseHelper _db = DataBaseHelper.instance;

  List<SavedMovieModel> movies = [];
  String selectedType = "";

  void loadInstallment({String? type}) async {
    List<SavedMovieModel> data;

    if (type == null) {
      data = await _db.getMovies();
    } else {
      data = await _db.getMoviesByType(type);
    }

    final moviesExist = await _db.hasMovies();
    final tvExist = await _db.hasTv();

    if (type == null) {
      if (moviesExist && !tvExist) {
        selectedType = "movie";
      }
      else if (!moviesExist && tvExist) {
        selectedType = "tv";
      }
      else if (moviesExist && tvExist) {
        selectedType = ""; // All
      }
      else {
        selectedType = "";
      }
    }

    movies = data;
    emit(SavedMoviesLoaded(
      List.from(movies),
      hasMovies: moviesExist,
      hasTv: tvExist,
      selectedType: selectedType,
    ));
  }


  void toggleMovie(SavedMovieModel movie) async {
    final exist = movies.any((e) => e.id == movie.id);

    if (exist) {
      await _db.deleteMovie(movie.id);
      movies.removeWhere((e) => e.id == movie.id);
    } else {
      await _db.createMovie(movie);
      movies.add(movie);
    }
    final moviesExist = await _db.hasMovies();
    final tvExist = await _db.hasTv();
    emit(SavedMoviesLoaded(List.from(movies), hasMovies: moviesExist, hasTv: tvExist,selectedType: selectedType));
  }


  bool isSaved(int id) {
    return movies.any((movie) => movie.id == id);
  }

  void clearMovies() async {
    await _db.clearMovies();
    movies.clear();

    emit(SavedMoviesLoaded([], hasMovies: false, hasTv: false,selectedType: ""));
  }
}
