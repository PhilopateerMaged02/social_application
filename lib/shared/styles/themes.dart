import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
        color: HexColor('333739')
    ),
    scaffoldBackgroundColor: HexColor('333739'),
    brightness: Brightness.dark,
    textTheme: TextTheme(
        bodyMedium: TextStyle(
            color: Colors.white
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 20,
      backgroundColor: HexColor('333739'),
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.deepOrange,
    )
);
ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      color: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    textTheme: TextTheme(
        bodyMedium: TextStyle(
            color: Colors.black
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 20,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.blue,
    )
);