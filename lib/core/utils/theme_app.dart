import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeApp {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColorLight,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColorLight,
        shape: StadiumBorder(side: BorderSide(width: 4, color: Colors.white))),
    // appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryColorLight, toolbarHeight: 120),
  );
}
