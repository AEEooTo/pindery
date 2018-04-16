/// This page contains the code for log in into the app and the logging in uploading page
///
///

import 'package:flutter/material.dart';
import 'drawer.dart';
import 'theme.dart';

String _password;
TextEditingController passwordController = new TextEditingController();
String _cpassword;
TextEditingController cpasswordController = new TextEditingController();

class SignupPage extends StatefulWidget {
  static const routeName = '/login-page';

  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignupPage> {

  String _name;
  TextEditingController nameController = new TextEditingController();
  String _surname;
  TextEditingController surnameController = new TextEditingController();
  String _email;
  TextEditingController emailController = new TextEditingController();



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
                          padding: const EdgeInsets.only(top: 50.0),
                          child: new Text('Join Pindery!',
                            style: new TextStyle(
                                fontSize: 35.0,
                                color: primary,
                                fontWeight: FontWeight.w800,
                            ),),
                        ),
                        new Container(
                          padding: EdgeInsets.all(21.0),
                          child: new IconButton(
                            icon: new Icon(Icons.photo_camera,size: 32.0,),
                            onPressed: (){},
                            splashColor: secondary,
                          )
                        ),
                        new Container(
                          child: new Column(
                            children: <Widget>[
                              new InformationField(labelText: 'Name',
                                controller: nameController,
                                onSaved: (val) => _name = val,
                                onFieldSubmitted: (String value) {
                                  setState(() {
                                    _name = value;
                                  });
                                },
                                textInputType: TextInputType.text,
                              ),
                              new InformationField(labelText: 'Surname',
                                controller: surnameController,
                                onSaved: (val) => _surname = val,
                                onFieldSubmitted: (String value) {
                                  setState(() {
                                    _surname = value;
                                  });
                                },
                                textInputType: TextInputType.text,
                              ),
                              new InformationField(labelText: 'E-mail',
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
                                labelText: 'Password',
                                controller: passwordController,
                                onSaved: (val) => _password = val,
                                onFieldSubmitted: (String value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                              ),
                              new PasswordField(
                                labelText: 'Confirm your password',
                                controller: cpasswordController,
                                onSaved: (val) => _cpassword = val,
                                onFieldSubmitted: (String value) {
                                  setState(() {
                                    _cpassword = value;
                                  });
                                },
                              ),
                              new Padding(
                                padding: const EdgeInsets.only(top: 80.0),
                                child: new SignUpButton(
                                  text: '  SIGN UP  ',
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

class SignUpButton extends StatelessWidget{
  SignUpButton({this.text, this.color});

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
        if (_password==_cpassword)
          {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new SigninUpPage()),
            );
          }

          else
            {
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text(
                  "Pressed mate",
                  textAlign: TextAlign.center,
                ),
              ));
            }

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
    this.controller
  });


  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = false;

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
            color: dividerColor,
            fontSize: 30.0,
            fontWeight: FontWeight.w300
        ),
        helperText: widget.helperText,
        helperStyle: new TextStyle(
          color: dividerColor,
          fontSize: 14.0,
        ),
      ),
    );
  }
}

class InformationField extends StatefulWidget {
  const InformationField({

    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.textInputType,
    this.controller
  });


  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  _InformationFieldState createState() => new _InformationFieldState();
}

class _InformationFieldState extends State<InformationField> {

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      controller: widget.controller,
      keyboardType: widget.textInputType,
      maxLength: 20,
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
            color: dividerColor,
            fontSize: 30.0,
            fontWeight: FontWeight.w300
        ),
        helperText: widget.helperText,
        helperStyle: new TextStyle(
          color: dividerColor,
          fontSize: 14.0,
        ),
      ),
    );
  }
}

///////
class SigninUpPage extends StatelessWidget{
  SigninUpPage({Contex});
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
                'Signing up!',
                style: new TextStyle(
                    fontSize: 40.0,
                    color: primary,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(16.0),
              child: new Container(
                height: 1.5,
                margin: EdgeInsets.only(top: 16.0),
                child: new LinearProgressIndicator(

                ),
              ),)
          ],
        ),
      ),
    );
  }

}