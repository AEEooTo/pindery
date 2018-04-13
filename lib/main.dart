/// Welcome to Pindery, an amazing party app.
/// Visit [github.com/AEEooTo/pindery/README.md] for more information.
///

import 'package:flutter/material.dart';

import 'theme.dart';
import 'home_page.dart';

const loggedIn = true;

void main() => runApp(new Pindery());

class Pindery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pindery',
      theme: pinderyTheme,
      home: new PinderyHomePage(),
    );
  }
}