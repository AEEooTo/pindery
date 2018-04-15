/// This page contains the code for the welcoming page of the app.
///
///

import 'package:flutter/material.dart';
import 'drawer.dart';
import 'theme.dart';
import 'login.dart';

class WelcomePage extends StatelessWidget{
  WelcomePage({Contex});

  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
        child: new PinderyDrawer(),
      ),
      body: new Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage('assets/img/beers.jpg'),
              fit: BoxFit.cover,)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only( top: 96.0),
                child: new Container(
                  height: 214.0,
                  width: 214.0,
                  decoration: new BoxDecoration(

                      image: new DecorationImage(
                        image: new AssetImage('assets/img/logo_v_2_rosso.png'),
                        fit: BoxFit.fitHeight,
                      )
                  ),),
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 81.0),
                child: new Text(
                  'Pindery',
                  style: new TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w100
                  ),
                ),
              ),
              new Container(
                alignment: Alignment.bottomCenter,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: new WelcomeButton(
                        text: '  LOG IN  ',
                        color: primary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:73.0),
                      child: new WelcomeButton(
                        text: 'SIGN UP',
                        color: secondary,
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
  }

class WelcomeButton extends StatelessWidget{
  WelcomeButton({this.text, this.color});

   final String text;
   final Color color;

  Widget build (BuildContext context){
    return new RaisedButton(

      padding: EdgeInsets.symmetric(horizontal: 100.0),
      color: color,
      child: new Text(
        text,
        style: new TextStyle(
            color: Colors.white
        ),),
      onPressed: (){
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new LoginPage()),
        );


      },
    );
  }

}