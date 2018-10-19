/// Welcome to Pindery, an amazing party app.
/// Visit [github.com/AEEooTo/pindery/README.md] for more information.
///
import 'package:flutter/material.dart';

import 'user.dart';
import 'pindery.dart';

void main() async {
  User user = new User();
  user = await User.userDownloader(user: user);
  runApp(new Pindery(user));
}