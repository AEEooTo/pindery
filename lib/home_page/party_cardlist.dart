import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pindery/home_page/party_card.dart';
import '../party.dart';

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
            // TODO: add a better loading view
            return new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(child: new CircularProgressIndicator()),
                  const SizedBox(
                    height: 12.0,
                  ),
                  new Text("Loading..."),
                ],
              ),
            );
          }
          return new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, int index) {
                // TODO: invert the order of the parties (from newer to older)
                List<DocumentSnapshot> documentsList = snapshot.data.documents;
                documentsList.sort(
                    (DocumentSnapshot documentA, DocumentSnapshot documentB) {
                      return documentA['fromDayTime'].compareTo(documentB['fromDayTime']);
                    }
                );
                final DocumentSnapshot document =
                    documentsList[index];
                Party party = new Party.fromJSON(document);
                return new PartyCard(party: party);
              },
              itemCount: snapshot.data.documents.length);
        });
  }
}
