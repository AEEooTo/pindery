/// step_2_catalogue.dart
/// contains the code for choosing the party catalogue
/// ///
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';

import '../catalogue_element.dart';
import '../party.dart';
import 'catalogue_choosing_list.dart';
import 'party_details_utils.dart';

class ChooseCataloguePage extends StatefulWidget {
  static const String routeName = '/create-party/step-2';

  ChooseCataloguePage({this.homePageKey, this.party, this.catalogue});

  final GlobalKey homePageKey;

  final List<CatalogueElement> catalogue;
  final Party party;

  _ChooseCataloguePageState createState() => new _ChooseCataloguePageState(
      party: party, homePageKey: homePageKey, catalogue: catalogue);
}

class _ChooseCataloguePageState extends State<ChooseCataloguePage> {
  _ChooseCataloguePageState({this.party, this.homePageKey, this.catalogue});

  final GlobalKey homePageKey;

  /// partially filled party (misses the [catalogue])
  Party party;

  /// to-be filled [List] of [CatalogueElement]s
  List<CatalogueElement> catalogue;

  /// variable to check whether the user cancelled the uploading process or not
  bool cancelled = false;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final chosenListStateKey = new GlobalKey<_ChooseCataloguePageState>();
  final GlobalKey<FormState> chosenListFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  formKey: chosenListFormKey,
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
                              ),
                        ),
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
                onPressed: () async {
                  if (catalogue.isNotEmpty &&
                      chosenListFormKey.currentState.validate()) {
                    print('entered the async');
                    final ScaffoldState scaffoldState =
                        scaffoldKey.currentState;
                    final ScaffoldState homePageState =
                        homePageKey.currentState;
                    cancelled = false;
                    await _uploadingDialog(chosenListFormKey.currentState);
                    print('cancelled = ' + cancelled.toString());
                    if (!cancelled) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      //Navigator.popUntil(context, ModalRoute.withName('/home-page')); //to implement after the user becomes stored in a redux
                      homePageState.showSnackBar(new SnackBar(
                        content: new Text("Great! The party was created!"),
                      ));
                    } else {
                      scaffoldState.showSnackBar(new SnackBar(
                        // TODO: really cancel the party
                        content: new Text("Party creation cancelled"),
                      ));
                    }
                  } else {
                    if (catalogue.isEmpty) {
                      scaffoldKey.currentState.showSnackBar(
                        new SnackBar(
                          // TODO: really cancel the party
                          content: new Text("The catalogue is empty"),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Method to assign the different collected fields to the [Party] instance
  Future<Null> _handleSubmitted(FormState formState) async {
    formState.save();
    print('saved form');
    party.catalogue = catalogue;
    await party.uploadImage(party.imageLocalPath);
    if (!cancelled) {
      party.sendParty();
      Navigator.of(context).pop();
    }
  }

  Future<Null> _compressImage() async {
    print("compressing image"); //todo: remove debug print
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Random().nextInt(10000);

    Im.Image image = Im.decodeImage(party.imageLocalPath.readAsBytesSync());

    int widthFinal;
    if(image.height > image.width){
      widthFinal = 1080;
    }else{
      widthFinal = ((image.width * 1080)/image.height).round();
    }
    image = Im.copyResize(image, widthFinal); // choose the size here, it will maintain aspect ratio
    print("image compressed");
    party.imageLocalPath = new File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 50));
  }

  Future<Null> _uploadingDialog(FormState formState) async {
    _compressImage();
    _handleSubmitted(formState);
    print("past the futures");
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
}

class ChosenList extends StatefulWidget {
  ChosenList({this.catalogue, Key key, this.formKey}) : super(key: key);

  final List<CatalogueElement> catalogue;
  final formKey;

  _ChosenListState createState() => new _ChosenListState(
      catalogue: catalogue, chosenListKey: key, formKey: formKey);
}

class _ChosenListState extends State<ChosenList> {
  _ChosenListState({this.catalogue, this.chosenListKey, this.formKey});

  final List<CatalogueElement> catalogue;
  final formKey;
  final chosenListKey;

  @override
  Widget build(BuildContext context) {
    if (catalogue.isEmpty) {
      return new Center(
        child: new Padding(
          padding: const EdgeInsets.all(30.0),
          child: new Text(
            'Tap the + to begin choosing what the participants will need to bring!',
          ),
        ),
      );
    }
    return new Padding(
      padding: EdgeInsets.all(8.0),
      child: new Column(
        children: <Widget>[
          new Form(
            key: formKey,
            child: new ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, int index) {
                print(
                    'In itemBuilder ' + chosenListKey.currentState.toString());
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
  CatalogueElementRow(
      {this.element,
      this.catalogue,
      this.index,
      this.chosenListStateKey,
      this.chosenListState,
      this.controller});

  final CatalogueElement element;
  final List<CatalogueElement> catalogue;
  final int index;
  final GlobalKey chosenListStateKey;
  final _ChosenListState chosenListState;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
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
                validator: (val) =>
                    !isNumericAndPositive(val) ? 'Not valid' : null,
                controller: controller,
                onSaved: (val) =>
                    catalogue[index].elementQuantity = int.parse(val),
                initialValue: catalogue[index].elementQuantity.toString(),
                decoration: new InputDecoration(labelText: 'Quantity'),
              ),
            ),
            new Expanded(
              flex: 2,
              child: new IconButton(
                icon: new Icon(Icons.cancel),
                onPressed: () => _deleteElement(chosenListStateKey),
              ),
            )
          ],
        ),
      ],
    );
  }

  void _deleteElement(GlobalKey listStateKey) {
    // TODO: find a better way to setState()
    print('In _deleteleElement ' + listStateKey.currentState.toString());
    final _ChosenListState listState = listStateKey.currentState;
    print(listState);
    chosenListState.setState(() {
      catalogue.removeAt(index);
    });
  }
}
