/// drawer.dart
/// This file contains the code for Pindery's drawer
///

// External libraries imports
import 'package:flutter/material.dart';
import 'package:pindery/settings.dart';

// Internal imports
import 'theme.dart';
import 'user.dart';
import 'utils.dart';
import 'home_page/home_page.dart';

const String coverImagePath = "assets/img/movingParty.jpeg";

/// Default drawer for Pindery app
class PinderyDrawer extends StatelessWidget {
  PinderyDrawer({this.user});

  final User user;
  DrawerControllerState drawerControllerState = new DrawerControllerState();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text('${user.name} ${user.surname}'),
            accountEmail: new Text(user.email),
            currentAccountPicture: pinderyCircleAvatar(user),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(coverImagePath),
                fit: BoxFit.cover
              )
            ),
          ),
          //end container  with pics
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // TODO: understand how to make the drawer close is the user is already on the selected page
              new DrawerBlock(icon: Icons.star ,data: 'Parties', widgetBuilder: (context) => new HomePage(user)),
              new DrawerBlock(icon: Icons.face, data: 'My parties', /*widgetBuilder: (context) => new WelcomePage(),*/),
              new DrawerBlock(icon: Icons.settings ,data: 'Settings', widgetBuilder: (context) => new SettingsPage(),)
              ]
          )

        ],
      ),
    );
  }
}

class DrawerBlock extends StatelessWidget {
  DrawerBlock({this.data, this.icon, this.widgetBuilder});

  final String data;
  final IconData icon;
  final WidgetBuilder widgetBuilder;

  Widget build(BuildContext context) {
    return new Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: new BoxDecoration(
          border: new Border(bottom: new BorderSide(color: dividerColor))),
      child: new DefaultTextStyle(
        style: Theme.of(context).textTheme.subhead,
        child: new SafeArea(
            top: false,
            bottom: false,
            child: new ListTile(
              leading: new Icon(icon, color: secondary, size: 24.0),
              title: new Text(
                data,
                textAlign: TextAlign.start,
                style: new TextStyle(
                    fontSize: 14.0,
                    color: primaryLight,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.of(context).push(
                      MaterialPageRoute(builder: widgetBuilder),
                    );
              },
            )),
      ),
    );
  }
}
