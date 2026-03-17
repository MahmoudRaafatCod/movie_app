
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TranslationCubit extends Cubit<Locale> {
  TranslationCubit() : super(const Locale("en"));

  void toggleLanguage(BuildContext context) {
    if (state.languageCode == "en") {
      context.setLocale(const Locale("ar"));
      emit(const Locale("ar"));
    } else {
      context.setLocale(const Locale("en"));
      emit(const Locale("en"));
    }
  }
}
