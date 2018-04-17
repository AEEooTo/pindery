/// This file contains the code for Pindery's homepage's structure.
///
import 'package:flutter/material.dart';
import '../drawer.dart' show PinderyDrawer;
import 'package:pindery/party_creation_editing/create_party.dart';
import 'party_cardlist.dart';

class PinderyHomePage extends StatefulWidget {
  PinderyHomePage({Key key}) : super(key: key);

  final String title = 'Pindery';

  @override
  _PinderyHomePageState createState() => new _PinderyHomePageState();
}

class _PinderyHomePageState extends State<PinderyHomePage> {
  final GlobalKey<ScaffoldState> homeScaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                builder: (context) => new CreatePartyPage(
                      homePageKey: homeScaffoldKey,
                    )),
          );
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
