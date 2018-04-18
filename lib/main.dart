/// Welcome to Pindery, an amazing party app.
/// Visit [github.com/AEEooTo/pindery/README.md] for more information.
///

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'theme.dart';
import 'package:pindery/home_page/home_page.dart';
import 'package:pindery/first_actions/welcome.dart';


void main() => runApp(new Pindery());

class Pindery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: pinderySupportedLocales,
      title: 'Pindery',
      theme: pinderyTheme,
      home: new PinderyHomePage(),
      routes: <String, WidgetBuilder>{
        '/welcome-page' : (BuildContext context) => new WelcomePage(),
      },
    );
  }
}

List<Locale> pinderySupportedLocales = [
  const Locale('en', ''), // English
];

