
import 'package:flutter_bloc/flutter_bloc.dart';

class SortCubit extends Cubit<List<Map<String, String>>> {
  SortCubit() : super([]){
    generateSort();
  }

  String selectedSort = "most_popular";

  void selectSort(String sort) {
    selectedSort = sort;
    generateSort();
  }

  void generateSort() {
    final List<Map<String, String>> sortOptions = [
      {"name": "most_popular", "code": "popularity.desc"},
      {"name": "least_popular", "code": "popularity.asc"},
      {"name": "newest_first", "code": "release_date.desc"},
      {"name": "oldest_first", "code": "release_date.asc"},
      {"name": "highest_rated", "code": "vote_average.desc"},
      {"name": "lowest_rated", "code": "vote_average.asc"},
      {"name": "most_votes", "code": "vote_count.desc"},
      {"name": "fewest_votes", "code": "vote_count.asc"}
    ];

    emit(sortOptions);
  }
}
