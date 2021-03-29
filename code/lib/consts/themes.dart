import 'package:code/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const defaultMainColor = (0XFF6C5CD5);

TextStyle settingTextTheme =
    TextStyle(fontWeight: FontWeight.w600, letterSpacing: .55);

class Themes {
  final light = ThemeData.light().copyWith(
      textTheme: GoogleFonts.robotoTextTheme(ThemeData.light().textTheme),
      primaryColor:
          Color((settings.get("mainColor", defaultValue: defaultMainColor))),
      primaryColorLight:
          Color((settings.get("mainColor", defaultValue: defaultMainColor))),
      accentColor:
          Color((settings.get("mainColor", defaultValue: defaultMainColor))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.white60,
      ));
  final dark = ThemeData.dark().copyWith(
      textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ));
}
