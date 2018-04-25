/// Some utils for the app
///

// External libraries imports
import 'package:flutter/material.dart';

// Internal imports
import 'user.dart';
import 'theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// A [CircleAvatar] which checks whether the user has a profile picture or not
/// Actually if the user has a picture, it's not a [CircleAvatar], but a 
/// [MaterialType.circle], so that the image can be cached with a [CachedNetworkImage].
/// There is also the user's initial as placeholder while downloading and in case of error.
class PinderyCircleAvatar extends StatelessWidget {
  PinderyCircleAvatar({this.user, this.radius = 72.0});
  /// The [User] whose image/name is used for the widget
  final User user;

  // The the radius of the circle
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (user.profilePictureUrl == null) {
      return new CircleAvatar(
        radius: radius,
        child: new UserInitialWidget(name: user.name),
        backgroundColor: secondary,
      );
    }
    return new Container(
      height: radius,
      width: radius,
      child: new Material(
        color: secondary,
        type: MaterialType.circle,
        child: new CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: user.profilePictureUrl,
          placeholder: new UserInitialWidget(name: user.name),
          errorWidget: new UserInitialWidget(name: user.name),
        ),
      ),
    );
  }
}

/// A [Widget] that returns a [Center] widget with the initial of the name passed
/// as parameter, to be used with [PinderyCircleAvatar].
class UserInitialWidget extends StatelessWidget {
  UserInitialWidget({this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        name[0],
        style: new TextStyle(color: Colors.white, fontSize: 30.0),
      ),
    );
  }
}
