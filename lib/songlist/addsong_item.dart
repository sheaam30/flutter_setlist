import 'package:flutter/material.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/song.dart';
import 'package:setlist/songlist/songlist_bloc.dart';

class AddSongItem extends StatelessWidget {
  final SongListBloc _songListBloc;

  AddSongItem(this._songListBloc);

  @override
  Widget build(BuildContext context) {
    String songName;
    String songArtist;

    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
                        "Add Song",
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
                                Navigator.pop(context,
                                    Song(songName, songArtist, DateTime.now()));
                              },
                              color: primaryColor,
                            )
                          ],
                        ),
                      ],
                    );
                  }).then((song) {
                if (song != null) {
                  _songListBloc.addSong.add(song);
                }
              });
            },
          )
        ],
      ),
    );
  }
}
