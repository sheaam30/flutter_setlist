import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/setlist.dart';
import 'package:setlist/setlist/setlist_bloc.dart';
import 'package:setlist/setlist/setlist_item.dart';
import 'package:setlist/songlist/songlist.dart';

class SetListWidget extends StatefulWidget {
  final FirebaseUser firebaseUser;

  SetListWidget(this.firebaseUser);

  @override
  SetListStateWidget createState() {
    return SetListStateWidget();
  }
}

class SetListStateWidget extends State<SetListWidget> {
  String setListDialogText;

  SetListStateWidget();

  @override
  Widget build(BuildContext context) {
    final setListBlc = SetListBloc();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
        backgroundColor: backgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _getFab(),
        bottomNavigationBar: buildBottomAppBar(),
        body: StreamBuilder<List<Set>>(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<SetList> list = snapshot.data;
            if (list == null || list.length == 0) {
              return Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Add a Set to get started!",
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Rubik Light'),
                  ));
            } else {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return SetListItem(list[index], getPageRoute(list[index]));
                },
                itemCount: list == null ? 0 : list.length,
              );
            }
          },
        ));
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      hasNotch: false,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            color: primaryColor,
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
          IconButton(
            color: primaryColor,
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  FloatingActionButton _getFab() {
    return FloatingActionButton.extended(
      elevation: 4.0,
      icon: const Icon(
        Icons.add,
        color: Colors.white70,
      ),
      label: const Text(
        'Add a Set',
        style: TextStyle(color: Colors.white70),
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text(
                  "Add Set",
                  textAlign: TextAlign.center,
                ),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextField(
                        autofocus: true,
                        onChanged: (string) {
                          setListDialogText = string;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
                            hintText: "Enter Set Name"),
                      ),
                      RaisedButton(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white70),
                        ),
                        onPressed: () {
                          Navigator.pop(context, setListDialogText);
                        },
                        color: primaryColor,
                      )
                    ],
                  ),
                ],
              );
            }).then((value) {
          if (value != null) {}
        });
      },
    );
  }

  PageRoute getPageRoute(var setList) =>
      MaterialPageRoute(builder: (context) => SongList(setList.name));
}
