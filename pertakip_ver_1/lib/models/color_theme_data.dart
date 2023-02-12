import 'package:flutter/material.dart';

class ColorThemeData with ChangeNotifier {
  ThemeData _orangeTheme = ThemeData(
    unselectedWidgetColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.orangeAccent.shade400,
    buttonColor: Colors.orangeAccent.shade400,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        button: TextStyle(color: Colors.white),
      ),
      color: Colors.orangeAccent.shade400,
    ),
    accentColor: Colors.orangeAccent.shade400,
    scaffoldBackgroundColor: Colors.orangeAccent.shade400,
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.black54),
      headline2: TextStyle(color: Colors.black54),
      subtitle1: TextStyle(color: Colors.black54),
      subtitle2: TextStyle(color: Colors.white),
    ),
  );
  ThemeData get orangeTheme => _orangeTheme;
}
