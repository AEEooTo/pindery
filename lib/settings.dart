/// This file contains the code for Pindery's settings page.
///

// External libraries imports
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Internal imports
import 'theme.dart';
import 'user.dart';
import 'utils.dart';
import 'drawer.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({this.user});

  final User user;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings'),
      ),
      drawer: new PinderyDrawer(user: user),
      body: new Column(children: <Widget>[
        new Container(
          height: 175.0,
          width: 400.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/img/movingParty.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new SizedBox(
                  height: 72.0,
                  width: 72.0,
                  child: new PinderyCircleAvatar(user: user),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Column(
                  children: <Widget>[
                    new Text(
                      '${user.name} ${user.surname}',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                    new Text(
                      user.email,
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        new Expanded(
          child: new Column(
            children: <Widget>[
              new SettingsBlock(
                icon: Icons.lock,
                data: 'Change password',
                widgetBuilder: null,
              ),
              new SettingsBlock(
                icon: Icons.mail,
                data: 'Change email',
                widgetBuilder: null,
              ),
              new SettingsBlock(
                icon: Icons.photo_camera,
                data: 'Change profile picture',
                widgetBuilder: null,
              )
            ],
          ),
        ),
        new ListTile(
          leading: new Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          title: new Text('Logout'),
          onTap: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new SigninOutPage()));
            await FirebaseAuth.instance.signOut();
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        )
      ]),
    );
  }
}

class SettingsBlock extends StatelessWidget {
  SettingsBlock({this.data, this.icon, this.widgetBuilder});

  final String data;
  final IconData icon;
  final WidgetBuilder widgetBuilder;

  Widget build(BuildContext context) {
    return new Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: new BoxDecoration(
          border: new Border(bottom: new BorderSide(color: dividerColor))),
      child: new DefaultTextStyle(
        style: Theme.of(context).textTheme.subhead,
        child: new SafeArea(
            top: false,
            bottom: false,
            child: new ListTile(
              leading: new Icon(icon, color: Colors.white, size: 21.0),
              title: new Text(
                data,
                textAlign: TextAlign.start,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                if (widgetBuilder != null) {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: widgetBuilder),
                  );
                }
              },
            )),
      ),
    );
  }
}

class SigninOutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(color: Colors.white),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 96.0),
              child: new Container(
                height: 214.0,
                width: 214.0,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                  image: new AssetImage('assets/img/logo_v_2_rosso.png'),
                  fit: BoxFit.fitHeight,
                )),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 81.0),
              child: new Text(
                'Signing Out!',
                style: new TextStyle(
                    fontSize: 40.0,
                    color: primary,
                    fontWeight: FontWeight.w600),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(16.0),
              child: new Container(
                height: 1.5,
                margin: EdgeInsets.only(top: 16.0),
                child: new LinearProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
