import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    // Background color
    scaffoldBackgroundColor: Colors.white,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.cabin(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0, // Subtle shadow for separation
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black, // Background color
        textStyle: GoogleFonts.cabin(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 3,
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.2),
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // ListTile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      iconColor: Colors.black,
      textColor: Colors.black,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // BottomNavigationBar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed, // Fixed
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Color.fromARGB(255, 71, 71, 71),
      elevation: 0,
    ),

    // Text Theme
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.cabin(
        color: Colors.black,
        fontSize: 16.0,
      ),
      bodyMedium: GoogleFonts.cabin(
        color: Colors.black,
        fontSize: 14.0,
      ),
      titleLarge: GoogleFonts.cabin(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),

    // TextFormField Theme
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: GoogleFonts.cabin(color: Colors.black),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2.0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        textStyle: GoogleFonts.cabin(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    // Background color
    scaffoldBackgroundColor: Colors.black,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.cabin(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white, // Background color
        textStyle: GoogleFonts.cabin(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 3,
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: Colors.grey[850], // Dark background for cards
      shadowColor: Colors.black.withOpacity(0.5),
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // ListTile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      iconColor: Colors.white,
      textColor: Colors.white,
      tileColor: Colors.grey[850], // Dark tile background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.cabin(
        color: Colors.white,
        fontSize: 16.0,
      ),
      bodyMedium: GoogleFonts.cabin(
        color: Colors.white,
        fontSize: 14.0,
      ),
      titleLarge: GoogleFonts.cabin(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),

    // TextFormField Theme
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: GoogleFonts.cabin(color: Colors.white),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
    ),
    // BottomNavigationBar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed, // Fixed
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Color.fromARGB(255, 202, 202, 202),
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        textStyle: GoogleFonts.cabin(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
