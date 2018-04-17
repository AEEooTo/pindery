/// Welcome to Pindery, an amazing party app.
/// Visit [github.com/AEEooTo/pindery/README.md] for more information.
///

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'theme.dart';
import 'package:pindery/home_page/home_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();
const loggedIn = true;

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
      home: (loggedIn == true ? new PinderyHomePage() : null/*todo add pre-auth*/),
    );
  }
}

List<Locale> pinderySupportedLocales = [
  const Locale('en', ''), // English
];


