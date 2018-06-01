import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

/// The Pindery App.
import 'theme.dart';
import 'home_page/home_page.dart';
import 'party_creation_editing/step_1_create.dart';
import 'user.dart';

class Pindery extends StatelessWidget {
  Pindery(this.user);

  final GlobalKey<ScaffoldState> homeScaffoldKey =
      new GlobalKey<ScaffoldState>();

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
              homeScaffoldKey: homeScaffoldKey,
            ),
        '/create-party': (BuildContext context) =>
            new CreatePartyPage(homeScaffoldKey, user.uid),
      },
    );
  }
}

List<Locale> pinderySupportedLocales = [
  const Locale('en', ''), // English
];
