import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/local_storage/local_storage_app.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_getInitialTheme());

  static ThemeMode _getInitialTheme() {
    final theme = LocalStorageApp.currentTheme;
    if (theme == 'ThemeMode.light') {
      return ThemeMode.light;
    }

    return ThemeMode.dark;
  }

  void toggleTheme() {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(newTheme);
    LocalStorageApp.setTheme(newTheme.toString());
  }

  bool get isDark => state == ThemeMode.dark;
}
