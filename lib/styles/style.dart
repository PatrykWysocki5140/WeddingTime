import 'package:flutter/material.dart';
import 'package:wedding_time/constants.dart';
import 'package:wedding_time/styles/text.dart';

ThemeData theme(BuildContext context) {
  return ThemeData(
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 2.0,
            style: BorderStyle.solid,
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        tileColor: kBackgroundColor,
        iconColor: kAccentColor,
      ),
      textSelectionTheme: const TextSelectionThemeData(
          selectionColor: kAccentColor,
          selectionHandleColor: kAccentColor,
          cursorColor: kAccentColor),
      scaffoldBackgroundColor: kBackgroundColor,
      primaryColor: kPrimaryColor,
      appBarTheme: const AppBarTheme(
        color: kPrimaryColor,
        titleTextStyle: TextStyle(
            color: kTextColor,
            fontSize: 24,
            letterSpacing: 0,
            fontWeight: FontWeight.w900),
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'ClearSans',
            fontSize: 20,
            color: kTextColor),
        //backgroundColor:isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        selectedItemColor: kTextColor,
        unselectedItemColor: kTextColor,
      ),
      textTheme: textTheme(context),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            // backgroundColor: kPrimaryColor,
            // backgroundColor: kAccentColor,
            foregroundColor: kTextColor,
            minimumSize: const Size.fromHeight(50),
            textStyle: const TextStyle(
                fontFamily: 'ClearSans',
                color: kTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            // backgroundColor: kPrimaryColor,
            backgroundColor: kAccentColor,
            foregroundColor: kTextColor,
            minimumSize: const Size.fromHeight(50),
            textStyle: const TextStyle(
                fontFamily: 'ClearSans',
                color: kTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: kTextColor),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(style: BorderStyle.solid, color: kAccentColor)),
      ),
      fontFamily: 'ClearSans');
}
