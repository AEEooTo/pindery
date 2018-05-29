/// Welcome to Pindery, an amazing party app.
/// Visit [github.com/AEEooTo/pindery/README.md] for more information.
///
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

import 'theme.dart';
import 'home_page/home_page.dart';
import 'first_actions/welcome.dart';

void main() async {
  // Overriding https://github.com/flutter/flutter/issues/13736 for better
  // visual effect at the cost of performance.
  MaterialPageRoute.debugEnableFadingRoutes =
      true; // ignore: deprecated_member_use
  User user = await User.userDownloader();
  runApp(new Pindery(user: user));
}

class Pindery extends StatelessWidget {
  Pindery({this.user});

  final User user;
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
      home: homeCheck(),
      routes: <String, WidgetBuilder>{
        '/welcome-page': (BuildContext context) => new WelcomePage(),
        //'/home-page': (BuildContext context) => new HomePage(),
      },
    );
  }

  Widget homeCheck() {
    if (true) {
      return new HomePage(user: user);
    }
    return new PinderyHomePage();
  }

}

List<Locale> pinderySupportedLocales = [
  const Locale('en', ''), // English
];
