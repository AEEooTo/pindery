import 'package:flutter/material.dart';

final String name = "Edoardo Debenedetti";
final String coverImagePath = "assets/img/movingParty.jpeg";
final String avatarPath = "assets/img/avatar.jpg";

class PinderyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
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
        )
      ],
    );
  }
}
