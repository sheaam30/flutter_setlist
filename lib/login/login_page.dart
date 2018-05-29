import 'package:flutter/material.dart';
import 'package:setlist/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white70,
        child: _loginButton(),
      ),
    );
  }

  _loginButton() {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () => loginBloc.signIn.add(null),
          child: Text("Sign In"),
        ),
        RaisedButton(
          onPressed: () => loginBloc.signOut.add(null),
          child: Text("Sign Out"),
        ),
      ],
    );
  }
}
