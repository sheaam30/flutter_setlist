import 'package:flutter/material.dart';
import 'package:setlist/model/song.dart';

class SongListItem extends StatelessWidget {
  final Song song;
  final Function dismissFunction;

  SongListItem(this.song, this.dismissFunction);

  @override
  Widget build(BuildContext context) {
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
}
