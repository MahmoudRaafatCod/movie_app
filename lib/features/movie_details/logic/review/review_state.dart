part of 'review_cubit.dart';

abstract class ReviewState {}

final class ReviewInitial extends ReviewState {}
final class ReviewSuccess extends ReviewState {
  final MovieReviewModel model;

  ReviewSuccess(this.model);
}
