import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/movie_details/data/models/movie_review_model.dart';
import 'package:movie/features/movie_details/data/movie_details_repo.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final MovieDetailsRepo _repo;
  final int id;
  final String type;
  ReviewCubit(this._repo , {required this.id , required this.type}) : super(ReviewInitial()){
    getReview();

  }

  void getReview(){
    _repo.movieReview(id , type).then((value) {
      emit(ReviewSuccess(value));
    });
  }
}
