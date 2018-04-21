import 'dart:math';

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
}
