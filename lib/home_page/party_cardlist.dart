import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home_page/party_card.dart';
import '../party.dart';

const String testCity = "shanghai";

class PartyCardList extends StatelessWidget {
  PartyCardList({this.city, this.hideButtonController});
  final ScrollController hideButtonController;
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
          List<DocumentSnapshot> documentsList = snapshot.data.documents;
          if (documentsList.isEmpty) {
            return new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    width: 250.0,
                    child: new Text('Whoops, it seems that nobody is organising new parties nearby.\nBecome an organiser, tapping the plus!',
                    style: new TextStyle(),)),
                ],
              ),
            );
          }
          return new ListView.builder(
            controller: hideButtonController,
              padding: new EdgeInsets.only(top:8.0, right:8.0,left: 8.0,bottom: 80.0),
              reverse: false,
              itemBuilder: (_, int index) {
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
              itemCount: snapshot.data.documents.length,
          scrollDirection: Axis.vertical,);
        });
  }
}
