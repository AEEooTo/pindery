import 'package:flutter/material.dart';

import 'party.dart';
import 'drawer.dart';

class PartyPage extends StatelessWidget {
  final Party party;

  PartyPage({this.party});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(party.name),
      ),
      drawer: new Drawer(
        child: new PinderyDrawer(),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('Go back!'),
        ),
      ),
    );
  }
}
