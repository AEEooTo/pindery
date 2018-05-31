import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import '../user.dart';
import 'home_page.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({Key key, this.user, this.homePageKey}) : super(key: key);
  
  final User user;
  final GlobalKey homePageKey;
  final bool firstTime = true;

  @override
  State<OfflinePage> createState() =>
      new _OfflinePageState(user, firstTime);
}

class _OfflinePageState extends State<OfflinePage> {
  _OfflinePageState(this.user, this.firstTime);

  User user;
  bool firstTime;
  final Connectivity _connectivity = new Connectivity();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pindery'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new ConnectionText(firstTime: firstTime),
            new Container(
              margin: new EdgeInsets.all(16.0),
              child: new FlatButton(
              child: new Text('RETRY'),
              onPressed: () => _handleConnectionRetry(),
            ),
            )
          ],
        ),
      ),
    );
  }

  void _handleConnectionRetry() {
    _showDialog();
    _connectivity.checkConnectivity()
        .then((ConnectivityResult connectivity) async {
      print(connectivity.toString());
      if (connectivity != ConnectivityResult.none) {
        debugPrint("We have connectivity!");
        user = await User.userDownloader();
        debugPrint(user.name);
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
              settings: new RouteSettings(name: '/'),
              builder: (_) => new HomePage(user: user),
            ),
            (_) => false);
      } else {
        debugPrint("Still no connectivity");
        setState(() {
          firstTime = false;
        });
        Navigator.of(context).pop();
      }
    });
  }

  void _showDialog() async {
    await showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return new AlertDialog(
            title: new Text('Loading'),
            content: new Container(
              height: 20.0,
              margin: EdgeInsets.only(top: 16.0),
              child: new Column(
                children: <Widget>[
                  new LinearProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }
}

class ConnectionText extends StatelessWidget {
  final bool firstTime;
  const ConnectionText({Key key, this.firstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (firstTime == true) {
      return new Text('Whooops, it seem that you\'re not connected!');
    }
    return new Text('It seems that you\'re still not connected!');
  }
}
