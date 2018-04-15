/// create_party.dart
/// contains the code for the first step of creating a party

import 'dart:async';

import 'package:flutter/material.dart';

import 'party_details_utils.dart';
import 'theme.dart';
import 'party.dart';

/// Page used to create a new party
class CreatePartyPage extends StatefulWidget {
  static const String routeName = '/create-party';

  @override
  _CreatePartyPageState createState() => new _CreatePartyPageState();
}

class _CreatePartyPageState extends State<CreatePartyPage> {
  // keys
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  // To be filled party instance
  Party party = new Party();

  // Text editing controllers
  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  // DateTime variables
  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 21, minute: 00);
  DateTime _toDate = new DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 00, minute: 00);

  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context),
      child: new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text('New party'),
        ),
        body: new DropdownButtonHideUnderline(
          child: new SafeArea(
            top: false,
            bottom: false,
            child: new Container(
              color: primaryLight,
              child: new ListView(
                children: <Widget>[
                  new Container(
                    height: 200.0,
                    child: new PartyImageContainer(
                      party: party,
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: new Form(
                      autovalidate: true,
                      key: formKey,
                      child: new Column(
                        children: <Widget>[
                          new TextFormField(
                            controller: nameController,
                            validator: (val) => val.isEmpty
                                ? 'You must insert a name for this party.'
                                : null,
                            onSaved: (val) => party.name = val,
                            decoration: const InputDecoration(
                                labelText: 'Party name',
                                labelStyle: labelStyle,
                                border: const UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                  color: const Color(0xFFE52059),
                                ))),
                            style:
                                Theme.of(context).textTheme.headline.copyWith(
                                      fontSize: 38.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                            maxLength: 20,
                          ),
                          new TextFormField(
                            controller: locationController,
                            validator: (val) => val.isEmpty
                                ? 'You must insert a location for this party.'
                                : null,
                            onSaved: (val) => party.place = val,
                            decoration: const InputDecoration(
                              labelText: 'Location',
                              labelStyle: labelStyle,
                            ),
                            style: inputTextStyle,
                            maxLength: 50,
                          ),
                          new TextFormField(
                            controller: descriptionController,
                            validator: (val) => val.isEmpty
                                ? 'You must insert a description for this party.'
                                : null,
                            onSaved: (val) => party.description = val,
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
                  new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: new Column(
                      children: <Widget>[
                        new DateTimePicker(
                          labelText: 'From',
                          selectedDate: _fromDate,
                          selectedTime: _fromTime,
                          selectDate: (DateTime date) {
                            setState(() {
                              _fromDate = date;
                            });
                          },
                          selectTime: (TimeOfDay time) {
                            setState(() {
                              _fromTime = time;
                            });
                          },
                        ),
                        new DateTimePicker(
                          labelText: 'To',
                          selectedDate: _toDate,
                          selectedTime: _toTime,
                          selectDate: (DateTime date) {
                            setState(() {
                              _toDate = date;
                            });
                          },
                          selectTime: (TimeOfDay time) {
                            setState(() {
                              _toTime = time;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 110.0, right: 110.0),
                    child: new RaisedButton(
                      child: new Text(
                        'NEXT',
                        style: new TextStyle(color: Colors.white),
                      ),
                      onPressed:
                          validateFields() ? () => _uploadingDialog() : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmitted(BuildContext context) async {
    final FormState form = formKey.currentState;
    final ScaffoldState scaffold = scaffoldKey.currentState;
    await party.uploadImage(party.imageLocalPath);
    form.save();
    assignPartyFields(party);
    party.sendParty();
    printPartyInfo();
    Navigator.of(context).pop();
    scaffold.showSnackBar(
      new SnackBar(content: new Text('The party was saved on the DB')),
    );
  }

  Future<Null> _uploadingDialog() async {
    _handleSubmitted(context);
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Loading'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Loading cool infos.'),
                new Text('You\'ll be soon ready to party hard.'),
                new Center(
                  child: new Container(
                    height: 1.5,
                    margin: EdgeInsets.only(top: 16.0),
                    child: new LinearProgressIndicator(),),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Method to assign the different collected fields to the Party instance
  void assignPartyFields(Party party) {
    party.day = _fromDate.toString();
    party.fromTime = _fromTime.format(context);
    party.toDay = _toDate.toString();
    party.toTime = _toTime.format(context);
  }

  /// Just for debugging purpose
  void printPartyInfo() {
    print(party.name);
    print(party.description);
    print(party.place);
    print(party.day);
    print(party.fromTime);
    print(party.toDay);
    print(party.toTime);
  }

  bool validateFields() {
    return nameController.text.trim().isNotEmpty &&
        locationController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        party.imageLocalPath != null;
  }
}

class PartyForm extends StatelessWidget {
  PartyForm({this.party});

  Party party;

  // Text editing controllers
  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  // DateTime variables
  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 21, minute: 00);
  DateTime _toDate = new DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 00, minute: 00);

  @override
  Widget build(BuildContext context) {
    final formKey = new GlobalKey<FormState>();
    return new Form(
      autovalidate: true,
      key: formKey,
      child: new Column(
        children: <Widget>[
          new TextFormField(
            controller: nameController,
            validator: (val) =>
                val.isEmpty ? 'You must insert a name for this party.' : null,
            onSaved: (val) => party.name = val,
            decoration: const InputDecoration(
                labelText: 'Party name',
                labelStyle: labelStyle,
                border: const UnderlineInputBorder(
                    borderSide: const BorderSide(
                  color: const Color(0xFFE52059),
                ))),
            style: Theme.of(context).textTheme.headline.copyWith(
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
            maxLength: 20,
          ),
          new TextFormField(
            controller: locationController,
            validator: (val) => val.isEmpty
                ? 'You must insert a location for this party.'
                : null,
            onSaved: (val) => party.place = val,
            decoration: const InputDecoration(
              labelText: 'Location',
              labelStyle: labelStyle,
            ),
            style: inputTextStyle,
            maxLength: 50,
          ),
          new TextFormField(
            controller: descriptionController,
            validator: (val) => val.isEmpty
                ? 'You must insert a description for this party.'
                : null,
            onSaved: (val) => party.description = val,
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
    );
  }
}
