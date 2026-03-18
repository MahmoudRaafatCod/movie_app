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

  Future<void> loadInstallment({String? type}) async {
    if (type != null) {
      selectedType = type;
    }

    final allMovies = await _db.getMovies();
    final bool moviesExist = allMovies.any((m) => m.mediaType == "movie");
    final bool tvExist = allMovies.any((m) => m.mediaType == "tv");

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

    List<SavedMovieModel> displayedMovies;
    if (selectedType == "movie") {
      displayedMovies = allMovies.where((m) => m.mediaType == "movie").toList();
    } else if (selectedType == "tv") {
      displayedMovies = allMovies.where((m) => m.mediaType == "tv").toList();
    } else {
      displayedMovies = allMovies;
    }

    movies = allMovies;
    emit(SavedMoviesLoaded(
      displayedMovies,
      hasMovies: moviesExist,
      hasTv: tvExist,
      selectedType: selectedType,
    ));
  }


  void toggleMovie(SavedMovieModel movie) async {
    final exist = movies.any((e) => e.id == movie.id);

    if (exist) {
      await _db.deleteMovie(movie.id);
    } else {
      await _db.createMovie(movie);
    }
    
    await loadInstallment();
  }


  bool isSaved(int id) {
    return movies.any((movie) => movie.id == id);
  }

  void clearMovies() async {
    await _db.clearMovies();
    movies.clear();
    selectedType = "";
    emit(SavedMoviesLoaded([], hasMovies: false, hasTv: false,selectedType: ""));
  }
}
