import 'package:flutter/material.dart';

const String baseUrl = 'https://687a0f51abb83744b7eb3a98.mockapi.io/dunijet/api/v1';

const Color primaryColor = Color(0xFF00796B);
const Color backgroundLightColor = Color(0xFFF5F5F5);
const Color textDarkColor = Colors.black87;
const Color whiteColor = Colors.white;

ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.light),
  useMaterial3: true,
  scaffoldBackgroundColor: backgroundLightColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundLightColor,
    foregroundColor: textDarkColor,
    elevation: 0,
    scrolledUnderElevation: 4,
    surfaceTintColor: backgroundLightColor,
    centerTitle: true,
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: whiteColor,
    backgroundColor: primaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: whiteColor,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    prefixIconColor: primaryColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
);
