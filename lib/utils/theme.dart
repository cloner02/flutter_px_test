import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/colors.dart';

ThemeData createTheme({String? colorKey}) {

  final String colorString = (colorKey != null && colors[colorKey] != null)? colors[colorKey].replaceAll('#', '') : "CC0000";
  final int colorInt = int.parse(colorString, radix: 16);
  final Color color = Color(colorInt + 0xFF000000); 

  // Get the current theme
  ThemeData newTheme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        useMaterial3: true,
      );

  return newTheme;
}