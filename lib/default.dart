import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _grey = Color.fromRGBO(112, 123, 129, 1);
const _darkGrey = Color.fromRGBO(106, 106, 106, 1);

const _blue = Color.fromRGBO(72, 178, 231, 1);

const _red = Color.fromRGBO(248, 114, 101, 1);

const _disabled = Color.fromRGBO(43, 107, 139, 1);

final defaultTheme = ThemeData(
  textTheme: TextTheme(
    displayMedium: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
      color: Colors.black,
    ),
    headlineMedium: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 21,
      letterSpacing: 0,
      color: Colors.black,
    ),
    headlineSmall: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 0,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 24/16,
      color: _grey,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 16/14,
      color: _darkGrey,
      letterSpacing: 0,
    ),

    bodyLarge: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 24/18,
      letterSpacing: 0,
      color: Colors.black,
    ),


    labelLarge: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 16/12,
      color: _darkGrey,
      letterSpacing: 0,
    ),
    labelSmall: const TextStyle(
      fontSize: 12,
      letterSpacing: 0,
      color: Color.fromRGBO(125, 132, 141, 1),
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
  disabledColor: _disabled,
);

extension CustomColors on ColorScheme {
  Color get grey => _grey;
  Color get darkGrey => _darkGrey;

  Color get blue => _blue;
  Color get red => _red;
}
