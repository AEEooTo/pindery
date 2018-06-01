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

  final String previousRoute;
  final User user;
  final GlobalKey<DrawerControllerState> drawerKey =
      new GlobalKey<DrawerControllerState>();

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      key: drawerKey,
      child: new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              margin: null,
              accountName: new Text('${user.name} ${user.surname}'),
              accountEmail: new Text(user.email),
              currentAccountPicture: new PinderyCircleAvatar(user: user),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage(coverImagePath), fit: BoxFit.cover),
              ),
            ),
            new Column(
              children: <Widget>[
                // TODO: understand how to make the drawer close is the user is already on the selected page
                new DrawerBlock(
                  icon: Icons.star,
                  data: 'Parties',
                  route: '/',
                  drawerKey: drawerKey,
                  previousRoute: previousRoute,
                ),
                new DrawerBlock(
                  icon: Icons.face,
                  data: 'My parties',
                  // widgetBuilder: (context) => new WelcomePage(),
                  drawerKey: drawerKey,
                  previousRoute: previousRoute,
                ),
                new DrawerBlock(
                  icon: Icons.settings,
                  data: 'Settings',
                  route: '/settings',
                  drawerKey: drawerKey,
                  previousRoute: previousRoute,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerBlock extends StatelessWidget {
  DrawerBlock(
      {this.data, this.icon, this.route, this.drawerKey, this.previousRoute});

  final String data;
  final IconData icon;
  final String route;
  final GlobalKey<DrawerControllerState> drawerKey;
  final String previousRoute;

  Widget build(BuildContext context) {
    return new DefaultTextStyle(
      style: Theme.of(context).textTheme.subhead,
      child: new SafeArea(
        top: false,
        bottom: false,
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new InkWell(
            splashColor: tileBackgroundColor,
            highlightColor: tileBackgroundColor,
            enableFeedback: true,
            onTap: () => print('pippo'),
            child: new Container(
              padding: const EdgeInsets.all(8.0),
              height: 40.0,
              decoration: new BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(6.0)),
                  color: tileColor()),
              child: new ListTileTheme(
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
                    style: new TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    if (route != previousRoute) {
                      Navigator
                          .of(context)
                          .popUntil((ModalRoute.withName('/')));
                      if (route != '/') {
                        Navigator.of(context).pushNamed(route);
                      }
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color tileColor() {
    if (route == previousRoute) {
      return tileBackgroundColor;
    }
    return Colors.white;
  }
}
