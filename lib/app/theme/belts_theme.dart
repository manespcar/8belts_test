import 'package:flutter/material.dart';

const primaryColor = Color(0xFF86B7E6);

class BeltsTheme {
  static ThemeData get themeData {
    return ThemeData(
      scaffoldBackgroundColor: primaryColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: const MaterialColor(
          0xFF1E4E7D,
          <int, Color>{
            50: Color(0xffce5641), //10%
            100: Color(0xffb74c3a), //20%
            200: Color(0xffa04332), //30%
            300: Color(0xff89392b), //40%
            400: Color(0xff733024), //50%
            500: Color(0xff5c261d), //60%
            600: Color(0xff451c16), //70%
            700: Color(0xff2e130e), //80%
            800: Color(0xff170907), //90%
            900: Color(0xff000000), //100%
          },
        ),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontFamily: 'DancingScript',
          fontSize: 60,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontFamily: 'DancingScript',
          fontSize: 30,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 30,
        ),
        subtitle1: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 20,
        ),
        subtitle2: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 12,
        ),
        labelMedium: TextStyle(
          color: Colors.black45,
          fontFamily: 'Roboto',
          fontSize: 16,
        ),
      ),
    );
  }
}
