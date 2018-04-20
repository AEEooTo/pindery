///

// Dart core imports
import 'dart:async';

// External libraries imports
import 'package:flutter/material.dart';
import 'package:pindery/first_actions/welcome.dart';
import 'package:pindery/party_creation_editing/step_1_create.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

// Internal imports
import '../drawer.dart' show PinderyDrawer;
import 'party_cardlist.dart';
import '../user.dart';

/// This file contains the code for Pindery's homepage's structure.

class PinderyHomePage extends StatefulWidget {
  PinderyHomePage({Key key}) : super(key: key);

  @override
  _PinderyHomePageState createState() => new _PinderyHomePageState();
}

class _PinderyHomePageState extends State<PinderyHomePage> {
  User user;

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<FirebaseUser>(
        future: _getUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: new Container(
              child: new Text('Loading...'),
            ));
          }
          if (snapshot.data == null) {
            print("No user, ${snapshot.data}");
            return new WelcomePage();
          } else {
            print("User logged, ${snapshot.data}");
            return new HomePage(user);
          }
          // loading
        });
  }

  Future<FirebaseUser> _getUser() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    DocumentReference userReference = Firestore.instance
        .collection(User.usersDbPath)
        .document(firebaseUser.uid);
    DocumentSnapshot userOnDb = await userReference.get();
    user = User.fromFirestore(userOnDb);
    return firebaseUser;
  }
}

class HomePage extends StatelessWidget {
  HomePage(this.user);

  final User user;  
  final String title = 'Pindery';
  final GlobalKey<ScaffoldState> homeScaffoldKey =
      new GlobalKey<ScaffoldState>();
  ScrollController _hideButtonController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: homeScaffoldKey,
      appBar: new AppBar(
        title: new Text(title),
      ),
      drawer: new Drawer(
        child: new PinderyDrawer(user: user),
      ),
      body: new PartyCardList(
        hideButtonController: _hideButtonController,
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
                      )),
            );
          },
          child: new Icon(Icons.add),
          heroTag: null,
        ),
      ),
    );
  }
}

/*
child: new FloatingActionButton(
onPressed: () async {
if (_isVisible==false) {
await Navigator.push(
context,
new MaterialPageRoute(
builder: (context) =>
new CreatePartyPage(
homePageKey: homeScaffoldKey,
)),
);
}
},
child: new Icon(Icons.add),
mini: _isVisible? true : false,
heroTag: null,
),
*/
