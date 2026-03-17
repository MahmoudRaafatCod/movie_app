
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/local_storage/local_storage_app.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark){
    loadTheme();
  }

  void toggleTheme() {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(newTheme);
    LocalStorageApp.setTheme(newTheme.toString());
    print(LocalStorageApp.currentTheme);
  }

  void loadTheme() {
    final theme = LocalStorageApp.currentTheme;
    print(theme);
    if (theme != null) {
      emit(theme == 'ThemeMode.dark' ? ThemeMode.dark : ThemeMode.light);
    }
  }

  bool get isDark => state == ThemeMode.dark;

}
