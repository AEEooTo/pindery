/// party_card.dart
/// This file contains the code for every party's basic infos card in Pindery's homepage
///

// Core imports
import 'dart:async';
// External imports
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Internal imports
import '../party.dart';
import '../party_page.dart';
import '../theme.dart';

class PartyCard extends StatelessWidget {
  PartyCard({this.party, this.observer, this.analytics, this.homeScaffoldKey});

  final Party party;
  final double cardHeight = 200.0;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final GlobalKey homeScaffoldKey;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        height: cardHeight,
        child: new Stack(
          children: <Widget>[
            new ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: new CachedNetworkImage(
                imageUrl: party.imageUrl,
                fit: BoxFit.cover,
                placeholder: new Center(child: new CircularProgressIndicator()),
              ),
            ),
            new Container(
              margin: new EdgeInsets.only(top: 90.0),
              decoration: new BoxDecoration(color: new Color(0x59000000)),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 16.0, bottom: 8.0),
                    child: new Text(
                      party.name,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(fontSize: 28.0, color: Colors.white),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: new Text(
                            party.fromDayTime.day.toString() +
                                '/' +
                                party.fromDayTime.month.toString() +
                                '/' +
                                party.fromDayTime.year.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                                fontSize: 17.0, color: Colors.white),
                          ),
                        ),
                      ),
                      new Container(
                        //button
                        padding: new EdgeInsets.all(8.0),
                        child: new FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (context) => new PartyPage(
                                      party: party,
                                      homeScaffoldKey: homeScaffoldKey,
                                    ),
                              ),
                            );
                          },
                          child: new Text('JOIN',
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: secondaryLight,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.75)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> setOpenParty() async {
    analytics.logEvent(
      name: 'open_party',
      parameters: {'name': party.name, 'id': party.id},
    );
  }
}
