import 'package:flutter/material.dart';

CustomColors objCustomColors = CustomColors();

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        primaryColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.black),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.black),
          headline2: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
          subtitle1: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.red),
        ),
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        fontFamily: 'Roboto',
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: objCustomColors.secondaryColor,
        ),);
  }

  static ThemeData get darkTheme {
    return ThemeData(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white),
        button: TextStyle(color: Colors.white),
      ),
      primaryColor: Colors.grey.shade600,
      focusColor:Colors.black12,
      scaffoldBackgroundColor: Colors.grey.shade900,
      cardColor: Colors.grey.shade800,
      fontFamily: 'Roboto',
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Colors.red,
      ),
    );
  }
}

class CustomColors {
  var primaryColor = Colors.purple;
  var secondaryColor = Colors.purpleAccent;
  var tertiaryColor = Colors.red.shade200;
}
