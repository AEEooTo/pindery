/// This page contains the code for log in into the app and the logging in uploading page
///
///

import 'package:flutter/material.dart';
import '../drawer.dart';
import '../theme.dart';
import 'package:validator/validator.dart';

String _password;
TextEditingController _passwordController = new TextEditingController();
String _cpassword;
TextEditingController _confirmPasswordController = new TextEditingController();

String _name;
TextEditingController nameController = new TextEditingController();
String _surname;
TextEditingController surnameController = new TextEditingController();
String _email;
TextEditingController emailController = new TextEditingController();

class SignupPage extends StatefulWidget {
  static const routeName = '/login-page';

  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignupPage> {

  final formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        primaryColor: primary,
        primaryColorLight: primaryLight,
        primaryColorDark: primaryDark,
        accentColor: secondary,
        buttonTheme: new ButtonThemeData(textTheme: ButtonTextTheme.accent),
        brightness: Brightness.light,
      ),
      child: new Scaffold(
        drawer: new Drawer(
          child: new PinderyDrawer(),
        ),
        backgroundColor: Colors.white,
        body: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButtonHideUnderline(
            child: new SafeArea(
              top: false,
              bottom: false,
              child: ListView(children: <Widget>[
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
                      child: new Text(
                        'Join Pindery!',
                        style: new TextStyle(
                          fontSize: 35.0,
                          color: primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                        border: Border.all(color: dividerColor),
                        shape: BoxShape.circle
                      ),
                        padding: EdgeInsets.all(15.0),
                        child: new IconButton(
                          icon: new Icon(
                            Icons.photo_camera,
                            size: 32.0,
                          ),
                          //TODO: actually implement photo upload
                          onPressed: () {
                            Scaffold.of(formKey.currentContext).showSnackBar(new SnackBar(
                              content: new Text(
                                "Should still be implemented",
                                textAlign: TextAlign.center,
                              ),
                            ));
                          },
                          splashColor: secondary,
                        )),
                    new Container(
                      child: new Form(
                        key: formKey,
                        child: new Column(
                          children: <Widget>[
                            new InformationField(
                              labelText: 'Name',
                              controller: nameController,
                              validator: (val) => (!isAlpha(val)|| val.isEmpty
                                  ? 'You must a valid username'
                                  : null) ,
                              onSaved: (val) => _name = val,
                              onFieldSubmitted: (String value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                              textInputType: TextInputType.text,
                            ),
                            new InformationField(
                              labelText: 'Surname',
                              validator: (val) => !isAlpha(val) || val.isEmpty
                                  ? 'You must insert a valid surname'
                                  : null,
                              controller: surnameController,
                              onSaved: (val) => _surname = val,
                              onFieldSubmitted: (String value) {
                                setState(() {
                                  _surname = value;
                                });
                              },
                              textInputType: TextInputType.text,
                            ),
                            new InformationField(
                              labelText: 'E-mail',
                              validator: (val) => !isEmail(val) || val.isEmpty
                                  ? 'You must insert a valid email'
                                  : null,
                              textInputType: TextInputType.emailAddress,
                              controller: emailController,
                              onSaved: (val) => _email = val,
                              onFieldSubmitted: (String value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                            ),
                            new PasswordField(
                              activateIcon: true,
                              labelText: 'Password',
                              validator: (val) => val.isEmpty ? '' : null,
                              controller: _passwordController,
                              onSaved: (val) => _password = val,
                              onFieldSubmitted: (String value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                            ),
                            new PasswordField(
                              activateIcon: false,
                              labelText: 'Confirm password',
                              validator: (val) =>
                                  val != _passwordController.text
                                      ? 'The passwords must be equal'
                                      : null,
                              controller: _confirmPasswordController,
                              onSaved: (val) => _cpassword = val,
                              onFieldSubmitted: (String value) {
                                setState(() {
                                  _cpassword = value;
                                });
                              },
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(
                                  top: 60.0, bottom: 40.0),
                              child: new SignUpButton(
                                text: '  SIGN UP  ',
                                color: secondary,
                                formKey: formKey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  SignUpButton({this.text, this.color, this.formKey});

  final String text;
  final Color color;
  final formKey;

  Widget build(BuildContext context) {
    return new RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      color: color,
      child: new Text(
        text,
        style: new TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      ),
      onPressed: () {
        final formState = formKey.currentState;
        if (formState.validate()) {
          formState.save();
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new SigninUpPage()),
          );
        }
      },
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField(
      {this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.controller,
      this.activateIcon});

  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;
  final bool activateIcon;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      autocorrect: false,
      controller: widget.controller,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        fillColor: Colors.white,
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        hintStyle: new TextStyle(
          color: dividerColor,
          fontSize: 30.0,
        ),
        labelText: widget.labelText,
        labelStyle: new TextStyle(
            color: dividerColor, fontSize: 20.0, fontWeight: FontWeight.w300),
        helperText: widget.helperText,
        helperStyle: new TextStyle(
          color: dividerColor,
          fontSize: 14.0,),
        suffixIcon: widget.activateIcon ? new GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          ): null,
      ),
    );
  }
}

class InformationField extends StatelessWidget {
  InformationField({
  this.hintText,
  this.labelText,
  this.helperText,
  this.onSaved,
  this.validator,
  this.onFieldSubmitted,
  this.controller,
  this.activateIcon,
  this.textInputType});

  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;
  final bool activateIcon;
  final TextInputType textInputType;


  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      controller: controller,
      keyboardType: textInputType,
      onSaved: onSaved,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      decoration: new InputDecoration(
        fillColor: Colors.white,
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: hintText,
        hintStyle: new TextStyle(
          color: dividerColor,
          fontSize: 30.0,
        ),
        labelText: labelText,
        labelStyle: new TextStyle(
            color: dividerColor, fontSize: 20.0, fontWeight: FontWeight.w300),
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
class SigninUpPage extends StatelessWidget {

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
                'Signing up!',
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
