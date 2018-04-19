//todo : create settings page

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './theme.dart';

class Settings extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: new Center(
        child:
          //todo: use proper button
          new FlatButton(
            color : primary,
            onPressed: () async {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new SigninOutPage()));
              await _auth.signOut();
              //todo: more checkful control
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: new Text("Logout"),
            textColor: Colors.white,
          )
      ),
    ));
  }
}

class SigninOutPage extends StatelessWidget {
  SigninOutPage({context});

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        alignment: Alignment.center,
        //todo : mettere apposto colore
        decoration: new BoxDecoration(color: Colors.black26),
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
                'Signing out!',
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
