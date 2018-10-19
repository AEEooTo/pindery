/// Library for some utils to choose party details

library party_details_utils;

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../theme.dart';
import '../party.dart';

class PinderyDetailsUtils {
  static Future<File> pickImage(ImageSource source) async {
    File imageFile = await ImagePicker.pickImage(source: source);
    return imageFile;
  }
}

/// Container for the top party image
class PartyImageContainer extends StatefulWidget {
  PartyImageContainer({this.party});

  final Party party;

  @override
  PartyImageContainerState createState() =>
      new PartyImageContainerState(party: party);
}

class PartyImageContainerState extends State<PartyImageContainer> {
  PartyImageContainerState({this.party});

  final Party party;

  @override
  Widget build(BuildContext context) {
    if (party.localImageFile != null) {
      return new Container(
        child: Image.file(
          party.localImageFile,
          fit: BoxFit.cover,
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
          new Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 8.0),
                  child: new IconButton(
                    icon: new Icon(
                      Icons.photo,
                      color: primaryLight,
                      size: 45.0,
                    ),
                    tooltip: 'Choose a picture from the gallery',
                    onPressed: () async {
                      party.localImageFile = await PinderyDetailsUtils
                          .pickImage(ImageSource.gallery);
                      setState(() {});
                    },
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 8.0),
                  child: new IconButton(
                    icon: new Icon(
                      Icons.camera,
                      color: primaryLight,
                      size: 45.0,
                    ),
                    onPressed: () async {
                      party.localImageFile = await PinderyDetailsUtils
                          .pickImage(ImageSource.camera);
                      setState(() {});
                    },
                    tooltip: 'Take a new picture',
                  ),
                ),
              ],
            ),
          ),
          new Text(
            'Add a picture',
            style: new TextStyle(
              color: primaryLight,
              fontSize: 26.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// DateTime picker object, used to create a DateTime picker
class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime,
    this.showDay = true,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;
  final bool showDay;

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
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _dateTimeChildren(context),
    );
  }

  List<Widget> _dateTimeChildren(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    List<Widget> children = <Widget>[];
    if (showDay == true) {
      children.add(
        new Expanded(
          flex: 4,
          child: new InputDropdown(
            labelText: 'Day',
            valueText:
                new DateFormat.yMMMd(Localizations.localeOf(context).toString())
                    .format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
      );
    } else {
      children.add(new Expanded(
        flex: 4,
        child: new Container(),
      ));
    }
    children.add(const SizedBox(width: 12.0));
    children.add(
      new Expanded(
        flex: 3,
        child: new InputDropdown(
          labelText: labelText,
          valueText: selectedTime.format(context),
          valueStyle: valueStyle,
          onPressed: () {
            _selectTime(context);
          },
        ),
      ),
    );
    return children;
  }
}

/// Dropdown Input object
class InputDropdown extends StatelessWidget {
  const InputDropdown(
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

/// Function to parse a DateTime from a TimeOfDay object and DateTime object to obtain a string
DateTime dateTimeParser(TimeOfDay time, DateTime date) {
  int _minutes = time.minute;
  int _hours = time.hour;
  int _day = date.day;
  int _month = date.month;
  int _year = date.year;
  print(DateTime(_year, _month, _day, _hours, _minutes));
  return DateTime(_year, _month, _day, _hours, _minutes);
}

bool isNumericAndPositive(String s) {
  int parsedInt;
  if (s == null) {
    return false;
  }
  try {
    parsedInt = int.parse(s);
  } catch (FormatException) {
    return false;
  }

  return parsedInt > 0;
}
