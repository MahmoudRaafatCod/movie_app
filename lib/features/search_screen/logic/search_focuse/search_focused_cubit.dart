
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFocusedCubit extends Cubit<bool> {
  SearchFocusedCubit() : super(false);

  void setFocus(bool isFocused) => emit(isFocused);
}
