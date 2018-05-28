
/// External imports
import 'package:flutter/material.dart';

/// Manages the privacy of the parties
class Privacy {

  /// The privacy of the party, it is an [int], since we use numbers to evaluate everything which is related to the categories.
  /// 0 corresponds to 'Public', 1 to 'Closed', 2 to 'Secret'.
  int type = 0;
  
  /// The names used for party's privacy.
  static const List<String> options = ['Public', 'Closed', 'Secret'];

  /// The icons used for party's privacy.
  static const List<IconData> optionsIcons = [
    const IconData(0xe80b, fontFamily: 'MaterialIcons'),
    const IconData(0xe939, fontFamily: 'MaterialIcons'),
    const IconData(0xe897, fontFamily: 'MaterialIcons')
  ];

}