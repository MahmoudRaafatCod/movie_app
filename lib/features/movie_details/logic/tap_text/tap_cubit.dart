
import 'package:flutter_bloc/flutter_bloc.dart';

class TapCubit extends Cubit<int> {
  TapCubit() : super(0);

  void selectTab(int index) => emit(index);
}
