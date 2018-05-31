/// Welcome to Pindery, an amazing party app.
/// Visit [github.com/AEEooTo/pindery/README.md] for more information.
///
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:connectivity/connectivity.dart';

import 'user.dart';
import 'theme.dart';
import 'home_page/home_page.dart';

void main() async {
  // Overriding https://github.com/flutter/flutter/issues/13736 for better
  // visual effect at the cost of performance.
  MaterialPageRoute.debugEnableFadingRoutes =
      true; // ignore: deprecated_member_use
  ConnectivityResult connectivity =
      await (new Connectivity().checkConnectivity());
  User user;
  if (connectivity != ConnectivityResult.none) {
    user = await User.userDownloader();
  }
  runApp(new Pindery(user, connectivity));
}

class Pindery extends StatelessWidget {
  Pindery(this.user, this.connectivity);

  final User user;
  final ConnectivityResult connectivity;
  final GlobalKey homeKey = new GlobalKey();
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
              connectivity: connectivity,
              key: homeKey,
            ),
      },
    );
  }
}

List<Locale> pinderySupportedLocales = [
  const Locale('en', ''), // English
];
