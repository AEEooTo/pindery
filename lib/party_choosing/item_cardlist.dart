import 'package:flutter/material.dart';
import 'package:pindery/theme.dart';


typedef Widget DemoItemBodyBuilder<T>(DemoItem<T> item);
typedef String ValueToString<T>(T value);

class ListItem extends StatefulWidget {
  ListItem({this.name, this.maxNumber});

  final String name;
  final int maxNumber;

  @override
  _ListItemState createState() => new _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<DemoItem<dynamic>> _demoItems;

  @override
  void initState() {
    super.initState();
    _demoItems = <DemoItem<dynamic>>[
      new DemoItem<double>(
          name: widget.name,
          value: 0.0,
          hint: 'Select number of items',
          valueToString: (double amount) => '${amount.round()}',
          builder: (DemoItem<double> item) {
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
                    return new Slider(
                      min: 0.0,
                      max: widget.maxNumber.toDouble(),
                      divisions: widget.maxNumber,
                      activeColor: secondary,
                      label: '${field.value.round()}',
                      value: field.value,
                      onChanged: field.didChange,
                    );
                  },
                ),
              );
            }));
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: false,
      bottom: false,
      child: new Container(
        color: Colors.white,
        child: new ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _demoItems[index].isExpanded = !isExpanded;
              });
            },
            children: _demoItems.map((DemoItem<dynamic> item) {
              return new ExpansionPanel(
                  isExpanded: item.isExpanded,
                  headerBuilder: item.headerBuilder,
                  body: item.build());
            }).toList()),
      ),
    );
  }
}

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({this.name, this.value, this.hint, this.showHint});

  final String name;
  final String value;
  final String hint;
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
    final ThemeData theme = pinderyTheme;

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
                    new Text(value, style:
                      new TextStyle(fontSize: 15.0, color: Colors.black),),
                    new Text(hint,
                        style: new TextStyle(fontSize: 15.0, color: Colors.black),),
                    showHint)))
      ]),
    );
  }
}

//PART CONTAINING SLIDER AND BUTTONS
class CollapsibleBody extends StatelessWidget {
  const CollapsibleBody(
      {this.margin: EdgeInsets.zero, this.child, this.onSave, this.onCancel, this.maxNumber});

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
      child: new Column(children: <Widget>[
        //SLIDER
        new Container(
            margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0) -
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
                          child: const Text('SAVE')))
                ]))
      ]),
    );
  }
}

class DemoItem<T> {
  DemoItem({this.name, this.value, this.hint, this.builder, this.valueToString})
      : textController = new TextEditingController(text: valueToString(value));

  final String name;
  final String hint;
  final TextEditingController textController;
  final DemoItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T value;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return new DualHeaderWithHint(
          name: name,
          value: valueToString(value),
          hint: hint,
          showHint: isExpanded);
    };
  }

  Widget build() => builder(this);
}
