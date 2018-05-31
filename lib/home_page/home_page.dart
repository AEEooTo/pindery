///

// External libraries imports
import 'package:flutter/material.dart';
import 'party_card_list.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:connectivity/connectivity.dart';

// Internal imports
import '../drawer.dart' show PinderyDrawer;
import '../user.dart';
import '../first_actions/welcome.dart';
import '../party_creation_editing/step_1_create.dart';

/// This file contains the code for Pindery's homepage's structure.

class HomePage extends StatefulWidget {
  HomePage({this.user, this.analytics, this.observer, this.connectivity});
  static const routeName = '/';

  final User user;
  final String title = 'Pindery';
  final GlobalKey<ScaffoldState> homeScaffoldKey =
      new GlobalKey<ScaffoldState>();
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final ConnectivityResult connectivity;

  @override
  State<HomePage> createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    if (widget.user != null) {
      return new Scaffold(
        key: widget.homeScaffoldKey,
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        drawer: new Drawer(
          child: new PinderyDrawer(user: widget.user),
        ),
        body: new PartyCardList(
          observer: widget.observer,
          analytics: widget.analytics,
          homeScaffoldKey: widget.homeScaffoldKey,
        ),
        floatingActionButton: new Opacity(
          opacity: 1.0,
          child: new FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new CreatePartyPage(
                        homeScaffoldKey: widget.homeScaffoldKey,
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