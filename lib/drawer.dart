/// drawer.dart
/// This file contains the code for Pindery's drawer
///

import 'package:flutter/material.dart';
import 'theme.dart';
import 'welcome.dart';

final String name = "Edoardo Debenedetti";
final String coverImagePath = "assets/img/movingParty.jpeg";
final String avatarPath = "assets/img/avatar.jpg";

/// Default drawer for Pindery app
class PinderyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: new Column(
        children: <Widget>[
          new Container(
            height: 172.0,
            width: 305.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(coverImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.all(16.0),
                  height: 64.0,
                  width: 64.0,
                  child: new CircleAvatar(
                    backgroundImage: new AssetImage(avatarPath),
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.only(left: 16.0),
                  child: new Text(
                    name,
                    style: new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
          //end container  with pics
          new Container(

            width: 305.0,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new DrawerBlock(icon: Icons.star ,data: 'Parties', widgetBuilder: (context) => new WelcomePage(),),
                new DrawerBlock(icon: Icons.face, data: 'My parties',),
                new DrawerBlock(icon: Icons.settings ,data: 'Settings',)
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
          border: new Border(bottom: new BorderSide(color: dividerColor))
      ),
      child: new DefaultTextStyle(
        style: Theme.of(context).textTheme.subhead,
        child: new SafeArea(
          top: false,
          bottom: false,
          child: new ListTile(
            leading: new Icon(icon,color: secondary, size: 24.0),
            title: new Text(
                data,
                textAlign: TextAlign.start,
                style: new TextStyle(
                    fontSize: 14.0,
                    color: primaryLight,
                    fontWeight: FontWeight.w600
                ),
            ),
            onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: widgetBuilder),
              );
            },
          )
        ),
      ),
    );
  }

}