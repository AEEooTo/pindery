/// step_2_catalogue.dart
/// contains the code for choosing the party catalogue

import 'dart:async';

import 'package:flutter/material.dart';

import '../theme.dart';
import '../catalogue_element.dart';
import '../party.dart';
import 'catalogue_choosing_list.dart';
import 'party_details_utils.dart';

class ChooseCataloguePage extends StatefulWidget {
  ChooseCataloguePage({this.homePageKey, this.party});
  final GlobalKey homePageKey;

  final Party party;

  _ChooseCataloguePageState createState() =>
      new _ChooseCataloguePageState(party: party, homePageKey: homePageKey);
}

class _ChooseCataloguePageState extends State<ChooseCataloguePage> {
  _ChooseCataloguePageState({this.party, this.homePageKey});

  final GlobalKey homePageKey;

  /// partially filled party (misses the [catalogue])
  Party party;

  /// to-be filled [List] of [CatalogueElement]s
  List<CatalogueElement> catalogue = new List<CatalogueElement>();

  /// the list of the chosen [CatalogueElement]s

  bool cancelled =
      false; // variable to check whether the user cancelled the uploading process or not
  final GlobalKey scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey chosenListStateKey = new GlobalKey<_ChooseCataloguePageState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement catalogue
    return new Theme(
      data: Theme.of(context),
      child: new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text('Choose the catalogue'),
        ),
        body: new ListView(
          children: <Widget>[
            new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ChosenList(
                  catalogue: catalogue,
                  key: chosenListStateKey,
                ),
                new IconButton(
                  icon: new Icon(Icons.add),
                  onPressed: () => Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new CatalogueChoosingList(
                                  catalogue: catalogue,
                                )),
                      ),
                ),
              ],
            ),
            new Container(
              margin: const EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 80.0, right: 80.0),
              child: new RaisedButton(
                child: new Text(
                  'NEXT',
                  style: new TextStyle(color: Colors.white),
                ),
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
          ],
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
    return catalogue.isNotEmpty;
  }
}

class ChosenList extends StatefulWidget {
  ChosenList({this.catalogue, Key key}) :super(key: key);

  final List<CatalogueElement> catalogue;

  _ChosenListState createState() => new _ChosenListState(catalogue: catalogue, chosenListKey: key);
}

class _ChosenListState extends State<ChosenList> {
  _ChosenListState({this.catalogue, this.chosenListKey});

  final List<CatalogueElement> catalogue;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<_ChooseCataloguePageState> chosenListKey;

  @override
  Widget build(BuildContext context) {
    print(chosenListKey);
    print(chosenListKey.currentState);
    return new Padding(
      padding: EdgeInsets.all(8.0),
      child: new Column(
        children: <Widget>[
          new Form(
            key: formKey,
            child: new ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, int index) {
                print('In itemBuilder '+ chosenListKey.currentState.toString());
                return new CatalogueElementRow(
                  element: catalogue[index],
                  catalogue: catalogue,
                  index: index,
                  chosenListStateKey: chosenListKey,
                  chosenListState: this,
                );
              },
              itemCount: catalogue.length,
              padding: EdgeInsets.all(16.0),
            ),
          )
        ],
      ),
    );
  }
}

class CatalogueElementRow extends StatelessWidget {
  CatalogueElementRow({this.element, this.catalogue, this.index, this.chosenListStateKey, this.chosenListState});

  final CatalogueElement element;
  final List<CatalogueElement> catalogue;
  final int index;
  final GlobalKey chosenListStateKey;
  final _ChosenListState chosenListState;

  @override
  Widget build(BuildContext context) {
    print('In catalogueElementRow '+ chosenListStateKey.currentState.toString());
    return Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
              flex: 3,
              child: new Text(
                element.elementName,
                style: new TextStyle(fontSize: 17.0),
              ),
            ),
            new Expanded(
              flex: 2,
              child: new TextFormField(
                keyboardType: TextInputType.number,
                validator: (val) => isNumericAndPositive(val)
                    ? 'You must insert a valid number, bigger than 0'
                    : null,
              ),
            ),
            new Expanded(
              flex: 2,
              child: new IconButton(
                icon: new Icon(Icons.cancel),
                onPressed: () =>_deleteElement(chosenListStateKey),
              ),
            )
          ],
        ),
      ],
    );
  }

  void _deleteElement(GlobalKey listStateKey) {
    // TODO: find a better way to setState()
    print('In _deleteleElement '+ listStateKey.currentState.toString());
    final _ChosenListState listState = listStateKey.currentState;
    print(listState);
    chosenListState.setState(() {
      catalogue.removeAt(index);
    });
  }


}
