import 'package:flutter/material.dart';

// Primary colors
Color primary = const Color(0xFF212121);
Color primaryLight = const Color(0xFF484848);
Color primaryDark = const Color(0xFF000000);

// Secondary colors
Color secondary = const Color(0xFFE52059);
Color secondaryLight = const Color(0xFFED2467);
Color secondaryDark = const Color(0xFFB70449);

// Functional colors 
Color divider = const Color(0x2F000000);
Color inputFieldColor = const Color(0x99FFFFFF);

ThemeData pinderyTheme = new ThemeData(
  primaryColor: primary,
  accentColor: secondary,
  buttonColor: secondaryLight,
  buttonTheme: new ButtonThemeData(textTheme: ButtonTextTheme.accent),
);
