/// This file contains the code for Pindery's homepage's structure.
///
import 'package:flutter/material.dart';

import 'theme.dart';
import 'party_card.dart';
import 'drawer.dart' show PinderyDrawer;
import 'create_party.dart';

class PinderyHomePage extends StatefulWidget {
  PinderyHomePage({Key key}) : super(key: key);

  final String title = 'Pindery';

  @override
  _PinderyHomePageState createState() => new _PinderyHomePageState();
}

class _PinderyHomePageState extends State<PinderyHomePage> {
  _PinderyHomePageState({Contex});

  // AGGIUNTO ADESSO DA TENERE
  final GlobalKey<ScaffoldState> homeScaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<PartyCard> _partyCards = PartyCard.partyCardsGenerator();
    return new Scaffold(
      key: homeScaffoldKey,
      // AGGIUNTO ADESSO DA TENERE
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
        onPressed: () async {
          await Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new CreatePartyPage(
                      homePageKey: homeScaffoldKey,
                    )), // AGGIUNTO ADESSO; DA TENERE
          );
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
