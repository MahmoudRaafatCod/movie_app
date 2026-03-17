import 'package:bingo/bingo.dart';
import 'package:movie/features/home_screen/data/models/genres_model.dart';

class LocalStorageApp {
  static void setGenres(GenresModel genres) {
    Bingo.mark('genres', genres);
  }

  static GenresModel? get currentGenres =>
      Bingo.call<GenresModel>('genres');


  static void setTheme(String themeMode) {
    Bingo.mark('themeModes', themeMode);
  }

  static String? get currentTheme =>
      Bingo.call<String>('themeModes');
}
