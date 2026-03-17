import 'package:flutter/material.dart';
import 'package:movie/core/constants/extensions/assets.dart';


ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle( fontWeight: FontWeight.bold , fontSize: 20 , fontFamily: Assets.cairoFont),
  ),
  primaryColor: Color(0xffe21220),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Color(0xffe21220)),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xff191a1f),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle( fontWeight: FontWeight.bold , fontSize: 20),
  ),
  primaryColor: Color(0xffe21220),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Color(0xffe21220)),
);
