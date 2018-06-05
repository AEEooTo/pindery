import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'theme.dart';
import 'home_page/home_page.dart' show HomePage;
import 'party_creation_editing/step_1_create.dart';
import 'user.dart';
import 'drawer.dart' show PinderyDrawer;
import 'settings.dart' show SettingsPage;
import 'first_actions/welcome.dart' show WelcomePage;
import 'first_actions/login.dart' show LoginPage;
import 'first_actions/signup.dart' show SignupPage;

///
/// The pindery application
class Pindery extends StatelessWidget {
  Pindery(this.user);

  final GlobalKey<ScaffoldState> homeScaffoldKey =
      new GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

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
              firebaseMessaging: _firebaseMessaging,
            ),
        '/create-party': (BuildContext context) =>
            new CreatePartyPage(homeScaffoldKey, user.uid),
        '/drawer': (BuildContext context) => new PinderyDrawer(user: user),
        '/settings': (BuildContext context) => new SettingsPage(
              user: user,
              firebaseMessaging: _firebaseMessaging,
            ),
        '/welcome': (BuildContext context) => new WelcomePage(),
        '/login': (BuildContext context) => new LoginPage(user: user),
        '/signup': (BuildContext context) => new SignupPage(user: user),
      },
    );
  }
}

List<Locale> pinderySupportedLocales = [
  const Locale('en', ''), // English
];
