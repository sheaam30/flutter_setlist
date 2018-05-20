import 'package:flutter/material.dart';
import 'package:setlist/bloc/setlist_provider.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/song.dart';

class SongListItem extends StatelessWidget {
  final Song song;

  SongListItem(this.song);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(song.name),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        var setListBloc = SetListProvider.of(context);
      },
      background: buildContainer(),
      child: GestureDetector(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: primaryColor,
                  ),
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
