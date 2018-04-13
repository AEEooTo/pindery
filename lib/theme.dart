/// theme.dart
/// This file contains all the data for Flutter's theming
///

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
const Color dividerColor = const Color(0x2F000000);
const Color inputFieldColor = const Color(0x99FFFFFF);


ThemeData pinderyTheme = new ThemeData(
  primaryColor: primary,
  primaryColorLight: primaryLight,
  primaryColorDark: primaryDark,
  accentColor: secondary,
  buttonColor: secondaryLight,
  buttonTheme: new ButtonThemeData(textTheme: ButtonTextTheme.accent),
);

const TextStyle bigLabelStyle = const TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: inputFieldColor,
);

const TextStyle labelStyle = const TextStyle(
  fontSize: 17.0,
  color: inputFieldColor,
);

const TextStyle inputTextStyle = const TextStyle(
  color: Colors.white,
  fontSize: 17.0,
);
