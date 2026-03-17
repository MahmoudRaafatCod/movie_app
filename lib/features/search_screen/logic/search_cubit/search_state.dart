part of 'search_cubit.dart';

abstract class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  List<TrendingMovieResultsModel> searchResult;
  SearchSuccess(this.searchResult);
}

final class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}

final class SearchFiltered extends SearchState {
  SearchFiltered();
}


