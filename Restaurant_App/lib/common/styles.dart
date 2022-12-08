import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xB3FFFFFF);
const Color secondaryColor = Color(0xFF151E21);
const Color darkPrimaryColor = Color.fromARGB(255, 0, 2, 8);
const Color darkSecondaryColor = Color.fromARGB(255, 223, 44, 12);

final TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.montserrat(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.montserrat(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.montserrat(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.montserrat(
      fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: 0.25),
  headline5: GoogleFonts.montserrat(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.montserrat(
      fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.15),
  subtitle1: GoogleFonts.montserrat(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.montserrat(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.libreFranklin(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.libreFranklin(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.libreFranklin(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

// Dark Theme

final ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(elevation: 0),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: textTheme,
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        secondary: darkSecondaryColor,
        primary: darkPrimaryColor,
        onPrimary: Colors.black,
      ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      backgroundColor: darkSecondaryColor,
      foregroundColor: darkPrimaryColor,
    ),
  ),
);

// Light Theme

final ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: textTheme,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        secondary: secondaryColor,
        primary: primaryColor,
        onPrimary: Colors.black,
      ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      backgroundColor: secondaryColor,
      foregroundColor: primaryColor,
    ),
  ),
);
