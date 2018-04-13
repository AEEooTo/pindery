/// create_party.dart
/// contains the code for the first step of creating a party

import 'package:flutter/material.dart';

import 'theme.dart';
import 'party.dart';

/// Page used to create a new party
class CreatePartyPage extends StatefulWidget {
  static const String routeName = '/create-party';

  @override
  _CreatePartyPageState createState() => new _CreatePartyPageState();
}

class _CreatePartyPageState extends State<CreatePartyPage> {
  bool _chosenImage = true;

  Party party = new Party();
  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

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
            color: primaryLight,
            child: new ListView(
              children: <Widget>[
                new Container(
                  height: 150.0,
                  child: new _PartyImageContainer(
                    chosenImage: _chosenImage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          controller: nameController,
                          enabled: true,
                          decoration: const InputDecoration(
                            labelText: 'Party name',
                            labelStyle: bigLabelStyle,
                          ),
                          style: Theme.of(context).textTheme.headline.copyWith(
                                fontSize: 38.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                          maxLength: 20,
                        ),
                        new TextFormField(
                          controller: locationController,
                          enabled: true,
                          decoration: const InputDecoration(
                            labelText: 'Location',
                            labelStyle: labelStyle,
                          ),
                          style: inputTextStyle,
                          maxLength: 35,
                        ),
                        new TextFormField(
                          controller: descriptionController,
                          enabled: true,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            labelStyle: labelStyle,
                          ),
                          maxLength: 300,
                          maxLines: 5,
                          style: inputTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0, bottom: 20.0, left: 110.0, right: 110.0),
                  child: new RaisedButton(
                    child: new Text(
                      'NEXT',
                      style: new TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      party.name = nameController.text;
                      party.place = locationController.text;
                      party.description = descriptionController.text;
                      print(party.name);
                      print(party.description);
                      print(party.place);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PartyImageContainer extends StatefulWidget {
  _PartyImageContainer({this.chosenImage});

  final bool chosenImage;

  @override
  _PartyImageContainerState createState() =>
      new _PartyImageContainerState(chosenImage: chosenImage);
}

class _PartyImageContainerState extends State<_PartyImageContainer> {
  _PartyImageContainerState({this.chosenImage});

  final bool chosenImage;

  @override
  Widget build(BuildContext context) {
    if (chosenImage) {
      return new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(
              'assets/img/movingParty.jpeg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return new Container(
      decoration: new BoxDecoration(
        color: const Color(0x99FFFFFF),
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new FlatButton(
            child: new Icon(
              Icons.photo,
              color: Theme.of(context).accentColor,
              size: 45.0,
            ),
            onPressed: () => print("Pressed"),
            shape: CircleBorder(),
          ),
          new Text(
            'Add a picture!',
            style: new TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 26.0,
            ),
          ),
        ],
      ),
    );
  }
}
