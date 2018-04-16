import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' show TimeOfDay;

/// Class that defines every Party object in the app.
class Party {
  Party({this.name,
    this.fromDay,
    this.fromTime,
    this.toTime,
    this.toDay,
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
  });

  Party.fromJSON(DocumentSnapshot snapshot) {
    name = snapshot['name'];
    place = snapshot['place'];
    description = snapshot['description'];
    imageUrl = snapshot['imageUrl'];
    fromDay = snapshot['fromDay'];
    fromTime = snapshot['fromTime'];
    toDay = snapshot['toDay'];
    toTime = snapshot['toTime'];

    //TODO: implement the rest of the function after standardizing datetime
    organiser = 'Anna ovviamente';
    rating = 1;
    ratingNumber = 23;
    privacy = 'Public';
    id = '1';
    pinderPoints = 6;
  }

  String name;
  DateTime fromDay;
  String organiser;
  String place;
  String fromTime;
  DateTime toDay;
  String toTime;
  String imageUrl;
  File imageLocalPath; // REALLY used to upload the image to Firebase storage, but is intended just for use on user's device
  String city = "Shanghai";
  num rating;
  int ratingNumber;
  String privacy;
  int pinderPoints;
  String description;
  String id;
  int maxPeople;

  /// Method to push the party on the DB
  Future<Null> sendParty() async {
    // Firebase Firestore reference
    final reference = Firestore.instance
        .collection('cities')
        .document(city.toLowerCase())
        .collection('parties');
    reference.add(partyMapper());
  }

  /// Method to create a map from the Party instance to be pushed to Firestore
  Map<String, dynamic> partyMapper() {
    Map<String, dynamic> partyMap = {
      "name": name,
      "place": place,
      "description": description,
      "fromDay": fromDay,
      "fromTime": fromTime.toString(),
      "toDay": toDay,
      "toTime": toTime.toString(),
      "imageUrl": imageUrl,
      "maxPeople": maxPeople,
    };
    return partyMap;
  }

  Future<Null> uploadImage(File imageFile) async {
    int random = new Random().nextInt(100000);
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("/partyImages/party_image_$random.jpg");
    StorageUploadTask uploadTask = ref.put(imageFile);
    Uri downloadUrl = (await uploadTask.future).downloadUrl;
    imageUrl = downloadUrl.toString();
  }
}
