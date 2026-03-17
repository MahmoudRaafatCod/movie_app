import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarScrollCubit extends Cubit<double> {
  AppBarScrollCubit() : super(0.0);

  void updateOffset(double offset) {
    emit((offset / 200).clamp(0, 1));
  }
}