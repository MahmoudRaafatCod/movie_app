import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/data/models/trending_movie_model.dart';
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


  List<int> genreId = [];
  String? language;
  int? year;
  String type = "movie";
  String? sortBy;

  void setLanguage(String? newLang) => language = newLang;

  void setType(String newType) => type = newType;

  void setSortBy(String? newSort) => sortBy = newSort;

  void setYear(int? newYear) => year = newYear;

  void filter() {
    emit(SearchLoading());
    _repo
        .filterSearch(
          genreId,
          language,
          year,
          type,
          sortBy ?? "popularity.desc",
        )
        .then((value) {
      if (value is TrendingMovieModel) {
        emit(SearchSuccess(value.results));
      } else {
        emit(SearchError(value.toString()));
      }
    });
  }

  void getTrending() {
    if (searchController.text.isEmpty) {
      _repo.getTrending().then((value) {
        if (value is TrendingMovieModel) {
          emit(SearchSuccess(value.results));
        } else {
          emit(SearchError(value.toString()));
        }
      });
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
        emit(SearchError(value.toString()));
      }
    });
  }
}
