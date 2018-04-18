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
  PinderyHomePage({Key key}) : super(key: key);

  final String title = 'Pindery';

  @override
  _PinderyHomePageState createState() => new _PinderyHomePageState();
}

class _PinderyHomePageState extends State<PinderyHomePage> {

  final GlobalKey<ScaffoldState> homeScaffoldKey =
  new GlobalKey<ScaffoldState>();
  FirebaseUser _user;


  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<FirebaseUser>(
        future: _getUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Snapshot has no data');
            return Center(child: new Container(child: new Text('Loading...'),));
          }
          print('Snapshot has data!');
          if (snapshot.data == null) {
            print("All'inizio del FutureBuilder ${snapshot.data}");
            return new WelcomePage();
          } else {
            print("WTF!?!? User !!11!1!!");
            print(snapshot.data.email);
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
          // loading
        });
  }

  Future<FirebaseUser> _getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print("ricalcolato in getuser: $user");
    return user;
  }
}