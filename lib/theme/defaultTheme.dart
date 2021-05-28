import 'package:flutter/material.dart';

class DefaultTheme with ChangeNotifier {
  static ThemeData get darkTheme {
    return ThemeData(
        
      accentColor: Color(0xFF6b705c),
      primaryColor: Color(0xFFcb997e),
      buttonColor: Color(0xFF606c38),
      scaffoldBackgroundColor: Color(0xFFb7b7a4),
      cardColor: Color(0xFFffe8d6),
      errorColor: Color(0xFF9d0208),
      bottomAppBarColor: Color(0xFFcb997e),
      fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme.copyWith(),
      
        );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      
      accentColor: Colors.lightGreen[400],
      primaryColor: Colors.indigo[300],
      buttonColor: Colors.indigo[200],
      scaffoldBackgroundColor: Colors.indigo[100],
      cardColor: Colors.indigo[50],
      errorColor: Colors.pink[500],
      
      fontFamily: 'Montserrat',
      textTheme: ThemeData.light().textTheme.copyWith(
            headline1: ThemeData.light().textTheme.headline1.copyWith(),
          ),
    );
  }

  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
