import 'package:flutter/material.dart';

import 'theme.dart';
import 'party_card.dart';
import 'drawer.dart' show PinderyDrawer;
import 'create_party.dart';

const loggedIn = true;

void main() => runApp(new Pindery());

class Pindery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pindery',
      theme: new ThemeData(
        primaryColor: primary,
        accentColor: secondary,
        buttonColor: secondary,
      ),
      home: new PinderyHomePage(title: 'Pindery'),
    );
  }
}

class PinderyHomePage extends StatefulWidget {
  PinderyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PinderyHomePageState createState() => new _PinderyHomePageState();
}

class _PinderyHomePageState extends State<PinderyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<PartyCard> _partyCards = PartyCard.partyCardsGenerator();
    return new Container(
      decoration: new BoxDecoration(color: Colors.grey[700]),
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        drawer: new Drawer(
          child: new PinderyDrawer(),
        ),
        body: new Container(
          color: primaryLight,
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: false,
            itemBuilder: (_, int index) => _partyCards[index],
            itemCount: _partyCards.length,
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.push(context, 
            new MaterialPageRoute(builder: (context) => new CreatePartyPage()),
            );
          },
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}
