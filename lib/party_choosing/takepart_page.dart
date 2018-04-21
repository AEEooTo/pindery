/// This file contains the code for Pindery's page where to choose what to bring to a party.
///
import 'package:flutter/material.dart';
import 'item_card.dart';
import '../party.dart';
import '../theme.dart';

final String beveragesCoverImagePath = "assets/img/beer_2.jpg";
final String foodCoverImagePath = "assets/img/pasta.jpeg";
final String utilitiesCoverImagePath = "assets/img/kittens.jpeg";

class TakePartPage extends StatefulWidget {
  TakePartPage({this.party});

  Party party;

  @override
  _TakePartPageState createState() => new _TakePartPageState();
}

class _TakePartPageState extends State<TakePartPage> {
  final GlobalKey<ScaffoldState> homeScaffoldKey =
      new GlobalKey<ScaffoldState>();
  int obtainedPinderPoints = 4;

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
      ),
      child: new Scaffold(
          key: homeScaffoldKey,
          floatingActionButton: new FloatingActionButton(
            onPressed: null,
            child: new Icon(Icons.arrow_forward),
            backgroundColor: secondary,
          ),
          body: new Column(children: <Widget>[
            new Expanded(
              child: new Container(
                padding: EdgeInsets.only(top: 16.0),
                color: primary,
                child: new ListView(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  children: <Widget>[
                    new ItemCard(
                      party: widget.party,
                      category: 'Beverages',
                      assetImage: new AssetImage(beveragesCoverImagePath),
                    ),
                    new ItemCard(
                      party: widget.party,
                      category: 'Food',
                      assetImage: new AssetImage(foodCoverImagePath),
                    ),
                    new ItemCard(
                      party: widget.party,
                      category: 'Utilities',
                      assetImage: new AssetImage(utilitiesCoverImagePath),
                    )
                  ],
                ),
              ),
            ),
            new Container(
                height: 50.0,
                color: primary,
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: new Text(
                        'Pinder Points:  ' + obtainedPinderPoints.toString() +
                            '/' +
                            widget.party.pinderPoints.toString(),
                        style: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ))
          ])),
    );
  }
}
