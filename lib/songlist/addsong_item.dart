import 'package:flutter/material.dart';
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
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
