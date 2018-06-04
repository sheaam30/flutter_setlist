import 'package:flutter/material.dart';
import 'package:setlist/model/song.dart';

class SongListItem extends StatelessWidget {
  final Song song;
  final Function dismissFunction;

  SongListItem(this.song, this.dismissFunction);

  @override
  Widget build(BuildContext context) {
    if (song.artist != null && song.imageUrl != null) {
      return _buildCompleteSongTile();
    } else {
      return _buildSongNameTile();
    }
  }

  Container buildContainer() {
    return Container(
        color: Colors.white30,
        alignment: Alignment.centerRight,
        child: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {},
        ));
  }

  Widget _buildSongNameTile() {
    return Dismissible(
      key: Key(song.name),
      direction: DismissDirection.endToStart,
      background: buildContainer(),
      onDismissed: (direction) => dismissFunction(),
      child: GestureDetector(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(song.name,
                    style:
                        TextStyle(fontFamily: 'Rubik Medium', fontSize: 16.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteSongTile() {
    return Dismissible(
      key: Key(song.name),
      direction: DismissDirection.endToStart,
      background: buildContainer(),
      onDismissed: (direction) => dismissFunction(),
      child: GestureDetector(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: Image.network(song.imageUrl),
                  title: Text(song.name,
                      style: TextStyle(
                          fontFamily: 'Rubik Medium', fontSize: 16.0)),
                  subtitle: Text(
                    song.artist,
                    style: TextStyle(fontSize: 12.0),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
