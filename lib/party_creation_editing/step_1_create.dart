/// step_1_create.dart
/// contains the code for the first step of creating a party

// TODO: abstract the form
import 'package:flutter/material.dart';

import 'party_details_utils.dart';
import '../theme.dart';
import '../party.dart';
import 'step_2_catalogue.dart';
import '../catalogue/catalogue.dart';
import '../privacy.dart';

/// Page used to create a new party
class CreatePartyPage extends StatefulWidget {
  CreatePartyPage(this.homeScaffoldKey, this.organiserUid);
  static const String routeName = '/create-party';
  final GlobalKey homeScaffoldKey;
  final String organiserUid;

  @override
  _CreatePartyPageState createState() =>
      new _CreatePartyPageState(homeScaffoldKey: homeScaffoldKey);
}

class _CreatePartyPageState extends State<CreatePartyPage> {
  _CreatePartyPageState({this.homeScaffoldKey});

  final GlobalKey<ScaffoldState> homeScaffoldKey;

  // keys
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  // To be filled party instance
  Party party = new Party();
  final Catalogue catalogue = new Catalogue.initialization();

  // Text editing controllers
  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController maxPeopleController = new TextEditingController();

  // DateTime variables
  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = new TimeOfDay(
      hour: new DateTime.now().hour, minute: new DateTime.now().minute);
  DateTime _toDate = new DateTime.now();
  TimeOfDay _toTime = new TimeOfDay(
      hour: new DateTime.now().hour, minute: (new DateTime.now().minute + 1));

  // bool to check if the process was cancelled
  bool cancelled = false;

  // Privacy options
  final List<String> _allPrivacyOptions = Privacy.options;
  String _privacyOption = Privacy.options[0];
  
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
                      key: formKey,
                      child: new Column(
                        children: <Widget>[
                          new TextFormField(
                            onFieldSubmitted: (val) =>
                                formKey.currentState.validate(),
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
                                ),
                              ),
                            ),
                            style:
                                Theme.of(context).textTheme.headline.copyWith(
                                      fontSize: 38.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                            maxLength: 30,
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
                            maxLength: 100,
                            onFieldSubmitted: (val) =>
                                formKey.currentState.validate(),
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
                            onFieldSubmitted: (val) =>
                                formKey.currentState.validate(),
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
                                showDay: false,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  new Expanded(
                                    child: new TextFormField(
                                      controller: maxPeopleController,
                                      keyboardType: TextInputType.number,
                                      validator: (val) => !isNumericAndPositive(
                                              val)
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
                                                    Privacy.optionsIcons[
                                                        Privacy.options
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
                      onPressed: () {
                        if (formKey.currentState.validate() &&
                            party.localImageFile != null && _checkTime()) {
                          _handleSubmitted();
                        } else if (party.localImageFile == null) {
                          scaffoldKey.currentState.showSnackBar(new SnackBar(
                              content: new Text(
                                  'The picture is missing!11!1')));
                        } else if (!_checkTime()) {
                          scaffoldKey.currentState.showSnackBar(new SnackBar(
                              content: new Text(
                                  'How can that be the time of the party?!')));
                        }
                      },
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

  void _handleSubmitted() {
    final FormState form = formKey.currentState;
    party.organiserUid = widget.organiserUid;
    form.save();
    assignPartyFields();
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new ChooseCataloguePage(
              homeScaffoldKey: homeScaffoldKey,
              party: party,
              catalogue: catalogue,
            ),
      ),
    );
  }

  /// Method to assign the different collected fields to the Party instance
  // Migrated
  void assignPartyFields() {
    party.fromDayTime = dateTimeParser(_fromTime, _fromDate);
    party.toDayTime = dateTimeParser(_toTime, _toDate);
    party.privacy = new Privacy();
    party.privacy.type = _allPrivacyOptions.indexOf(_privacyOption);
  }

  bool _checkTime() {
    return _fromTime.hour > new DateTime.now().hour
        && _fromTime.minute > new DateTime.now().minute
        && _toTime.hour > _fromTime.hour
        && _toTime.minute > _fromTime.minute;
  }
}
