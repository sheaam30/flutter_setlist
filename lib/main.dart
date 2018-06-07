import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:setlist/api/Api.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/login/login_bloc.dart';
import 'package:setlist/login/login_page.dart';
import 'package:setlist/setlist/setlist.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'SetList',
    options: const FirebaseOptions(
      googleAppID: '1:700827434064:android:33d42b35441389ec',
      gcmSenderID: '700827434064',
      databaseURL: 'https://setlist-91ac5.firebaseio.com',
      apiKey: 'AIzaSyD5MKxqKu3sLzyTuhARIKLHNdasA08dm-A',
      projectID: 'setlist-91ac5',
    ),
  );
  final Firestore firestore = new Firestore(app: app);

  Api.initialize(firestore);

  runApp(new MyApp(firestore));
}

class MyApp extends StatelessWidget {
  final Firestore firestore;
  final LoginBloc _loginBloc;

  bool firstNullData = false;

  MyApp(this.firestore) : _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: _buildDefaultTheme(), home: buildHomeWidget());
  }

  Widget buildHomeWidget() {
    return StreamBuilder(
      stream: _loginBloc.authStateChanged,
      builder: (_, snapshot) {
        if (!snapshot.hasData && !firstNullData) {
          firstNullData = true;
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return SetListWidget(snapshot.data);
        } else {
          return LoginPage();
        }
      },
    );
  }

  ThemeData _buildDefaultTheme() {
    return new ThemeData(
        buttonColor: primaryColor,
        primaryColor: primaryColor,
        accentColor: primaryColor,
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white70)),
        backgroundColor: backgroundColor,
        fontFamily: "Rubik Regular");
  }
}
