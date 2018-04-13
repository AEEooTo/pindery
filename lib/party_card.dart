/// party_card.dart
/// This file contains the code for every party's basic infos card in Pindery's homepage
///

import 'package:flutter/material.dart';

import 'party.dart';
import 'party_page.dart';
import 'theme.dart';

class PartyCard extends StatelessWidget {
  PartyCard({this.party});

  final Party party;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        height: 200.0,
        decoration: new BoxDecoration(
            color: primaryLight,
            image: new DecorationImage(
              image: new AssetImage(party.imagePath),
              fit: BoxFit.cover,
            )),
        child: new Container(
          margin: new EdgeInsets.only(top: 90.0),
          decoration: new BoxDecoration(color: new Color(0x59000000)),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 8.0),
                      child: new Text(
                        party.name,
                        overflow: TextOverflow.ellipsis,
                        style:
                            new TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: new Text(
                        party.day,
                        overflow: TextOverflow.ellipsis,
                        style:
                            new TextStyle(fontSize: 17.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
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
                            color: secondaryLight, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static List<PartyCard> partyCardsGenerator() {
    List<Party> parties = Party.partyGenerator();
    List<PartyCard> partyCards = new List<PartyCard>();
    for (var party in parties) {
      partyCards.add(new PartyCard(party: party));
    }

    return partyCards;
  }
}
