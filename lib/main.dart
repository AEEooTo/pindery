/// Welcome to Pindery, an amazing party app.
/// Visit [github.com/AEEooTo/pindery/README.md] for more information.
///
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'user.dart';
import 'theme.dart';
import 'home_page/home_page.dart';

void main() async {
  // Overriding https://github.com/flutter/flutter/issues/13736 for better
  // visual effect at the cost of performance.
  MaterialPageRoute.debugEnableFadingRoutes =
      true; // ignore: deprecated_member_use
  User user;
  user = await User.userDownloader();
  runApp(new Pindery(user));
}

/// The Pindery App.
class Pindery extends StatelessWidget {
  Pindery(this.user);

  /// The User of the app
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
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new HomePage(
              user: user,
            ),
      },
    );
  }
}

List<Locale> pinderySupportedLocales = [
  const Locale('en', ''), // English
];
