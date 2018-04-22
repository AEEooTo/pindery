/// This file contains the code for Pindery's page where to choose what to bring to a party.
///

// External imports
import 'package:flutter/material.dart';

// Internal imports
import 'category_card.dart';
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
  int obtainedPinderPoints = 4;

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: pinderyTheme.copyWith(brightness: Brightness.light),
      child: new Scaffold(
        key: homeScaffoldKey,
        appBar: new AppBar(
          title: new Text('Choose what you will bring'),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: null,
          child: new Icon(Icons.arrow_forward),
          backgroundColor: secondary,
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                color: primary,
                child: new ListView(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  children: categoryCardListBuilder(),
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
                      'Pinder Points:  ' +
                          obtainedPinderPoints.toString() +
                          '/' +
                          widget.party.pinderPoints.toString(),
                      style: new TextStyle(color: Colors.white),
                    ),
                  ),
                ],
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
        ));
      }
    }

    return itemCardList;
  }
}
