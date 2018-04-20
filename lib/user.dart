/// user.dart
/// file used for the [User] class
///

// Dart core imports
import 'dart:async';

// External libraries imports
import 'package:cloud_firestore/cloud_firestore.dart';

/// Class to define a [User] object
class User {
  User({this.email, this.name, this.surname, this.profilePictureUrl, this.uid});

  User.fromFirestore(DocumentSnapshot snapshot) {
    email = snapshot['email'];
    name = snapshot['name'];
    surname = snapshot['surname'];
    profilePictureUrl = snapshot['profilePictureUrl'];
  }

  String uid;

  /// Unique ID used by [firebase_auth]
  String name;
  String surname;
  String email;
  String profilePictureUrl;
  double rating;
  int numberOfReviews;
  double feedbackByOrganisers;
  double numberOfFeedbacks;
  static const usersDbPath = 'users';

  Future<Null> sendUser() async {
    print('sending user...');
    Duration timeoutDuration = new Duration(seconds: 60);
    final DocumentReference reference =
        Firestore.instance.collection('users').document(uid);
    try {
      await reference
          .setData(userMapper())
          .timeout(timeoutDuration,
              onTimeout: () =>
                  throw new TimeoutException('TIMEOUT', timeoutDuration))
          .catchError(() => throw Exception);
    } on TimeoutException {
      print(TimeoutException);
    } on Exception catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> userMapper() {
    return {
      'name': name,
      'surname': surname,
      'uid': uid,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
