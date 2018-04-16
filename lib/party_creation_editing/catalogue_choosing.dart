/// catalogue_choosing.dart
/// contains the code for choosing the party catalogue

import 'dart:async';

import 'package:flutter/material.dart';

import 'party_details_utils.dart';
import '../theme.dart';
import '../party.dart';

class ChooseCataloguePage extends StatefulWidget {
  ChooseCataloguePage({this.homePageKey, this.party});

  static const String routeName = '/create-party';
  final GlobalKey homePageKey;

  final Party party;

  _ChooseCataloguePageState createState() =>
      new _ChooseCataloguePageState(party: party, homePageKey: homePageKey);
}

class _ChooseCataloguePageState extends State<ChooseCataloguePage> {
  _ChooseCataloguePageState({this.party, this.homePageKey});

  final GlobalKey homePageKey;
  Party party;

  bool cancelled = false;

  final GlobalKey scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement catalogue
    return new Theme(
      data: Theme.of(context),
      child: new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text('Choose catalogue'),
        ),
        body: new Center(
          child: new Container(
            margin: const EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 110.0, right: 110.0),
            child: new RaisedButton(
              child: new Text(
                'NEXT',
                style: new TextStyle(color: Colors.white),
              ),
              // TODO: add party catalogue screen
              onPressed: _validateCatalogue()
                  ? () async {
                      final ScaffoldState scaffoldState =
                          scaffoldKey.currentState;
                      final ScaffoldState homePageState =
                          homePageKey.currentState;
                      cancelled = false;
                      await _uploadingDialog();
                      print('cancelled = ' + cancelled.toString());
                      if (!cancelled) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        homePageState.showSnackBar(new SnackBar(
                          content: new Text("Great! The party was created!"),
                        ));
                      } else {
                        scaffoldState.showSnackBar(new SnackBar(
                          // TODO: really cancel the party
                          content: new Text("Party creation cancelled"),
                        ));
                      }
                    }
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _uploadingDialog() async {
    _handleSubmitted();
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Loading'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Loading cool infos.'),
                new Text('You\'ll be soon ready to party hard.'),
                new Center(
                  child: new Container(
                    height: 1.5,
                    margin: EdgeInsets.only(top: 16.0),
                    child: new LinearProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () {
                cancelled = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Method to assign the different collected fields to the Party instance
  void _handleSubmitted() async {
    await party.uploadImage(party.imageLocalPath);
    if (!cancelled) {
      party.sendParty();
      Navigator.of(context).pop();
    }
  }

  bool _validateCatalogue() {
    // TODO: implement catalogue validator
    return true;
  }
}
