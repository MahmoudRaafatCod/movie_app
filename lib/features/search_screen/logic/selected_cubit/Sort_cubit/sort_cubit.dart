
import 'package:flutter_bloc/flutter_bloc.dart';

class SortCubit extends Cubit<List<Map<String, String>>> {
  SortCubit() : super([]){
    generateSort();
  }

  String selectedSort = "Most Popular";

  void selectSort(String sort) {
    selectedSort = sort;
    generateSort();
  }

  void generateSort() {
    final List<Map<String, String>> sortOptions = [
      {"name": "Most Popular", "code": "popularity.desc"},
      {"name": "Least Popular", "code": "popularity.asc"},
      {"name": "Newest First", "code": "release_date.desc"},
      {"name": "Oldest First", "code": "release_date.asc"},
      {"name": "Highest Rated", "code": "vote_average.desc"},
      {"name": "Lowest Rated", "code": "vote_average.asc"},
      {"name": "Most Votes", "code": "vote_count.desc"},
      {"name": "Fewest Votes", "code": "vote_count.asc"},
    ];

    emit(sortOptions);
  }
}
