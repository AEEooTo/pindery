///
import 'package:flutter/material.dart';
import '../drawer.dart' show PinderyDrawer;
import 'package:pindery/party_creation_editing/step_1_create.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'party_cardlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:pindery/first_actions/welcome.dart';


/// This file contains the code for Pindery's homepage's structure.


class PinderyHomePage extends StatefulWidget {
  PinderyHomePage({Key key, this.firebaseAuth}) : super(key: key);

  final String title = 'Pindery';
  final FirebaseAuth firebaseAuth;

  @override
  _PinderyHomePageState createState() => new _PinderyHomePageState(firebaseAuth);
}

class _PinderyHomePageState extends State<PinderyHomePage> {
  _PinderyHomePageState(this.firebaseAuth);

  final GlobalKey<ScaffoldState> homeScaffoldKey =
  new GlobalKey<ScaffoldState>();
  final FirebaseAuth firebaseAuth;
  FirebaseUser firebaseUser;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  @override
  Widget build(BuildContext context) {
    _user = firebaseAuth.onAuthStateChanged.listen(onData)
    new FutureBuilder<FirebaseUser>(
        future: getUser(_user, _auth),
        builder: (context, snapshot) {
          new Text("Loading");
          // loading
        });
    getUser(_user, _auth);
    if (_user == null) {
      print("qui dentro, user $firebaseUser");
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

  Future<FirebaseUser> _getUser() async {
    firebaseUser = await firebaseAuth.currentUser();
    print("ricalcolato");
    return firebaseUser;
  }
}

Future<FirebaseUser> getUser(FirebaseUser _user, FirebaseAuth _auth) async {
  _user = await _auth.currentUser();
  return _user;
}
