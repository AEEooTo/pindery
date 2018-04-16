/// create_party.dart
/// contains the code for the first step of creating a party

// TODO: abstract the form
import 'package:flutter/material.dart';

import 'party_details_utils.dart';
import '../theme.dart';
import '../party.dart';
import 'catalogue_choosing.dart';

/// Page used to create a new party
class CreatePartyPage extends StatefulWidget {
  CreatePartyPage({this.homePageKey});

  static const String routeName = '/create-party';
  final GlobalKey homePageKey;

  @override
  _CreatePartyPageState createState() =>
      new _CreatePartyPageState(homePageKey: homePageKey);
}

class _CreatePartyPageState extends State<CreatePartyPage> {
  _CreatePartyPageState({this.homePageKey});

  final GlobalKey homePageKey;

  // keys
  final GlobalKey scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey formKey = new GlobalKey<FormState>();

  // To be filled party instance
  Party party = new Party();

  // Text editing controllers
  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController maxPeopleController = new TextEditingController();

  // DateTime variables
  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 21, minute: 00);
  DateTime _toDate = new DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 00, minute: 00);

  // bool to check if the process was cancelled
  bool cancelled = false;

  // Privacy options
  final List<String> _allPrivacyOptions = Party.privacyOptions;
  String _privacyOption = Party.privacyOptions[0];

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
                          new Column(
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  new Expanded(
                                    child: new TextFormField(
                                      controller: maxPeopleController,
                                      keyboardType: TextInputType.number,
                                      validator: (val) => !isNumeric(val)
                                          ? 'You must insert the maximum\n number of people'
                                          : null,
                                      onSaved: (val) =>
                                          party.maxPeople = int.parse(val),
                                      decoration: const InputDecoration(
                                        labelText: 'Maximum people',
                                        labelStyle: labelStyle,
                                      ),
                                      style: inputTextStyle,
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  new Expanded(
                                    child: new InputDecorator(
                                      decoration: const InputDecoration(
                                        labelText: 'Privacy',
                                        hintText: 'Choose a privacy option',
                                      ),
                                      isEmpty: _privacyOption == null,
                                      child: new DropdownButton<String>(
                                        value: _privacyOption,
                                        isDense: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _privacyOption = newValue;
                                          });
                                        },
                                        items: _allPrivacyOptions
                                            .map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: Row(
                                              children: <Widget>[
                                                new Icon(
                                                    Party.privacyOptionsIcons[
                                                        Party.privacyOptions
                                                            .indexOf(value)]),
                                                const SizedBox(width: 12.0),
                                                new Text(value),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
                      // TODO: add party catalogue screen
                      onPressed: _validateFields()
                          ? () => _handleSubmitted()
                          : null,
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

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.parse(s, onError: (e) => null) != null;
  }

  bool _validateFields() {
    return nameController.text.trim().isNotEmpty &&
        locationController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        isNumeric(maxPeopleController.text) &&
        party.imageLocalPath != null;
  }

  void _handleSubmitted() {
    printPartyInfo();
    final FormState form = formKey.currentState;
    form.save();
    assignPartyFields();
    printPartyInfo();
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new ChooseCataloguePage(
              homePageKey: homePageKey,
              party: party,
            ),
      ),
    );
  }

  /// Method to assign the different collected fields to the Party instance
  // Migrated
  void assignPartyFields() {
    party.fromDayTime = dateTimeParser(_fromTime, _fromDate);
    party.toDayTime = dateTimeParser(_toTime, _toDate);
    party.privacy = _allPrivacyOptions.indexOf(_privacyOption);
  }

  /// Just for debugging purpose
  void printPartyInfo() {
    print(party.name);
    print(party.description);
    print(party.place);
    print(party.fromDayTime);
    print(party.toDayTime);
  }
}
