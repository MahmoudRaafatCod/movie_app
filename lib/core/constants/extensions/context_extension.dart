import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/constants/extensions/assets.dart';

extension ContextExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isEnglish => locale.languageCode == 'en';

  Size get screenSize => MediaQuery.of(this).size;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get navBarColor => isDark 
      ? const Color(0xff1C1C23).withValues(alpha: 0.9)
      : Colors.white.withValues(alpha:0.9);

  Color get navBarUnselectedColor =>
      isDark ? Colors.grey[600]! : Colors.grey[400]!;

  Color get shadowColor => isDark
      ? Colors.black.withValues(alpha: 0.3)
      : Colors.black.withValues(alpha: 0.05);

  Color get textColor => isDark ? Colors.white : Colors.black;

  Color get searchColor => isDark ? Color(0xff1f222b) : Color(0xfff5f5f5);

  Color get appBarColor => isDark ? const Color(0xff191a1f) : Colors.white;

  Color get buttonColor => isDark ? Color(0xff363940) : primaryColor.withAlpha(50);

  Color get textButtonColor => isDark ? Colors.white : primaryColor;

  String get imagesError => isDark ? Assets.errorDark : Assets.error;
}
