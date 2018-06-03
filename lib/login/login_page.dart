import 'package:flutter/material.dart';
import 'package:setlist/colors.dart';
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
          child: Stack(
            children: <Widget>[
              _title(),
              Align(alignment: Alignment.bottomCenter, child: _loginButton()),
            ],
          )),
    );
  }

  Widget _title() {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              "assets/setlist_icon.png",
              color: primaryColor,
              height: 100.0,
              width: 100.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 13.0, top: 20.0),
                child: Text("SetList", style: SetListTextStyles.homeTitle)),
          ],
        ));
  }

  Widget _loginButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 40.0),
        child: new ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 50.0),
            child: new RaisedButton(
                onPressed: () {
                  loginBloc.signIn.add(null);
                },
                color: primaryColor,
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Image.asset('assets/google_logo.png'),
                      new Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: const Text(
                            'Log in with Google',
                            style: TextStyle(
                                fontFamily: 'Rubik Medium',
                                color: Colors.white),
                          ))
                    ]))));
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.dispose();
  }
}
