import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setlist/bloc/setlist_provider.dart';
import 'package:setlist/bloc/setlistbloc.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/set.dart';
import 'package:setlist/setlist/setlist_item.dart';
import 'package:setlist/songlist/songlist.dart';

class SetListWidget extends StatefulWidget {
  @override
  SetListState createState() {
    return SetListState();
  }
}

class SetListState extends State<SetListWidget> {
  String setListDialogText;

  SetListState();

  @override
  Widget build(BuildContext context) {
    final setListBloc = SetListProvider.of(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
        backgroundColor: backgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _getFab(setListBloc),
        bottomNavigationBar: buildBottomAppBar(),
        body: StreamBuilder<List<Set>>(
          stream: setListBloc.sets,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null || snapshot.data.length == 0) {
              return Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Add a Set to get started!",
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Rubik Light'),
                  ));
            } else {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return SetListItem(
                      snapshot.data[index], getPageRoute(snapshot.data[index]));
                },
                itemCount: snapshot.data == null ? 0 : snapshot.data.length,
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            color: primaryColor,
            icon: Icon(Icons.file_download),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  FloatingActionButton _getFab(SetListBloc setListBloc) {
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
          if (value != null) {
            setListBloc.addition.add(Set(value));
          }
        });
      },
    );
  }

  PageRoute getPageRoute(var setList) =>
      MaterialPageRoute(builder: (context) => SongList(setList));
}
