import 'package:flutter/material.dart';
import 'catalogue_element.dart';

enum Categories { drinks, food, utilities }

/// The class which manages the party catalogue
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
  static const List<String> pics = const <String>[
    "assets/img/beer_2.jpg",
    "assets/img/pasta.jpeg",
    "assets/img/kittens.jpeg"
  ];

  /// Names for the different categories
  static const List<String> names = const <String>[
    "Drinks",
    "Food",
    "Utilities"
  ];

  /// Names on the database of the different categories paths
  static const List<String> dbNames = const <String>[
    "drinks",
    "food",
    "utilities"
  ];

  /// Paths for the different subcategories
  static const List<List<String>> dbSubCategories = const <List<String>>[
    const <String>['alcohol', 'soft_drinks'],
    const <String>['simple_food'],
    const <String>['to_eat', 'to_drink'],
  ];

  /// [IconData] for the different categories
  static const List<IconData> icons = const <IconData>[
    Icons.local_bar,
    Icons.local_pizza,
    Icons.settings
  ];

  /// The path to the catalogue on the Database
  static const String cataloguePath = 'party_stuff';

  /// Number of cateogries in the [Catalogue] instance
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

  /// Updates the [chosenQuantity] fields in all the elements of the catalogue
  /// based on the [locallyChosenQuantyty] fields. It takes an up-to-date [Catalogue] instance,
  /// syncronized with Firestore, and adds up the quantity of every element chosen
  /// by the participants.
  void update(Catalogue upToDateCatalogue) {
    debugPrint('\nIn update:\nupToDateCatalogue:');
    upToDateCatalogue.printCatalogue();
    debugPrint('\nlocalCatalogue:');
    printCatalogue();
    for (int i = 0; i < this.catalogue.length; ++i) {
      for (int j = 0; j < this.catalogue[i].length; ++j) {
        catalogue[i][j].chosenQuantity += upToDateCatalogue.catalogue[i][j].locallyChosenQuantity;
      }
    }
  }

  /// Prints the [catalogue] field, for debuggng purposes
  void printCatalogue() {
    for (int i = 0; i < catalogue.length; ++i) {
      debugPrint(i.toString());
      for (int j = 0; j < catalogue[i].length; ++j) {
        debugPrint(
            '${catalogue[i][j].elementName} locallyChosen: ${catalogue[i][j].locallyChosenQuantity}, chosen: ${catalogue[i][j].chosenQuantity}');
      }
    }
  }
}
