import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Class that defines every Party object in the app.
class Party {
  Party(
      {this.name,
      this.day,
      this.fromTime,
      this.toTime,
      this.toDay,
      this.imagePath,
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
      });
  String name;
  String day;
  String imagePath; // used for local assets, to let Anna work offline
  String organiser;
  String place;
  String fromTime;
  String toDay;
  String toTime;
  String imageUrl;
  File imageLocalPath; // REALLY used to upload the image to Firebase storage, but is intended just for use on user's device
  final String city = "Shanghai";
  final num rating;
  final int ratingNumber;
  final String privacy;
  final int pinderPoints;
  String description;
  final String id;

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
  Map<String, String> partyMapper() {
    Map<String, String> partyMap = {
      "name": name,
      "place": place,
      "description": description,
      "fromDay": day,
      "fromTime": fromTime,
      "toDay": toDay,
      "toTime": toTime,
      "imageUrl": imageUrl,
    };
    return partyMap;
  }

  Future<Null> uploadImage(File imageFile) async {
    int random = new Random().nextInt(100000);
    StorageReference ref = FirebaseStorage.instance.ref().child("/partyImages/party_image_$random.jpg");
    StorageUploadTask uploadTask = ref.put(imageFile);
    Uri downloadUrl = (await uploadTask.future).downloadUrl;
    imageUrl = downloadUrl.toString();
  }

  static List<Party> partyGenerator() {
    List<Party> partyList = new List(5);
    partyList[0] = new Party(
        name: 'Kittens Party',
        day: 'Every day',
        imagePath: 'assets/img/kittens.jpeg',
        organiser: 'Anna ovviamente',
        place: 'Corso Cosenza 32, Torino',
        rating: 1,
        ratingNumber: 23,
        privacy: 'Public',
        id: '1',
        pinderPoints: 6,
        description:
            'Sounds like a nice party!\nEspecially if you like cats..');
    partyList[1] = new Party(
        name: 'Classical Party',
        day: 'Tomorrow',
        imagePath: 'assets/img/classicalParty.jpeg',
        organiser: 'Anna Tranquillini',
        place: 'Cao an highway 4800, Shanghai',
        rating: 2,
        ratingNumber: 24,
        privacy: 'Public',
        pinderPoints: 7,
        description:
            'lorem ipsum, quia dolor sit, amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit, qui in ea voluptate velit esse, quam nihil molestiae consequatur, vel illum, qui dolorem eum fugiat, quo voluptas nulla pariatur? [33] At vero eos et accusamus et iusto odio dignissimos ducimus, qui blanditiis praesentium voluptatum deleniti atque corrupti, quos dolores et quas molestias excepturi sint, obcaecati cupiditate non provident, similique ',
        id: '2');
    partyList[2] = new Party(
      name: 'Fancy Party',
      day: 'Today',
      imagePath: 'assets/img/proseccoParty.jpg',
      organiser: 'Ginuo',
      place: 'Wantai district, Anshan',
      rating: 3,
      ratingNumber: 25,
      privacy: 'Public',
      pinderPoints: 5,
      description: 'Sounds like a nice party!',
      id: '3',
    );
    partyList[3] = new Party(
        name: 'Pasta Party',
        day: '4/4/2018',
        imagePath: 'assets/img/pasta.jpeg',
        organiser: 'Deb',
        place: 'Via sesto in Sylvis 73/4',
        rating: 4,
        ratingNumber: 27,
        privacy: 'Public',
        pinderPoints: 5,
        description: 'Sounds like a nice party!',
        id: '42');
    partyList[4] = new Party(
        name: 'Caserma Party',
        day: 'Today',
        imagePath: 'assets/img/movingParty.jpeg',
        organiser: 'Alessandro Magno',
        place: 'Caserma Monte Grappa',
        rating: 5,
        ratingNumber: 267,
        privacy: 'Public',
        pinderPoints: 5,
        id: '5',
        description:
            'If you like Caserma Monte Grappa, you should totally join!');
    return partyList;
  }
}
