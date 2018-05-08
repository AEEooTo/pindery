import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'catalogue/catalogue.dart';

/// Class that defines every Party object in the app.
class Party {
  Party({
    this.name,
    this.fromDayTime,
    this.toDayTime,
    this.organiser,
    this.place,
    this.rating,
    this.ratingNumber,
    this.privacy,
    this.pinderPoints,
    this.description,
    this.id,
    this.imageUrl,
    this.imageLocalPath,
    this.maxPeople,
    this.catalogue,
  });

  /// Constructor used to create a [Party] instance from a [DocumentSnapshot],
  /// which is, essentially, a [Map].
  // TODO: refractor the constructor's name to Party.fromSnapshot, I think it would be clearer
  Party.fromJSON(DocumentSnapshot snapshot) {
    name = snapshot['name'];
    place = snapshot['place'];
    description = snapshot['description'];
    imageUrl = snapshot['imageUrl'];
    fromDayTime = snapshot['fromDayTime'];
    toDayTime = snapshot['toDayTime'];
    privacy = snapshot['privacy'];
    catalogue = new Catalogue.fromFirestore(snapshot['catalogue']);
    id = snapshot.documentID;

    // TODO: implement the user and the Pinder-points
    organiser = 'Anna';
    rating = 3.5;
    ratingNumber = 23;
    pinderPoints = 6;
  }

  /// The name of the party.
  String name;

  /// The beginning day and time of the party, chosen by the organiser.
  DateTime fromDayTime;

  /// The UID of the organiser.
  String organiser;

  /// The place of the party.
  String place;

  /// The ending date and time of the party, chosen by the organiser.
  DateTime toDayTime;

  /// Url on Firebase Storage of the party's image.
  String imageUrl;

  /// The local path to the image chosen by the party organiser.
  File imageLocalPath;

  /// The default city used to show parties until we will introduce the possibility to choose the city.
  static const String city = "Shanghai";

  /// The rating of the organiser, will be deprecated, since it's a characteristic of [User] class.
  num rating;

  /// The number of ratings of the organiser, will be deprecated, since it's a characteristic of [User] class.
  int ratingNumber;

  /// The privacy of the party, it is an [int], since we use numbers to evaluate everything which is related to the categories.
  /// 0 corresponds to 'Public', 1 to 'Closed', 2 to 'Secret'.
  int privacy;

  /// The number of necessary pinder points to participate to the party.
  /// it will soon be deprecated, since the number of points is a property of [Catalogue] class.
  int pinderPoints;

  /// The description for the party. it is chosen by the organiser.
  String description;

  /// The ID on Firebase Firestore on the database, automatically assigned by Firestore.
  String id;

  /// The maximum number of people that can participate to the party, chosen by the organiser.
  int maxPeople;

  /// The [Catalogue] of the party.
  Catalogue catalogue;

  /// The names used for party's privacy.
  static const List<String> privacyOptions = ['Public', 'Closed', 'Secret'];

  /// The icons used for party's privacy.
  static const List<IconData> privacyOptionsIcons = [
    const IconData(0xe80b, fontFamily: 'MaterialIcons'),
    const IconData(0xe939, fontFamily: 'MaterialIcons'),
    const IconData(0xe897, fontFamily: 'MaterialIcons')
  ];

  CollectionReference get partiesCollectionReference => Firestore.instance
      .collection('cities')
      .document(city.toLowerCase())
      .collection('parties');

  /// Pushes the newly created party on the DB.
  Future<Null> addNewParty() async {
    // Firebase Firestore reference
    final CollectionReference reference = partiesCollectionReference;
    Duration timeoutDuration = new Duration(seconds: 30);
    try {
      reference
          .add(partyMapper())
          .catchError(() => throw new Exception('UPLOAD ERROR'))
          .timeout(timeoutDuration,
              onTimeout: () =>
                  throw new TimeoutException('TIMEOUT', timeoutDuration));
    } on TimeoutException {
      print(TimeoutException);
    } on Exception catch (e) {
      print('Error uploading the party, $e');
    }
  }

  /// Updates the existing party with the given ID.
  Future<Null> updateParty(String id) async {
    debugPrint('Updating the party');
    Duration timeoutDuration = new Duration(seconds: 30);
    final DocumentReference reference = partiesCollectionReference.document(id);
    try {
      await reference
          .setData(partyMapper())
          .catchError(() => throw new Exception('UPLOAD ERROR'))
          .timeout(timeoutDuration,
              onTimeout: () =>
                  throw new TimeoutException('TIMEOUT', timeoutDuration));
    } on TimeoutException {
      debugPrint('$TimeoutException');
    } on Exception catch (e) {
      debugPrint('Error uploading the party, $e');
    }
  }

  /// Creates a map from the Party instance to be pushed to Firestore.
  Map<String, dynamic> partyMapper() {
    Map<String, dynamic> partyMap = {
      "name": name,
      "place": place,
      "description": description,
      "fromDayTime": fromDayTime,
      "toDayTime": toDayTime,
      "imageUrl": imageUrl,
      "maxPeople": maxPeople,
      "privacy": privacy,
      "catalogue": catalogue.catalogueMatrixMapper(),
    };
    return partyMap;
  }

  /// Uploads the image requested by the user.
  Future<Null> uploadImage(File imageFile) async {
    print("uploading image"); //todo: remove debug print
    int random = new Random().nextInt(100000);
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("/partyImages/party_image_$random.jpg");
    StorageUploadTask uploadTask = ref.putFile(imageLocalPath);
    Duration timeoutDuration = new Duration(seconds: 30);
    try {
      UploadTaskSnapshot task = await uploadTask.future
          .timeout(timeoutDuration,
              onTimeout: () =>
                  throw new TimeoutException('TIMEOUT', timeoutDuration))
          .catchError(() => throw new Exception('UPLOAD ERROR'));
      Uri downloadUrl = task.downloadUrl;
      imageUrl = downloadUrl.toString();
    } on TimeoutException {
      print(TimeoutException);
    } on Exception catch (e) {
      print('Image upload exception, $e');
    }
  }

  /// Handles the participation to the party, updating the catalogue
  /// (adding the number of stuff that the participant is going to bring).
  /// TODO: In the future it will even handle the participants' profiles.
  void handleParticipation() async {
    debugPrint('Handling participation');
    Party party = await getPartyFromFirestore(id);
    debugPrint('\nIn handleParticipation the local catalogue is:');
    catalogue.printCatalogue();
    party.catalogue.update(catalogue);
    debugPrint('\nAfter update:');
    party.catalogue.printCatalogue();
    await party.updateParty(id);
    debugPrint('Done, theoretically');
  }

  /// Gets a party from Firestore, using the ID of the party.
  /// It is used to have an always up-to-date party (i.e. when, for example
  /// the participants need to update the catalogue with the items they are going to bring).
  Future<Party> getPartyFromFirestore(String id) async {
    DocumentReference reference = partiesCollectionReference.document(id);
    Party party;
    await reference.get().then((DocumentSnapshot partySnapshot) =>
        party = new Party.fromJSON(partySnapshot));
    return party;
  }
}
