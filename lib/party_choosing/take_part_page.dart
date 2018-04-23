/// This file contains the code for Pindery's page where to choose what to bring to a party.
///

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

class TakePartPage extends StatefulWidget {
  TakePartPage({this.party});

  final Party party;

  @override
  _TakePartPageState createState() => new _TakePartPageState();
}

class _TakePartPageState extends State<TakePartPage> {
  final GlobalKey<ScaffoldState> homeScaffoldKey =
      new GlobalKey<ScaffoldState>();
  ObtainedPoints obtainedPoints = new ObtainedPoints();

  @override
    void setState(VoidCallback fn) {
      super.setState(fn);
      debugPrint('Setting state');
      debugPrint('Down here we have ${obtainedPoints.points}');
    }

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
        key: homeScaffoldKey,
        appBar: new AppBar(
          title: new Text('Choose what to bring!'),
        ),
        floatingActionButton: new FloatingActionButton(
          tooltip: 'Participate to the party!',
          onPressed: null,
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
                  children: categoryCardListBuilder(),
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
                            '/' +
                            widget.party.pinderPoints.toString(),
                        style: new TextStyle(color: Colors.white),
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
}

/// Class for the obtained Pinder Points
/// It is necessary, since it's not possible to pass the primitive [int] as reference.
class ObtainedPoints {
  ObtainedPoints({this.points = 0});
  int points;
}
