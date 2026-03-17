import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_results_model.dart';
import 'package:movie/features/search_screen/data/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _repo;

  SearchCubit(this._repo) : super(SearchInitial()) {
    getTrending();
  }

  TextEditingController searchController = TextEditingController();

  void toggleGenre(int id) {
    if (genreId.contains(id)) {
      genreId.remove(id);
    } else {
      genreId.add(id);
    }
  }

  void resetGenres() {
    genreId.clear();
  }

  void setLanguage(String? newLang) => language = newLang;

  void setType(String? newType) => type = newType;

  void setSortBy(String? newSort) => sortBy = newSort;

  void setYear(int? newYear) => year = newYear;

  List<int> genreId = [];
  String? language;
  int? year;
  String? type;
  String? sortBy;

  void filter() {
    _repo
        .filterSearch(
          genreId,
          language,
          year,
          type ?? "movie",
          sortBy ?? "popularity.desc",
        )
        .then((value) {
          emit(SearchSuccess(value.results));
        });
  }

  void getTrending() {
    if (searchController.text.isEmpty) {
      _repo.getTrending().then((value) {
        emit(SearchSuccess(value.results));
      });
    } else if (type != null) {
      filter();
    } else {
      search();
    }
  }

  void search() {
    emit(SearchLoading());
    _repo.search(searchController.text).then((value) {
      if (value is List<TrendingMovieResultsModel>) {
        emit(SearchSuccess(value));
      } else {
        emit(SearchError(value));
      }
    });
  }
}
