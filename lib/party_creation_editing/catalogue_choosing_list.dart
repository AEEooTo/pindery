import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../catalogue/catalogue_element.dart';
import '../theme.dart';
import '../catalogue/catalogue.dart';

class CatalogueChoosingList extends StatelessWidget {
  CatalogueChoosingList({this.catalogue});

  static const String routeName = '/create-party/catalogue-choosing';

  final GlobalKey scaffoldKey = new GlobalKey<ScaffoldState>();

  final Catalogue catalogue;

  final Category drinksCategory = new Category(Categories.drinks.index);

  final Category foodCategory = new Category(Categories.food.index);

  final Category utilitiesCategory = new Category(Categories.utilities.index);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Choose something'),
      ),
      body: new Theme(
        data: pinderyTheme,
        child: new ListView(
          children: <Widget>[
            new CategoryTilesBlock(
              category: drinksCategory,
              catalogue: catalogue.catalogue[Categories.drinks.index],
            ),
            new CategoryTilesBlock(
              category: foodCategory,
              catalogue: catalogue.catalogue[Categories.food.index],
            ),
            new CategoryTilesBlock(
              category: utilitiesCategory,
              catalogue: catalogue.catalogue[Categories.utilities.index],
            ),
          ],
        ),
      ),
    );
  }
}

class CatalogueTileTitle extends StatelessWidget {
  CatalogueTileTitle({this.title, this.iconData});

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Icon(iconData),
          const SizedBox(width: 12.0),
          new Text(title),
        ],
      ),
    );
  }
}

class CategoryTilesList extends StatelessWidget {
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
        .collection(Catalogue.cataloguePath)
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
        List<DocumentSnapshot> documents = snapshot.data;
        List<CatalogueTile> catalogueSubList = <CatalogueTile>[];
        for (DocumentSnapshot document in documents) {
          CatalogueElement element = new CatalogueElement.fromFirestore(
              document.data, document.documentID);
          if (_isNotPresentInCatalogue(element)) {
            catalogueSubList.add(
                new CatalogueTile(element: element, catalogue: catalogue));
          }
        }
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
    return documents;
  }

  bool _isNotPresentInCatalogue(CatalogueElement element) {
    bool isNotPresent = true;
    for (CatalogueElement item in catalogue) {
      if (element.elementName == item.elementName) {
        isNotPresent = false;
      }
    }
    return isNotPresent;
  }

}

class CatalogueTile extends StatelessWidget {
  CatalogueTile({this.element, this.catalogue});

  final CatalogueElement element;
  final List<CatalogueElement> catalogue;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 32.0),
            new Expanded(child: new Text(element.elementName)),
            new Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: new Text(element.elementValue.toString()),
            )
          ],
        ),
      ),
      onTap: () {
        if (!catalogue.contains(element)) {
          catalogue.add(element);
        }
        Navigator.of(context).pop();
      },
    );
  }
}

class CategoryTilesBlock extends StatelessWidget {
  CategoryTilesBlock({this.category, this.catalogue});

  final Category category;
  final List<CatalogueElement> catalogue;

  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
      title: new CatalogueTileTitle(
          title: category.title, iconData: category.icon),
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Container(
              height: 32.0,
              child: new ListTile(
                title: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(width: 32.0),
                      new Expanded(
                        child: new Text(
                          'Name',
                          style: new TextStyle(
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              fontSize: 13.0),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: new Text(
                          'Value',
                          style: new TextStyle(
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              fontSize: 13.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new CategoryTilesList(
              categoryTypes: category.dbSubcategories,
              category: category.dbName,
              catalogue: catalogue,
            ),
          ],
        )
      ],
    );
  }
}

class Category {
  Category(this.index) {
    title = Catalogue.names[index];
    icon = Catalogue.icons[index];
    dbName = Catalogue.dbNames[index];
    dbSubcategories = Catalogue.dbSubCategories[index];
  }

  final int index;
  String title;
  IconData icon;
  String dbName;

  List<String> dbSubcategories;
}
