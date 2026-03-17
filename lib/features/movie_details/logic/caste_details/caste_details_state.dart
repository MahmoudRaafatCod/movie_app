part of 'caste_details_cubit.dart';

abstract class CasteDetailsState {}

final class CasteDetailsInitial extends CasteDetailsState {}

final class CasteDetailsSuccess extends CasteDetailsState {
  List<CastModel> cast;

  CasteDetailsSuccess(this.cast);
}
