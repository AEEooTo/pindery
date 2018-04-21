import 'package:flutter/material.dart';
import 'catalogue_element.dart';


enum Categories { drinks, food, utilities }

class Catalogue {
  Catalogue({this.catalogue});

  List<List<CatalogueElement>> catalogue;

  int totalPoints;

  static const List<String> pics = [
    "assets/img/beer_2.jpg",
    "assets/img/pasta.jpeg",
    "assets/img/kittens.jpeg"
  ];

  static const List<String> names = ["Drinks", "Food", "Utilities"];

  static const List<String> dbNames = ["drinks", "food", "utilities"];

  static const List<List<String>> dbSubCategories = [
    ['alcohol', 'soft_drinks'],
    ['simple_food'],
    ['to_eat'],
  ];

  static const List<IconData> icons = [Icons.local_bar,Icons.local_pizza, Icons.settings];

  int get numberOfCategories => catalogue.length;

  int ppp(int numerOfPeople) => (totalPoints / numerOfPeople).ceil();
  // TODO: write methods for the class

  /// Creates a matrix of Maps representing each [CatalogueElement]
  Map<String, Map<String, Map<String, dynamic>>> catalogueMatrixMapper() {
    Map<String, Map<String, Map<String, dynamic>>> catalogueMatrixMap = {};
    for (int i = 0; i < catalogue.length; ++i) {
      catalogueMatrixMap[i.toString()] = catalogueListMapper(catalogue[i]);
    }
    return catalogueMatrixMap;
  }

  /// Creates a list of Maps representing each [CatalogueElement] to be added with the [CatalogueMatrixMapper()]
  Map<String, Map<String, dynamic>> catalogueListMapper(List<CatalogueElement> catalogueList) {
    Map<String, Map<String, dynamic>> catalogueListMap = {};
    for (int i = 0; i < catalogueList.length; ++i) {
      catalogueListMap[i.toString()] = catalogueList[i].catalogueElementMapper();
    }
    return catalogueListMap;
  }


  bool get isEmpty => _isEmpty();
  
  /// Checks if the [catalogue] and its [List]s are empty
  bool _isEmpty() {
    for (int i = 0; i < Catalogue.names.length; ++i) {
      if (catalogue[i].isNotEmpty) {
        return false;
      }
    }
    return true;
  }
    
}