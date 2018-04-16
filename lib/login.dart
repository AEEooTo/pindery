/// This page contains the code for log in into the app.
///
///

import 'package:flutter/material.dart';
import 'drawer.dart';
import 'theme.dart';


TextEditingController usernameController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
  }

class _LoginPageState extends State<LoginPage> {

  String _username;
  String _password;


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
                                  onSaved: (val) => _username = val,
                                  decoration: const InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                        color: dividerColor,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w300
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
                              new PasswordField(
                                labelText: 'Password',
                                helperText: 'Insert your password',
                                onFieldSubmitted: (String value) {
                                  setState(() {
                                    password = value;
                                  });
                                },

                              ),
                              new Padding(
                                padding: const EdgeInsets.only(top: 80.0),
                                child: new LogInButton(
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

class LogInButton extends StatelessWidget{
  LogInButton({this.text, this.color});

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
              builder: (context) => new LogingInPage()),
        );
      },
    );
  }

}

class PasswordField extends StatefulWidget {
  const PasswordField({

    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });


  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(

      obscureText: _obscureText,
      maxLength: 10,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        hintStyle: new TextStyle(
        color: dividerColor,
        fontSize: 30.0,
        ),
        labelText: widget.labelText,
        labelStyle: new TextStyle(
          color: dividerColor,
          fontSize: 30.0,
            fontWeight: FontWeight.w300
        ),
        helperText: widget.helperText,
        helperStyle: new TextStyle(
          color: dividerColor,
          fontSize: 14.0,
        ),
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}

class LogingInPage extends StatelessWidget{
  LogingInPage({Contex});
  Widget build(BuildContext context){
    return new Scaffold(
      drawer: new Drawer(
        child: new PinderyDrawer(),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            color: Colors.white
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                'Logging in!',
                style: new TextStyle(
                    fontSize: 40.0,
                    color: secondary,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}