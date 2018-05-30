///

// External libraries imports
import 'package:flutter/material.dart';
import 'party_card_list.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

// Internal imports
import '../drawer.dart' show PinderyDrawer;
import '../user.dart';
import '../first_actions/welcome.dart';
import '../party_creation_editing/step_1_create.dart';

/// This file contains the code for Pindery's homepage's structure.

class HomePage extends StatelessWidget {
  HomePage({this.user, this.analytics, this.observer});
  static const routeName = '/';

  final User user;
  final String title = 'Pindery';
  final GlobalKey<ScaffoldState> homeScaffoldKey =
      new GlobalKey<ScaffoldState>();
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return new Scaffold(
        key: homeScaffoldKey,
        appBar: new AppBar(
          title: new Text(title),
        ),
        drawer: new Drawer(
          child: new PinderyDrawer(user: user),
        ),
        body: new PartyCardList(
          observer: observer,
          analytics: analytics,
          homeScaffoldKey: homeScaffoldKey,
        ),
        floatingActionButton: new Opacity(
          opacity: 1.0,
          child: new FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new CreatePartyPage(
                        homePageKey: homeScaffoldKey,
                      ),
                ),
              );
            },
            child: new Icon(Icons.add),
            heroTag: null,
          ),
        ),
      );
    }
    return new WelcomePage();
  }
}
