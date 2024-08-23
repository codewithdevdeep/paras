import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes extends GetxController{
  Map<int, Color> color = {
  50: const Color.fromRGBO(198, 29, 36, .1),
  100: const Color.fromRGBO(198, 29, 36, .2),
  200: const Color.fromRGBO(198, 29, 36, .3),
  300: const Color.fromRGBO(198, 29, 36, .4),
  400: const Color.fromRGBO(198, 29, 36, .5),
  500: const Color.fromRGBO(198, 29, 36, .6),
  600: const Color.fromRGBO(198, 29, 36, .7),
  700: const Color.fromRGBO(198, 29, 36, .8),
  800: const Color.fromRGBO(198, 29, 36, .9),
  900: const Color.fromRGBO(198, 29, 36, 1),
};
  ThemeData nativeTheme (){
    return     ThemeData(
      appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent)),
      primaryColor: Colors.black,
      primaryColorLight: Colors.black,
      primarySwatch: MaterialColor(0xff000000, color),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(color: Colors.white),
        displayMedium: GoogleFonts.poppins(color: Colors.white),
        displaySmall: GoogleFonts.poppins(color: Colors.white),
        headlineMedium: GoogleFonts.poppins(color: Colors.white),
        headlineSmall: GoogleFonts.poppins(color: Colors.white),
        titleLarge: GoogleFonts.poppins(color: Colors.white),
        titleMedium: GoogleFonts.poppins(color: Colors.white),
        titleSmall: GoogleFonts.poppins(color: Colors.white),
        bodyLarge: GoogleFonts.poppins(color: Colors.white),
        bodyMedium: GoogleFonts.poppins(color: Colors.white),
        bodySmall: GoogleFonts.poppins(color: Colors.white),
        labelLarge: GoogleFonts.poppins(color: Colors.white),
        labelMedium: GoogleFonts.poppins(color: Colors.white),
        labelSmall: GoogleFonts.poppins(color: Colors.white),
      ),

      primaryTextTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(color: Colors.white),
        displayMedium: GoogleFonts.poppins(color: Colors.white),
        displaySmall: GoogleFonts.poppins(color: Colors.white),
        headlineMedium: GoogleFonts.poppins(color: Colors.white),
        headlineSmall: GoogleFonts.poppins(color: Colors.white),
        titleLarge: GoogleFonts.poppins(color: Colors.white),
        titleMedium: GoogleFonts.poppins(color: Colors.white),
        titleSmall: GoogleFonts.poppins(color: Colors.white),
        bodyLarge: GoogleFonts.poppins(color: Colors.white),
        bodyMedium: GoogleFonts.poppins(color: Colors.white),
        bodySmall: GoogleFonts.poppins(color: Colors.white),
        labelLarge: GoogleFonts.poppins(color: Colors.white),
        labelMedium: GoogleFonts.poppins(color: Colors.white),
        labelSmall: GoogleFonts.poppins(color: Colors.white),
      ),

    );
  }

}