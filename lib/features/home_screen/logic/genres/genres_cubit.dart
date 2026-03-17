import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';

part 'genres_state.dart';

class GenresCubit extends Cubit<GenresState> {
  final HomeRepo _repo;
  GenresCubit(this._repo) : super(GenresInitial()) {
    getGenres();
  }


  void getGenres() {
    _repo.genres().then((value) {
      emit(GenreLoaded({for (var item in value.genres) item.id: item.name}));
    });
  }
}
