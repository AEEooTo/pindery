// External imports
import 'package:flutter/material.dart';

import 'take_part_page.dart';
import '../catalogue/catalogue_element.dart';
import '../theme.dart';

typedef Widget ItemBodyBuilder<double>(Item<double> item);
typedef String ValueToString<double>(double value);

class ListItem extends StatefulWidget {
  ListItem(
      {this.elementsList, this.takePartPageState, this.obtainedPoints});

  final List<CatalogueElement> elementsList;
  ObtainedPoints obtainedPoints;
  State<TakePartPage> takePartPageState;

  @override
  _ListItemState createState() => new _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<Item<double>> _items;

  @override
  void initState() {
    super.initState();
    _items = itemListBuilder();
  }

  List<Item<double>> itemListBuilder() {
    List<Item<double>> itemsList = <Item<double>>[];
    if (widget.elementsList.isNotEmpty) {
      for (CatalogueElement element in widget.elementsList) {
        itemsList.add(new Item<double>(
          name: element.elementName,
          value: 0.0,
          valueToString: (double amount) => '${amount.round()}',
          builder: (Item<double> item) {
            void close() {
              setState(() {
                item.isExpanded = false;
              });
            }

            return new Form(child: new Builder(builder: (BuildContext context) {
              return new CollapsibleBody(
                onSave: () {
                  Form.of(context).save();
                  close();
                  widget.takePartPageState.setState(() {
                    // TODO: add the case when the user decides to change mind!
                    widget.obtainedPoints.points +=
                        item.value.round() * element.elementValue;
                  });
                },
                onCancel: () {
                  Form.of(context).reset();
                  close();
                },
                child: new FormField<double>(
                  initialValue: item.value,
                  onSaved: (double value) {
                    item.value = value;
                  },
                  builder: (FormFieldState<double> field) {
                    return new Padding(
                      padding: const EdgeInsets.only(top: 53.0),
                      child: new Slider(
                        min: 0.0,
                        max: element.remainingQuantity.toDouble(),
                        divisions: element.remainingQuantity,
                        activeColor: secondary,
                        label: '${field.value.ceil()}',
                        value: field.value.toDouble(),
                        onChanged: field.didChange,
                      ),
                    );
                  },
                ),
              );
            }));
          },
        ));
      }
    }
    return itemsList;
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: false,
      bottom: false,
      child: new ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _items[index].isExpanded = !isExpanded;
            });
          },
          children: _items.map((Item<double> item) {
            return new ExpansionPanel(
                isExpanded: item.isExpanded,
                headerBuilder: item.headerBuilder,
                body: item.build());
          }).toList()),
    );
  }
}

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({this.name, this.value, this.showHint});

  final String name;
  final String value;
  static const String hint = 'Select number of items';
  final bool showHint;

  Widget _crossFade(Widget first, Widget second, bool isExpanded) {
    return new AnimatedCrossFade(
      firstChild: first,
      secondChild: second,
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(children: <Widget>[
        new Expanded(
          flex: 2,
          child: new Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: new FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: new Text(
                name,
                style: new TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
          ),
        ),
        new Expanded(
            flex: 3,
            child: new Container(
                margin: const EdgeInsets.only(left: 24.0),
                child: _crossFade(
                    new Text(
                      value,
                      style: new TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    new Text(
                      hint,
                      style: new TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    showHint)))
      ]),
    );
  }
}

//PART CONTAINING SLIDER AND BUTTONS
class CollapsibleBody extends StatelessWidget {
  const CollapsibleBody(
      {this.margin: EdgeInsets.zero,
      this.child,
      this.onSave,
      this.onCancel,
      this.maxNumber});

  final EdgeInsets margin;
  final Widget child;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final int maxNumber;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return new Container(
      child: new Column(
        children: <Widget>[
          // SLIDER
          new Container(
              margin:
                  const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0) -
                      margin,
              child: new Center(
                  child: new DefaultTextStyle(
                      style: textTheme.caption.copyWith(fontSize: 15.0),
                      child: child))),
          const Divider(height: 1.0),
          // CANCEL - SAVE BUTTONS
          new Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            color: Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: new FlatButton(
                        onPressed: onCancel,
                        child: const Text('CANCEL',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500)))),
                new Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: new FlatButton(
                    onPressed: onSave,
                    textTheme: ButtonTextTheme.accent,
                    child: const Text('SAVE'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Item<double> {
  Item({this.name, this.value, this.builder, this.valueToString})
      : textController = new TextEditingController(text: valueToString(value));

  final String name;
  final TextEditingController textController;
  final ItemBodyBuilder<double> builder;
  final ValueToString<double> valueToString;
  double value;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return new DualHeaderWithHint(
          name: name, value: valueToString(value), showHint: isExpanded);
    };
  }

  Widget build() => builder(this);
}
