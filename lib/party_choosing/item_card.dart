// External imports
import 'package:flutter/material.dart';

// Internal imports
import '../catalogue/catalogue_element.dart';
import 'item_card_list.dart';
import 'take_part_page.dart';

const String partyStuffCollection = "party_stuff";

class ItemCard extends StatelessWidget {
  ItemCard(
      {this.catalogueSublist,
      this.category,
      this.assetImage,
      this.obtainedPoints,
      this.takePartPageState});

  final List<CatalogueElement> catalogueSublist;
  final String category;
  final AssetImage assetImage;
  final ObtainedPoints obtainedPoints;
  final State<TakePartPage> takePartPageState;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
      child: Column(
        children: <Widget>[
          new Material(
            borderRadius:
                new BorderRadius.vertical(top: new Radius.circular(2.0)),
            elevation: 100.0,
            child: new Container(
              height: 100.0,
              decoration: new BoxDecoration(
                image:
                    new DecorationImage(image: assetImage, fit: BoxFit.cover),
              ),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: new Text(
                      category,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: new ListItem(
              elementsList: catalogueSublist,
              obtainedPoints: obtainedPoints,
              takePartPageState: takePartPageState,
            ),
          ),
        ],
      ),
    );
  }
}
