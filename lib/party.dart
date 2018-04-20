import 'dart:async';
import 'dart:math' ;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'catalogue_element.dart';

/// Class that defines every Party object in the app.
class Party {
  Party({this.name,
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

  Party.fromJSON(DocumentSnapshot snapshot) {
    name = snapshot['name'];
    place = snapshot['place'];
    description = snapshot['description'];
    imageUrl = snapshot['imageUrl'];
    fromDayTime = snapshot['fromDayTime'];
    toDayTime = snapshot['toDayTime'];
    privacy = snapshot['privacy'];
    id = snapshot.documentID;

    // TODO: implement the user and the Pinder-points
    organiser = 'Anna';
    rating = 3.5;
    ratingNumber = 23;
    pinderPoints = 6;
  }

  String name;
  DateTime fromDayTime;
  String organiser;
  String place;
  DateTime toDayTime;
  String imageUrl;
  File imageLocalPath; // REALLY used to upload the image to Firebase storage, but is intended just for use on user's device
  String city = "Shanghai";
  num rating;
  int ratingNumber;
  int privacy;
  int pinderPoints;
  String description;
  String id;
  int maxPeople;
  List<CatalogueElement> catalogue;

  static const List<String> privacyOptions = ['Public', 'Closed', 'Secret'];
  static const List<IconData> privacyOptionsIcons = [
    const IconData(0xe80b, fontFamily: 'MaterialIcons'),
    const IconData(0xe939, fontFamily: 'MaterialIcons'),
    const IconData(0xe897, fontFamily: 'MaterialIcons')
  ];

  /// Method to push the party on the DB
  Future<Null> sendParty() async {
    print('Sending party');
    // Firebase Firestore reference
    final CollectionReference reference = Firestore.instance
        .collection('cities')
        .document(city.toLowerCase())
        .collection('parties');
    Duration timeoutDuration = new Duration(seconds: 30);
    try {
      reference.add(partyMapper())
      .catchError(() => throw new Exception('UPLOAD ERROR'))
      .timeout(timeoutDuration, onTimeout: () => throw new TimeoutException('TIMEOUT', timeoutDuration));
    } on TimeoutException {
      print(TimeoutException);
    } on Exception catch (e) {
      print('Error uploading the party, $e');
    }

  }

  /// Method to create a map from the Party instance to be pushed to Firestore
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
      "catalogue": catalogueMapper()
    };
    return partyMap;
  }

  List<Map<String, dynamic>> catalogueMapper() {
    List<Map<String, dynamic>> catalogueMap = <Map<String, dynamic>>[];
    for (CatalogueElement element in catalogue) {
      catalogueMap.add(element.catalogueMapper());
    }
    return catalogueMap;
  }

  Future<Null> uploadImage(File imageFile) async {
    print("uploading image"); //todo: remove debug print
    int random = new Random().nextInt(100000);
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("/partyImages/party_image_$random.jpg");
    StorageUploadTask uploadTask = ref.put(imageLocalPath);
    Duration timeoutDuration = new Duration(seconds: 30);
    try {
      UploadTaskSnapshot task = await uploadTask.future
      .timeout(timeoutDuration, onTimeout: () => throw new TimeoutException('TIMEOUT', timeoutDuration))
      .catchError(() => throw new Exception('UPLOAD ERROR'));
      Uri downloadUrl = task.downloadUrl;
    imageUrl = downloadUrl.toString();
    } on TimeoutException {
      print(TimeoutException);
    } on Exception catch (e) {
      print('Image uplad exception, $e');
    }
  }
}
