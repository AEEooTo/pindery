/// Some utils for the app
/// 

// External libraries imports
import 'package:flutter/material.dart';

// Internal imports
import 'user.dart';
import 'theme.dart';

/// A [CircleAvatar] which checks whether the user has a profile picture or not
class PinderyCircleAvatar extends StatelessWidget{
  PinderyCircleAvatar({this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    if (user.profilePictureUrl == null) {
      return new CircleAvatar(
        child: new Text(
          user.name[0],
          style: new TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        backgroundColor: secondary,
      );
    }
    return new CircleAvatar(
      backgroundImage: new NetworkImage(user.profilePictureUrl),
      backgroundColor: secondary,
    );
  }
}