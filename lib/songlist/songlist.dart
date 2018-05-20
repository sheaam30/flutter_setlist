import 'package:flutter/material.dart';
import 'package:setlist/bloc/setlist_provider.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/set.dart';
import 'package:setlist/songlist/addsong_item.dart';
import 'package:setlist/songlist/songlist_item.dart';

class SongList extends StatelessWidget {
  //The SetList these songs belong to

  @override
  Widget build(BuildContext context) {
    final setListBloc = SetListProvider.of(context);
    return StreamBuilder<Set>(
      stream: setListBloc.selectedSet,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Column();
        } else {
          return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                  title: Text(snapshot.data.name),
                  backgroundColor: primaryColor),
              body: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data == null ||
                      snapshot.data.songList.length == 0 ||
                      index == snapshot.data.songList.length) {
                    return AddSongItem(snapshot.data);
                  } else {
                    return SongListItem(snapshot.data.songList[index]);
                  }
                },
                itemCount: snapshot.data == null
                    ? 1
                    : snapshot.data.songList.length + 1,
              ));
        }
      },
    );
  }

  SongList();
}
