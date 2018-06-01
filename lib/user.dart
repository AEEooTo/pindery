/// Manages the user of the application.
library user;

// Dart core imports
import 'dart:async';

// External libraries imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Class to define the application's user
class User {
  User({this.email, this.name, this.surname, this.profilePictureUrl, this.uid});

  void fromFirestore(DocumentSnapshot snapshot) {
    email = snapshot['email'];
    name = snapshot['name'];
    surname = snapshot['surname'];
    profilePictureUrl = snapshot['profilePictureUrl'];
    uid = snapshot['uid'];
  }

  static Future<User> userDownloader({User user, String uid}) async {
    user ??= new User();
    if (uid == null) {
      FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
      if (firebaseUser == null) {
        return user;
      }
      uid = firebaseUser.uid;
    }
    DocumentReference userReference =
        Firestore.instance.collection(User.usersDbPath).document(uid);
    // TODO: catch exceptions
    DocumentSnapshot userOnDb = await userReference.get();
    user.fromFirestore(userOnDb);
    return user;
  }

  /// Unique ID used by [firebase_auth].
  String uid;

  /// The user's name.
  String name;

  /// The user's surname.
  String surname;

  /// The user's email.
  String email;

  /// The URL of the profile picture of the user, hosted on Firebase Storage.
  String profilePictureUrl;

  /// The rating given to the user, by the participants to the parties the user organised.
  double rating;

  /// The number of reviews the user was given by the participants to the parties the user organised.
  int numberOfReviews;

  /// The number of thumbs-ups given by the organisers of the parties the user took part to.
  /// See [feedback].
  int thumbsUpByOrganisers;

  /// The total number of feedbacks (thumbs-ups and thumb-downs) received by the user as
  /// participant to parties. See [feedback].
  int numberOfFeedbacks;

  /// The feedback (in percentage) of the user as participant to the party.
  /// This is related to the reliability of the user in bringing what he is supposed to.
  double get feedback => (thumbsUpByOrganisers / numberOfFeedbacks) * 100;

  /// The path to the user collection on the DB.
  static const String usersDbPath = 'users';

  /// Uploads the user on the DB, it is used during the creation of the user,
  /// within [SignUpButton].
  Future<Null> sendUser() async {
    print('sending user...');
    Duration timeoutDuration = new Duration(seconds: 60);
    final DocumentReference reference =
        Firestore.instance.collection('users').document(uid);
    try {
      await reference
          .setData(_userMapper())
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

  /// Creates a [Map] starting from the data of the user, in order to
  /// upload the data on the DB.
  Map<String, dynamic> _userMapper() {
    return {
      'name': name,
      'surname': surname,
      'uid': uid,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
