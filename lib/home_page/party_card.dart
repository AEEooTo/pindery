/// party_card.dart
/// This file contains the code for every party's basic infos card in Pindery's homepage
///

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../party.dart';
import '../party_page.dart';
import '../theme.dart';
import 'package:pindery/first_actions/welcome.dart';

class PartyCard extends StatelessWidget {
  PartyCard({this.party});

  final Party party;
  final double cardHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        height: cardHeight,
        child: new Stack(
          children: <Widget>[
            // TODO: fix image size in stack
            new Center(child: new CircularProgressIndicator()),
            new ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: new FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: party.imageUrl,
                fit: BoxFit.cover,
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
                      style: new TextStyle(
                          fontSize: 28.0, color: Colors.white),
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
                      new Container( //button
                        padding: new EdgeInsets.all(8.0),
                        child: new FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new PartyPage(
                                        party: party,
                                      )),
                            );
                          },
                          child: new Text(
                            'JOIN',
                            style: new TextStyle(
                              fontSize: 15.0,
                                color: secondaryLight,
                                fontWeight: FontWeight.w700,
                            letterSpacing: 0.75)
                          ),
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
}
