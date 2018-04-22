// External imports
import 'package:flutter/material.dart';

// Internal imports
import '../catalogue/catalogue_element.dart';
import 'category_card_list.dart';

const String partyStuffCollection = "party_stuff";

class ItemCard extends StatelessWidget {
  ItemCard({this.catalogueSublist, this.category, this.assetImage});

  final List<CatalogueElement> catalogueSublist;
  final String category;
  final AssetImage assetImage;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
      child: Column(
        children: <Widget>[
          new Material(
            borderRadius: new BorderRadius.vertical(top: new Radius.circular(2.0)),
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
            ),
          ),
        ],
      ),
    );
  }

  /// Computes the height of the [Container]
  double containerHeight() {
    const double expansionPanelHeight = 48.0;
    double height = catalogueSublist.length * expansionPanelHeight;
    height -= height * 0.2;
    return height;
  }
}

// ME TRYING TO COPY STUFF FROM EDO - OFC STILL WORK IN PROGRESS
/*class CategoryTilesList extends StatelessWidget {
  CategoryTilesList({this.category, this.categoryTypes, this.catalogue});

  final String category;
  final List<String> categoryTypes;
  final List<CatalogueElement> catalogue;

  @override
  Widget build(BuildContext context) {
    return _catalogueListBuilder();
  }

  Widget _catalogueListBuilder() {
    List<Widget> catalogueList = <Widget>[];
    for (String categoryType in categoryTypes) {
      catalogueList.add(_categorySubListBuilder(
          categoryType, categoryTypes.indexOf(categoryType)));
    }
    return new Column(
      children: catalogueList,
    );
  }

  Widget _categorySubListBuilder(String categoryType, int index) {
    CollectionReference reference = Firestore.instance
        .collection(partyStuffCollection)
        .document(category)
        .collection(categoryType);
    return new FutureBuilder(
      future: _getDocuments(reference),
      builder: (BuildContext context,
          AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        if (!snapshot.hasData) {
          if (index != 0) {
            return Container();
          }
          return new Container(
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text('Loading...'),
            ),
          );
        }
        List<ListItem> catalogueSubList = <ListItem>[];
        return new Column(
          children: catalogueSubList,
        );
      },
    );
  }

  Future<List<DocumentSnapshot>> _getDocuments(
      CollectionReference reference) async {
    QuerySnapshot documentsQuery = await reference.getDocuments();
    List<DocumentSnapshot> documents = documentsQuery.documents;
    for (DocumentSnapshot document in documents) {
      print('the element name is ' + document.data['name']);
    }
    print('In _getDocuments the documents length is: ' +
        documents.length.toString());
    return documents;
  }
}*/
