import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'party_card.dart';
import 'party.dart';

const String testCity = "shanghai";

class PartyCardList extends StatelessWidget {
  PartyCardList({this.city});

  final String city;

  CollectionReference _getReference(String city) {
    return Firestore.instance
        .collection('cities')
        .document(city)
        .collection('parties');
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: _getReference(testCity).snapshots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print("entered the streamBuilder");
          if (!snapshot.hasData) {
            print("Looking for some data...");
            print(snapshot);
            return new Text('Loading...');
          }
          print("Snapshot has data!");
          print(snapshot.data.documents);
          for (DocumentSnapshot document in snapshot.data.documents) {
            print(document);
          }
          return new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, int index) {
                print("entered the itemBuilder");
                for (DocumentSnapshot document in snapshot.data.documents) {
                  print(document);
                }
                final DocumentSnapshot document =
                    snapshot.data.documents[index];
                Party party = new Party(
                    name: document['name'],
                    day: 'Every day',
                    imagePath: 'assets/img/kittens.jpeg',
                    organiser: 'Anna ovviamente',
                    place: document['place'],
                    rating: 1,
                    ratingNumber: 23,
                    privacy: 'Public',
                    id: '1',
                    pinderPoints: 6,
                    description: document['description']);
                return new PartyCard(party: party);
              },
              itemCount: snapshot.data.documents.length);
        });
  }
}
