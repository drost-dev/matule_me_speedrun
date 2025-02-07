import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _grey = Color.fromRGBO(112, 123, 129, 1);
const _darkGrey = Color.fromRGBO(106, 106, 106, 1);

const _blue = Color.fromRGBO(72, 178, 231, 1);

final defaultTheme = ThemeData(
  textTheme: TextTheme(
    displayMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 24/16,
      color: _grey,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 16/14,
      color: _darkGrey,
      letterSpacing: 0,
    ),


    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 16/12,
      color: _darkGrey,
      letterSpacing: 0,
    ),
  ),
  fontFamily: GoogleFonts.raleway().fontFamily,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(72, 178, 231, 1),
  ).copyWith(
    surface: const Color.fromRGBO(247, 247, 249, 1),
    onSurface: Colors.white,
    onSurfaceVariant: Colors.black,
  ),
);

extension CustomColors on ColorScheme {
  Color get grey => _grey;
  Color get darkGrey => _darkGrey;

  Color get blue => _blue;
}
