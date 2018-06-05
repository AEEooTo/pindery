///

// External libraries imports
import 'package:flutter/material.dart';
import 'party_card_list.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:connectivity/connectivity.dart';

// Internal imports
import '../drawer.dart' show PinderyDrawer;
import '../user.dart';
import '../first_actions/welcome.dart';

/// This file contains the code for Pindery's homepage's structure.

class HomePage extends StatefulWidget {
  HomePage(
      {this.user,
      this.analytics,
      this.observer,
      this.connectivity,
      this.homeScaffoldKey,
      this.firebaseMessaging});

  static const routeName = '/';

  final User user;
  final String title = 'Pindery';
  final GlobalKey<ScaffoldState> homeScaffoldKey;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final ConnectivityResult connectivity;
  final FirebaseMessaging firebaseMessaging;

  @override
  State<HomePage> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  
  void initState() {
    super.initState();
    if (widget.user.name != null) {
      widget.firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true)
      );

      widget.firebaseMessaging.subscribeToTopic(testCity);

      widget.firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) {
        },
        onLaunch: (Map<String, dynamic> message) {
        },
        onResume: (Map<String, dynamic> message) {
        }
      );
      widget.firebaseMessaging.getToken().then((token) => print(token));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user.name != null) {
      return new Scaffold(
        key: widget.homeScaffoldKey,
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        drawer: new Drawer(
          child: new PinderyDrawer(
            user: widget.user,
            previousRoute: HomePage.routeName,
          ),
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
              await Navigator.pushNamed(context, '/create-party');
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
