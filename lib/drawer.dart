/// drawer.dart
/// This file contains the code for Pindery's drawer
///

import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:pindery/first_actions/welcome.dart';
import 'package:pindery/settings.dart';
import 'package:pindery/first_actions/welcome.dart';


const String name = "Edoardo Debenedetti";
const String email = "e@pindery.com";
const String coverImagePath = "assets/img/movingParty.jpeg";
const String avatarPath = "assets/img/avatar.jpg";

/// Default drawer for Pindery app
class PinderyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(name),
            accountEmail: new Text(email),
            currentAccountPicture: new CircleAvatar(backgroundImage: new AssetImage(avatarPath),),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(coverImagePath),
                fit: BoxFit.cover
              )
            ),
          ),
          //end container  with pics
          new Container(
            width: 305.0,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new DrawerBlock(icon: Icons.star ,data: 'Parties', /*widgetBuilder: (context) => new WelcomePage(),*/),
                new DrawerBlock(icon: Icons.face, data: 'My parties', /*widgetBuilder: (context) => new WelcomePage(),*/),
                new DrawerBlock(icon: Icons.settings ,data: 'Settings', widgetBuilder: (context) => new SettingsPage(),)
                ]
            )
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
