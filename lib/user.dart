/// user.dart
/// file used for the [User] class
///

/// Class to define a [User] object
class User {
  String uid; /// Unique ID used by [firebase_auth]
  String name;
  String surname;
  String email;
  String profilePictureUrl;
  double rating;
  int numberOfReviews;
  double feedbackByOrganisers;
  double numberOfFeedbacks;
}