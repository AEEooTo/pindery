/// Some utils for the app
/// 

// External libraries imports
import 'package:flutter/material.dart';

// Internal imports
import 'user.dart';
import 'theme.dart';

Widget pinderyCircleAvatar(User user) {
    if (user.profilePictureUrl == null) {
      return new CircleAvatar(
        child: Text(
          user.name[0],
          style: new TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        backgroundColor: secondary,
      );
    }
    return new CircleAvatar(
      backgroundImage: new NetworkImage(user.profilePictureUrl),
    );
}