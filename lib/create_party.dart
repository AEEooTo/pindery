/// create_party.dart
/// contains the code for the first step of creating a party

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  bool _chosenImage = false;

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
                    height: 150.0,
                    child: new _PartyImageContainer(
                      chosenImage: _chosenImage,
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
                    child: Column(
                      children: <Widget>[
                        new _DateTimePicker(
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
                        new _DateTimePicker(
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
                      onPressed: _validateFields()
                          ? () => _handleSubmitted(context)
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

  void _handleSubmitted(BuildContext context) {
    final FormState form = formKey.currentState;
    final ScaffoldState scaffold = scaffoldKey.currentState;
    form.save();
    scaffold.showSnackBar(
      new SnackBar(content: new Text('The party was saved on the DB')),
    );
    _assignPartyFields();
    party.sendParty();
    _printPartyInfo();
    // Navigator.pop(context);
  }

  /// Method to assign the different collected fields to the Party instance
  void _assignPartyFields() {
    party.day = _fromDate.toString();
    party.fromTime = _fromTime.format(context);
    party.toDay = _toDate.toString();
    party.toTime = _toTime.format(context);
  }

  /// Just for debugging purpose
  void _printPartyInfo() {
    print(party.name);
    print(party.description);
    print(party.place);
    print(party.day);
    print(party.fromTime);
    print(party.toDay);
    print(party.toTime);
  }

  bool _validateFields() {
    return nameController.text != "" &&
        locationController.text != "" &&
        descriptionController.text != "";
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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

/// DateTime picker method, used to create a DateTime picker
class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker(
      {Key key,
      this.labelText,
      this.selectedDate,
      this.selectedTime,
      this.selectDate,
      this.selectTime})
      : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: new DateTime(2101));
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 4,
          child: new _InputDropdown(
            labelText: labelText,
            valueText: new DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 12.0),
        new Expanded(
          flex: 3,
          child: new _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}

/// Dropdown Input method
class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: inputTextStyle),
            new Icon(
              Icons.arrow_drop_down,
              color: inputFieldColor,
            )
          ],
        ),
      ),
    );
  }
}
