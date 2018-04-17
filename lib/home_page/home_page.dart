/// This file contains the code for Pindery's homepage's structure.
///
import 'package:flutter/material.dart';
import '../drawer.dart' show PinderyDrawer;
import 'package:pindery/party_creation_editing/create_party.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'party_cardlist.dart';
import 'dart:async';
import 'package:pindery/first_actions/welcome.dart';

class PinderyHomePage extends StatefulWidget {
  PinderyHomePage({Key key}) : super(key: key);

  final String title = 'Pindery';

  @override
  _PinderyHomePageState createState() => new _PinderyHomePageState();
}

class _PinderyHomePageState extends State<PinderyHomePage> {
  final GlobalKey<ScaffoldState> homeScaffoldKey =
      new GlobalKey<ScaffoldState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  @override
  Widget build(BuildContext context) {
    new FutureBuilder<FirebaseUser>(
        future: getUser(_user, _auth),
        builder: (context, snapshot) {
          new Text("Loading");
          // loading
        });
    if (_user == null) {
      print("qui dentro, no user");
      return new WelcomePage(_auth);
      //new MaterialPageRoute(builder: (context) => new WelcomePage());
    }else {
      print("WTF!?!? User !!11!1!!");
      return new Scaffold(
        key: homeScaffoldKey,
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        drawer: new Drawer(
          child: new PinderyDrawer(),
        ),
        body: new PartyCardList(),
        floatingActionButton: new FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new CreatePartyPage(
                    homePageKey: homeScaffoldKey,
                  )),
            );
          },
          child: new Icon(Icons.add),
        ),
      );
    }
  }
}

Future<FirebaseUser> getUser(FirebaseUser _user, FirebaseAuth _auth) async {
  _user = await _auth.currentUser();
  return _user;
}
