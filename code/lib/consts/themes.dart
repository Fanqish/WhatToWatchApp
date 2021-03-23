import 'package:flutter/material.dart';
import 'package:get/get.dart';

RxBool isdark = false.obs;
Rx<Color> mainColor = Color(0XFF6C5CD5).obs;

class Themes {
  final light = ThemeData.light().copyWith(
      primaryColor: mainColor.value,
      primaryColorLight: mainColor.value,
      accentColor: mainColor.value,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.white60,
      ));
  static final dark = ThemeData.dark().copyWith(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: false,
    selectedItemColor: Colors.white,
    showUnselectedLabels: false,
    unselectedItemColor: Colors.white60,
  ));
}
