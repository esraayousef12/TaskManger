import 'package:flutter/material.dart';

class AppTheme {
  static final Color pinkLight = Colors.pink.shade100;
  static final Color grayDark = Colors.grey.shade800;

  static final ThemeData lightTheme = ThemeData(
    primaryColor: pinkLight,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: pinkLight,
      foregroundColor: grayDark,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.light(
      primary: pinkLight,
      secondary: grayDark,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: grayDark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
      backgroundColor: grayDark,
      foregroundColor: pinkLight,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.dark(
      primary: grayDark,
      secondary: pinkLight,
    ),
  );
}
