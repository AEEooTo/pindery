/// drawer.dart
/// This file contains the code for Pindery's drawer
///

// External libraries imports
import 'package:flutter/material.dart';

// Internal imports
import 'theme.dart';
import 'user.dart';
import 'utils.dart';

/// Default drawer for Pindery app
class PinderyDrawer extends StatelessWidget {
  PinderyDrawer({this.user, this.previousRoute});
  static const String coverImagePath = "assets/img/movingParty.jpeg";

  /// The route of the page on which the drawer was openes
  final String previousRoute;

  /// The user, used for the drawer's header
  final User user;
  final GlobalKey<DrawerControllerState> drawerKey =
      new GlobalKey<DrawerControllerState>();

  /// The elements of the drawer
  static const List<Map<String, dynamic>> _drawerContents = const [
    {'icon': Icons.star, 'data': 'Parties', 'route': '/'},
    {'icon': Icons.face, 'data': 'My Parties', 'route': 'null'},
    {'icon': Icons.settings, 'data': 'Settings', 'route': '/settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
          brightness: Brightness.light,
          accentColor: secondary,
          primaryColor: secondary,
          splashColor: tileBackgroundColor,
          selectedRowColor: tileBackgroundColor),
      child: new Drawer(
        key: drawerKey,
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('${user.name} ${user.surname}'),
              accountEmail: new Text(user.email),
              currentAccountPicture: new PinderyCircleAvatar(user: user),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage(coverImagePath), fit: BoxFit.cover),
              ),
            ),
            new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _drawerContents.map((Map<String, dynamic> contents) {
                return new DrawerBlock(
                  data: contents['data'],
                  icon: contents['icon'],
                  route: contents['route'],
                  drawerKey: drawerKey,
                  previousRoute: previousRoute,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// A block for the drawer
class DrawerBlock extends StatelessWidget {
  DrawerBlock(
      {this.data, this.icon, this.route, this.drawerKey, this.previousRoute});

  final String data;
  final IconData icon;
  final String route;
  final GlobalKey<DrawerControllerState> drawerKey;
  final String previousRoute;

  Widget build(BuildContext context) {
    return new ListTileTheme(
      style: ListTileStyle.drawer,
      textColor: Colors.black,
      iconColor: const Color(0xFF757575),
      dense: false,
      child: new ListTile(
        selected: (previousRoute == route),
        leading: new Icon(icon),
        title: new Text(
          data,
          textAlign: TextAlign.start,
          style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        ),
        onTap: () {
          if (route != previousRoute) {
            Navigator.popUntil(context, ModalRoute.withName('/'));
            if (route != '/') {
              Navigator.pushNamed(context, route);
            }
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
