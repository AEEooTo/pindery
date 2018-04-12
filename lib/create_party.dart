import 'package:flutter/material.dart';

import 'theme.dart';
import 'party.dart';

class CreatePartyPage extends StatefulWidget {
  static const String routeName = '/create-party';

  @override
  _CreatePartyPageState createState() => new _CreatePartyPageState();
}

class _CreatePartyPageState extends State<CreatePartyPage> {
  @override
  Party party = new Party();
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('New party'),
        ),
        body: new DropdownButtonHideUnderline(
          child: new SafeArea(
            top: false,
            bottom: false,
            child: Container(
              decoration: new BoxDecoration(
                color: primaryLight,
              ),
              child: new ListView(
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  new TextField(
                    enabled: true,
                    decoration: const InputDecoration(
                      labelText: 'Party name',
                      labelStyle: TextStyle(
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0x20FFFFFF),
                      ),
                    ),
                    style: Theme.of(context).textTheme.headline.copyWith(
                          fontSize: 38.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    maxLength: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
