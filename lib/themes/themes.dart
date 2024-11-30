import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/themes/TextTheme/text_theme.dart';


ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  textTheme: MyTextTheme.lightTextTheme,
  // elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButton,
  // outlinedButtonTheme: MyElevatedButtonTheme.lightOutlineButton,
  cardColor: Colors.white,
  hintColor: Colors.black45,
  primaryColor: StyleConstants.darkGreen,
  appBarTheme: const AppBarTheme(backgroundColor: StyleConstants.darkGreen, foregroundColor: Colors.white)
);