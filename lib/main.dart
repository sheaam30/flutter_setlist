import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setlist/bloc/setlist_provider.dart';
import 'package:setlist/bloc/setlistbloc.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/login/login_bloc.dart';
import 'package:setlist/login/login_page.dart';
import 'package:setlist/setlist/setlist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return SetListProvider(
      setListBloc: SetListBloc(),
      child: MaterialApp(
        theme: _buildDefaultTheme(),
        home: StreamBuilder(
          stream: loginBloc.authStateChanged,
          builder:
              (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              return SetListWidget();
            }
            return LoginPage();
          },
        ),
      ),
    );
  }

  ThemeData _buildDefaultTheme() {
    return new ThemeData(
        primaryColor: primaryLightColor,
        accentColor: primaryColor,
        backgroundColor: backgroundColor,
        fontFamily: "Rubik Regular");
  }
}
