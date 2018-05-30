import 'package:flutter/material.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/song.dart';

class AddSongItem extends StatelessWidget {
  final Set set;

  AddSongItem(this.set);

  @override
  Widget build(BuildContext context) {
    String songName;
    String songArtist;

    return Column(
      children: <Widget>[
        FloatingActionButton.extended(
          elevation: 4.0,
          icon: const Icon(
            Icons.add,
            color: Colors.white70,
          ),
          label: const Text(
            'Add Song',
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
                              songName = string;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
                                hintText: "Enter Song Name"),
                          ),
                          TextField(
                            onChanged: (string) {
                              songArtist = string;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
                                hintText: "Enter Song Artist"),
                          ),
                          RaisedButton(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white70),
                            ),
                            onPressed: () {
                              Navigator.pop(
                                  context, Song(songName, songArtist));
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
        )
      ],
    );
  }
}
