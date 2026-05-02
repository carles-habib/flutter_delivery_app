// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeSevice {
  static final bool isDark = false;
  final lightTheme = ThemeData.light().copyWith(
      primaryColor: Colors.blueGrey.shade300,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      shadowColor: Colors.white,
      splashColor: Color(0xFFe8e8e8),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Colors.white),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Color(0xFFf7f6f4),
      ),
      // accentColor: Color(0xFFF2F2F2),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: Color(0xFF332d2d),
        ),
      ),
      canvasColor: Colors.black);

  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.blueGrey.shade300,
      scaffoldBackgroundColor: Color(0xFF1F1F1F),
      cardColor: Color(0xFF2C2C2C),
      shadowColor: Color(0xFF1F1F1F),
      splashColor: Color(0xFF323435),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Color(0xFF1F1F1F)),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Color(0xFF2C2C2C)),
      // accentColor: Color(0xFF2C2C2C),
      canvasColor: Colors.white);

  final _getStorage = GetStorage();
  final _darkThemeKey = 'isDark';

  void saveThemeData(bool isDarkMode) {
    _getStorage.write(_darkThemeKey, isDarkMode);
  }

  bool isSaveDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSaveDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSaveDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSaveDarkMode());
  }
}
