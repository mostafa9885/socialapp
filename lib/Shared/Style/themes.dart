

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: 'Quicksand',
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    color: HexColor('333739'),
    elevation: 0,
    titleTextStyle: const TextStyle(
      fontFamily: 'Quicksand',
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: mainColor,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
  bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Color(0xFFFFFFFF),
        fontFamily: 'Quicksand',
    ),
  ),

);

ThemeData lightTheme = ThemeData(
  fontFamily: 'Quicksand',
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    color: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: 'Quicksand',
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: mainColor,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Colors.black),
  ),
);
