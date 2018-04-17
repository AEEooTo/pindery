///
import 'package:flutter/material.dart';
import '../drawer.dart' show PinderyDrawer;
import 'package:pindery/party_creation_editing/step_1_create.dart';
import 'party_cardlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

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

  @override
  Widget build(BuildContext context) {
    FutureBuilder<FirebaseUser>(
        future: _getUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        }
    );
    if(firebaseUser == null){
     //
    }
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

  Future<FirebaseUser> _getUser() async {
    firebaseUser = await firebaseAuth.currentUser();
    return firebaseUser;
  }
}
