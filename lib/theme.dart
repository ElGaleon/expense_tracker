import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  static const Color lightGrey = Color(0xFFF5F5F7);
}

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.deepOrange,
    background: AppColors.lightGrey,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightGrey,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  brightness: Brightness.light,
  dividerColor: Colors.white54,
  iconTheme: const IconThemeData(
    color: Colors.black38,
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.white,
    textColor: Colors.black87,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.white,
    floatingLabelStyle: TextStyle(color: Colors.deepOrange),
    hintStyle: TextStyle(color: Colors.grey),
    labelStyle: TextStyle(color: Colors.black38),
    focusColor: Colors.deepOrange,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.deepOrange),
    ),
  ),
);
