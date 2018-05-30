/// This file contains the code for Pindery's page where to choose what to bring to a party.
///

// Core imports
import 'dart:async';

// External imports
import 'package:flutter/material.dart';

// Internal imports
import 'item_card.dart';
import '../party.dart';
import '../theme.dart';
import '../catalogue/catalogue.dart';
import '../catalogue/catalogue_element.dart';

final String beveragesCoverImagePath = "assets/img/beer_2.jpg";
final String foodCoverImagePath = "assets/img/pasta.jpeg";
final String utilitiesCoverImagePath = "assets/img/kittens.jpeg";

/// The page that displays the stuff that the participants have to bring
class TakePartPage extends StatefulWidget {
  TakePartPage({this.homeScaffoldKey, this.party});
  final GlobalKey homeScaffoldKey;

  /// The [Party] instance the user wants to take part to
  final Party party;

  @override
  _TakePartPageState createState() => new _TakePartPageState();
}

class _TakePartPageState extends State<TakePartPage> {
  ObtainedPoints obtainedPoints = new ObtainedPoints();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        primaryColor: primary,
        primaryColorLight: primaryLight,
        primaryColorDark: primaryDark,
        accentColor: secondary,
        buttonTheme: new ButtonThemeData(textTheme: ButtonTextTheme.accent),
        brightness: Brightness.light,
        backgroundColor: primaryLight,
      ),
      child: new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text('Choose what to bring!'),
        ),
        floatingActionButton: new FloatingActionButton(
          tooltip: 'Participate to the party!',
          onPressed: () => obtainedPoints.points >= widget.party.pinderPoints
              ? _handleParticipation()
              : scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Text(
                      'You need to gain the minimum amount of points!'),
                  backgroundColor: primary,
                )),
          child: new Icon(Icons.arrow_forward),
          backgroundColor: secondary,
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                color: primaryLight,
                child: new ListView(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  // TODO: find a better way to display the cards,
                  // since the ListView would be less expensive than the Column.
                  // At the moment I'm using a column, since with the ListView rebuilds the cards
                  // every time they appear and disappear, so the slider would return to 0 every time
                  children: <Widget>[
                    new Column(
                      children: categoryCardListBuilder(),
                    ),
                  ],
                ),
              ),
            ),
            new Material(
              elevation: 400.0,
              type: MaterialType.canvas,
              shadowColor: secondary,
              child: new Container(
                height: 44.0,
                color: primary,
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: new Text(
                        'Pinder Points:  ' +
                            obtainedPoints.points.toString() +
                            ' / ' +
                            widget.party.pinderPoints.toString(),
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the list of the categories of the [Catalogue]
  List<ItemCard> categoryCardListBuilder() {
    List<ItemCard> itemCardList = <ItemCard>[];
    for (int i = 0; i < Catalogue.names.length; ++i) {
      List<CatalogueElement> elementsSublist;
      if (widget.party.catalogue.catalogue[i].isNotEmpty) {
        elementsSublist = widget.party.catalogue.catalogue[i];
        itemCardList.add(new ItemCard(
          category: Catalogue.names[i],
          catalogueSublist: elementsSublist,
          assetImage: new AssetImage(Catalogue.pics[i]),
          obtainedPoints: obtainedPoints,
          takePartPageState: this,
        ));
      }
    }

    return itemCardList;
  }

  void _handleParticipation() async {
    _showDialog();
    await widget.party.handleParticipation();
    Navigator.of(context).pop();
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
    ScaffoldState homeScaffoldState = widget.homeScaffoldKey.currentState;
    homeScaffoldState.showSnackBar(
        new SnackBar(content: new Text('You are going to party hard, great!')));
  }

  Future<Null> _showDialog() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return new AlertDialog(
            title: new Text('Loading'),
            content: new Container(
              height: 1.5,
              margin: EdgeInsets.only(top: 16.0),
              child: new LinearProgressIndicator(),
            ),
          );
        });
  }
}

/// Class for the obtained Pinder Points
/// It is necessary, since it's not possible to pass the primitive [int] as reference.
class ObtainedPoints {
  ObtainedPoints({this.points = 0});
  int points;
}
