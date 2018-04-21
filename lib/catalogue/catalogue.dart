import 'package:flutter/material.dart';
import 'catalogue_element.dart';

enum Categories { drinks, food, utilities }

class Catalogue {
  Catalogue({this.catalogue});

  /// Constructor for the initialization in the creation of a party
  Catalogue.initialization() {
    catalogue = _catalogueInitializer();
  }

  /// Constructor for the creation of the catalogue when downloaded from Firestore
  Catalogue.fromFirestore(Map catalogueMap) {
    catalogue = _catalogueInitializer();
    for (int i = 0; i < catalogue.length; ++i) {
      if (catalogueMap[i.toString()] != null) {
        catalogue[i] = _catalogueMapLister(catalogueMap[i.toString()]);
      }
    }
  }

  /// Matrix with the different [CatalogueElement]s
  List<List<CatalogueElement>> catalogue;

  int totalPoints;

  /// Background images for the cards
  static const List<String> pics = [
    "assets/img/beer_2.jpg",
    "assets/img/pasta.jpeg",
    "assets/img/kittens.jpeg"
  ];

  /// Names for the different categories
  static const List<String> names = ["Drinks", "Food", "Utilities"];

  /// Names on the database of the different categories paths
  static const List<String> dbNames = ["drinks", "food", "utilities"];

  /// Paths for the different subcategories
  static const List<List<String>> dbSubCategories = [
    ['alcohol', 'soft_drinks'],
    ['simple_food'],
    ['to_eat', 'to_drink'],
  ];

  /// Icons for the different categories
  static const List<IconData> icons = [
    Icons.local_bar,
    Icons.local_pizza,
    Icons.settings
  ];

  int get numberOfCategories => catalogue.length;

  /// Returns the number of Pinder-points for the current [Catalogue] instance
  int ppp(int numberOfPeople) => (totalPoints / numberOfPeople).ceil();

  /// Creates a matrix of Maps representing each [CatalogueElement]
  Map<String, Map<String, Map<String, dynamic>>> catalogueMatrixMapper() {
    Map<String, Map<String, Map<String, dynamic>>> catalogueMatrixMap = {};
    for (int i = 0; i < catalogue.length; ++i) {
      catalogueMatrixMap[i.toString()] = catalogueListMapper(catalogue[i]);
    }
    return catalogueMatrixMap;
  }

  /// Creates a list of Maps representing each [CatalogueElement] to be added with the [CatalogueMatrixMapper()]
  Map<String, Map<String, dynamic>> catalogueListMapper(
      List<CatalogueElement> catalogueList) {
    Map<String, Map<String, dynamic>> catalogueListMap = {};
    for (int i = 0; i < catalogueList.length; ++i) {
      catalogueListMap[i.toString()] =
          catalogueList[i].catalogueElementMapper();
    }
    return catalogueListMap;
  }

  /// Initializes the [catalogue] field
  List<List<CatalogueElement>> _catalogueInitializer() {
    List<List<CatalogueElement>> catalogueList = <List<CatalogueElement>>[];
    for (int i = 0; i < Catalogue.names.length; ++i) {
      catalogueList.add(<CatalogueElement>[]);
    }
    return catalogueList;
  }

  /// Creates a [List] from a Map of [CatalogueElement]s
  List<CatalogueElement> _catalogueMapLister(Map catalogueMap) {
    List<CatalogueElement> catalogueList = <CatalogueElement>[];
    for (int i = 0; catalogueMap[i.toString()] != null; ++i) {
      catalogueList
          .add(new CatalogueElement.fromMap(catalogueMap[i.toString()]));
    }
    return catalogueList;
  }

  /// Checks if the [catalogue] and its [List]s are empty
  bool get isEmpty => _isEmpty();

  /// implementation of [isEmpty]
  bool _isEmpty() {
    for (int i = 0; i < Catalogue.names.length; ++i) {
      if (catalogue[i].isNotEmpty) {
        return false;
      }
    }
    return true;
  }

  void printCatalogue() {
    for (int i = 0; i < catalogue.length; ++i) {
      print(i);
      for (int j = 0; j < catalogue[i].length; ++j) {
        print(catalogue[i][j].elementName);
      }
    }
  }
}
