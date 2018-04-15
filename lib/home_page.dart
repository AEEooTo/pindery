/// This file contains the code for Pindery's homepage's structure.
/// 
import 'package:flutter/material.dart';
import 'theme.dart';
import 'drawer.dart' show PinderyDrawer;
import 'create_party.dart';
import 'party_cardlist.dart';

class PinderyHomePage extends StatefulWidget {
  PinderyHomePage({Key key}) : super(key: key);

  final String title = 'Pindery';

  @override
  _PinderyHomePageState createState() => new _PinderyHomePageState();
}

class _PinderyHomePageState extends State<PinderyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      drawer: new Drawer(
        child: new PinderyDrawer(),
      ),
      body: new PartyCardList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new CreatePartyPage()),
          );
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}

