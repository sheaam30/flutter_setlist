import 'package:flutter/material.dart';
import 'package:setlist/bloc/setlist_provider.dart';
import 'package:setlist/bloc/setlistbloc.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/setlist/setlist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SetListProvider(
      setListBloc: SetListBloc(),
      child: MaterialApp(
        theme: _buildDefaultTheme(),
        home: SetListWidget(),
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
