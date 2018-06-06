/// This page contains the code for log in into the app and the logging in uploading page
///
///

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:validator/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme.dart';
import '../user.dart';

TextEditingController usernameController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
String _email;
String _password;
FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key, this.user}) : super(key: key);

  static const routeName = '/login-page';
  final User user;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _clearForm();
      }
    
      @override
      Widget build(BuildContext context) {
        return new Theme(
          data: new ThemeData(
            primaryColor: primary,
            primaryColorLight: primaryLight,
            primaryColorDark: primaryDark,
            accentColor: Colors.white,
            buttonTheme: new ButtonThemeData(textTheme: ButtonTextTheme.accent),
            brightness: Brightness.light,
          ),
          child: new Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: new Form(
                autovalidate: true,
                child: DropdownButtonHideUnderline(
                  child: new SafeArea(
                    top: false,
                    bottom: false,
                    child: ListView(children: <Widget>[
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            padding: const EdgeInsets.all(80.0),
                            child: new Text(
                              'Log In!',
                              style: new TextStyle(
                                  fontSize: 40.0,
                                  color: secondary,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          new Container(
                            child: new Column(
                              children: [
                                new Form(
                                  key: formKey,
                                  child: new Column(
                                    children: <Widget>[
                                      new Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: new EmailField(
                                          labelText: 'E-mail',
                                          validator: (val) => !isEmail(val)
                                              ? 'You must insert a valid email'
                                              : null,
                                          helperText: 'Insert your e-mail',
                                          onSaved: (String value) {
                                            _email = value;
                                          },
                                        ),
                                      ),
                                      new PasswordField(
                                        validator: (val) => val.isEmpty
                                            ? 'You must insert a password'
                                            : null,
                                        labelText: 'Password',
                                        helperText: 'Insert your password',
                                        onSaved: (String value) {
                                          _password = value;
                                        },
                                      ),
                                      new Padding(
                                        padding: const EdgeInsets.only(top: 80.0),
                                        child: new LogInButton(
                                          text: '  LOGIN  ',
                                          color: primary,
                                          formKey: formKey,
                                          user: widget.user,
                                        ),
                                      ),
                                      // TODO: add forgot password
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    
      void _clearForm() {
        usernameController.clear();
        passwordController.clear();
      }
}

class LogInButton extends StatefulWidget {
  LogInButton({this.text, this.color, this.formKey, this.user});

  final String text;
  final Color color;
  final formKey;
  final User user;

  @override
  State<LogInButton> createState() => new _LogInButtonState(user);
}

class _LogInButtonState extends State<LogInButton> {
  _LogInButtonState(this.user);
  User user;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      color: widget.color,
      child: new Text(
        widget.text,
        style: new TextStyle(color: Colors.white),
      ),
      onPressed: () {
        final formState = widget.formKey.currentState;
        if (formState.validate()) {
          formState.save();
          _handleLogin(context);
        }
      },
    );
  }

  Future<Null> _handleLogin(BuildContext context) async {
    Navigator
        .of(context)
        .push(new MaterialPageRoute(builder: (context) => new LoggingInPage()));
    bool resultGood = await _trulyHandleLogin(_auth, context);
    if (resultGood) {
      user = await User.userDownloader(user: user);
      Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
    } else {
      Navigator.pop(context);
      Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text(
              "Wrong username or password",
              textAlign: TextAlign.center,
            ),
          ));
    }
  }
}

Future<bool> _trulyHandleLogin(
    FirebaseAuth firebaseAuth, BuildContext context) async {
  bool hasSucceeded = true;
  try {
    await _auth.signInWithEmailAndPassword(email: _email, password: _password);
  } catch (error) {
    // TODO: check the type of error and prompt the user consequently
    hasSucceeded = false;
  }
  return hasSucceeded;
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
  });

  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      autocorrect: false,
      controller: passwordController,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      decoration: new InputDecoration(
        fillColor: Colors.white,
        border: new UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        hintStyle: new TextStyle(
          color: dividerColor,
          fontSize: 30.0,
        ),
        labelText: widget.labelText,
        labelStyle: new TextStyle(
            color: dividerColor, fontSize: 30.0, fontWeight: FontWeight.w300),
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
          child:
              new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  EmailField({
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
  });

  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.emailAddress,
      onSaved: onSaved,
      validator: validator,
      decoration: new InputDecoration(
        fillColor: Colors.white,
        border: new UnderlineInputBorder(),
        filled: true,
        hintText: hintText,
        hintStyle: new TextStyle(
          color: dividerColor,
          fontSize: 30.0,
        ),
        labelText: labelText,
        labelStyle: new TextStyle(
            color: dividerColor, fontSize: 30.0, fontWeight: FontWeight.w300),
        helperText: helperText,
        helperStyle: new TextStyle(
          color: dividerColor,
          fontSize: 14.0,
        ),
      ),
    );
  }
}

///////
class LoggingInPage extends StatelessWidget {
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
              padding: const EdgeInsets.only(top: 20.0, bottom: 60.0),
              child: new Text(
                'Logging in!',
                style: new TextStyle(
                    fontSize: 40.0,
                    color: secondary,
                    fontWeight: FontWeight.w600),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(16.0),
              child: new Container(
                height: 1.5,
                margin: EdgeInsets.only(top: 16.0, left: 40.0, right: 40.0),
                child: new LinearProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
