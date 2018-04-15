/// This page contains the code for log in into the app.
///
///

import 'package:flutter/material.dart';
import 'drawer.dart';
import 'theme.dart';


TextEditingController usernameController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => new _LoginPageState();
  }

class _LoginPageState extends State<LoginPage> {

  String username;
  String password;


  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context),
      child: new Scaffold(
        drawer: new Drawer(
          child: new PinderyDrawer(),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: new Form(
            autovalidate: true,
            child: DropdownButtonHideUnderline(
              child: new SafeArea(
                  top: false,
                  bottom: false,
                  child: ListView(
                    children: <Widget>[ new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.all(80.0),
                          child: new Text('Login!',
                          style: new TextStyle(
                            fontSize: 30.0,
                            color: secondary,
                            fontWeight: FontWeight.w600
                          ),),
                        ),
                        new Container(
                          child: new Column(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: new TextFormField(
                                  controller: usernameController,
                                  validator: (val) => val.isEmpty
                                      ? 'You must insert a username.'
                                      : null,
                                  onSaved: (val) => username = val,
                                  decoration: const InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                        color: dividerColor,
                                        fontSize: 30.0,
                                      ),
                                      border: const UnderlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: dividerColor,
                                          ),
                                      )),
                                  style:
                                  Theme.of(context).textTheme.headline.copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                    color: dividerColor,
                                  ),
                                  maxLength: 20,
                                ),
                              ),
                              new TextFormField(
                                controller: passwordController,
                                validator: (val) => val.isEmpty
                                    ? 'You must insert a password.'
                                    : null,
                                onSaved: (val) => password = val,
                                decoration: const InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        color: dividerColor,
                                        fontSize: 30.0
                                    ),
                                    border: const UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: dividerColor,
                                        ))),
                                style:
                                Theme.of(context).textTheme.headline.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                  color: dividerColor,
                                ),
                                maxLength: 20,
                              ),
                              new Padding(
                                padding: const EdgeInsets.only(top: 80.0),
                                child: new WelcomeButton(
                                  text: '  LOG IN  ',
                                  color: primary,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    ]
                  ),
              ),
            ),
          ),
        ),
      ),
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


      },
    );
  }

}