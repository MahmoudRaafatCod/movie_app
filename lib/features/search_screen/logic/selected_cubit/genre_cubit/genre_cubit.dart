
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/local_storage/local_storage_app.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';

part 'genre_state.dart';

class GenreCubit extends Cubit<GenreState> {
  final HomeRepo _repo;
  GenreCubit(this._repo) : super(GenreInitial()){
    getGenres();
  }

  int? selectedGenreId;

  void selectGenre(int id) {
    selectedGenreId = id;
    getGenres();
  }
  void getGenres() {
    if (LocalStorageApp.currentGenres != null) {
      emit(GenreLoaded({for (var item in LocalStorageApp.currentGenres!.genres) item.id: item.name}));
    }
    _repo.genres().then((value) {
      emit(GenreLoaded({for (var item in value.genres) item.id: item.name}));
    });
  }
}
