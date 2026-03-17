import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/movie_details/data/models/movie_review_model.dart';
import 'package:movie/features/movie_details/data/movie_details_repo.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(int id , String type) : super(ReviewInitial()){
    getReview(id , type);

  }

  void getReview(int id , String type){
    MovieDetailsRepo().movieReview(id , type).then((value) {
      emit(ReviewSuccess(value));
    });
  }
}
