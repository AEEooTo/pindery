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
          if (!snapshot.hasData) {
            return new Text('Loading...');
          }
          return new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, int index) {
                for (DocumentSnapshot document in snapshot.data.documents) {
                  print(document);
                }
                final DocumentSnapshot document =
                    snapshot.data.documents[index];
                Party party = new Party.fromJSON(document);
                return new PartyCard(party: party);
              },
              itemCount: snapshot.data.documents.length);
        });
  }
}
