/// This file contains the code for Pindery's homepage's structure.
///
import 'package:flutter/material.dart';
import '../drawer.dart' show PinderyDrawer;
import 'package:pindery/party_creation_editing/step_1_create.dart';
import 'party_cardlist.dart';
import 'package:flutter/rendering.dart';

class PinderyHomePage extends StatefulWidget {
  PinderyHomePage({Key key}) : super(key: key);

  final String title = 'Pindery';

  @override
  _PinderyHomePageState createState() => new _PinderyHomePageState();
}

class _PinderyHomePageState extends State<PinderyHomePage> {
  final GlobalKey<ScaffoldState> homeScaffoldKey =
  new GlobalKey<ScaffoldState>();
  ScrollController _hideButtonController;
  var _isVisible;

  @override
  initState() {
    super.initState();
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible = true;
        });
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

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
      body: new PartyCardList(hideButtonController: _hideButtonController,),
    floatingActionButton: new Opacity(
        opacity: !_isVisible ? 1.0 : 0.0,
        child: new FloatingActionButton(
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
      ),

    );
  }

}

