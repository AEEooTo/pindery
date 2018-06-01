/// Welcome to Pindery, an amazing party app.
/// Visit [github.com/AEEooTo/pindery/README.md] for more information.
///
import 'package:flutter/material.dart';

import 'user.dart';
import 'pindery.dart';

void main() async {
  // Overriding https://github.com/flutter/flutter/issues/13736 for better
  // visual effect at the cost of performance.
  MaterialPageRoute.debugEnableFadingRoutes =
      true; // ignore: deprecated_member_use
  User user = new User();
  user = await User.userDownloader(user: user);
  runApp(new Pindery(user));
}