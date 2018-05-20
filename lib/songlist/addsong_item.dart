import 'package:flutter/material.dart';
import 'package:setlist/bloc/setlist_provider.dart';
import 'package:setlist/colors.dart';

class AddSongItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final setListProvider = SetListProvider.of(context);

    return MaterialButton(
        key: Key("Add"),
        color: primaryColor,
        child: Text("Add Song"),
        textColor: Colors.white70,
        onPressed: () {});
  }
}
