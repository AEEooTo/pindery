import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

import 'theme.dart';
import 'home_page/home_page.dart';
import 'party_creation_editing/step_1_create.dart';
import 'user.dart';
import 'drawer.dart';
import 'settings.dart';
import 'first_actions/welcome.dart';

///
/// The pindery application
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
        '/drawer': (BuildContext context) => new PinderyDrawer(user: user),
        '/settings': (BuildContext context) => new SettingsPage(user: user),
        '/welcome-page': (BuildContext context) => new WelcomePage(user: user),
      },
    );
  }
}

List<Locale> pinderySupportedLocales = [
  const Locale('en', ''), // English
];
