import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setlist/api/Api.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/setlist.dart';
import 'package:setlist/songlist/addsong_item.dart';
import 'package:setlist/songlist/songlist_bloc.dart';
import 'package:setlist/songlist/songlist_item.dart';

class SongList extends StatefulWidget {
  final SetList _setList;
  final FirebaseUser _firebaseUser;

  SongList(this._firebaseUser, this._setList);

  @override
  SongListState createState() => SongListState(_firebaseUser, _setList);
}

class SongListState extends State<SongList> {
  final SongListBloc _songListBloc;
  final SetList _setList;
  final FirebaseUser _firebaseUser;

  SongListState(this._firebaseUser, this._setList)
      : _songListBloc = SongListBloc(_firebaseUser, _setList, Api.api);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SetListResult>(
      stream: _songListBloc.setList,
      builder: (BuildContext context, AsyncSnapshot<SetListResult> snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return songList(snapshot.data.results);
        }
      },
    );
  }

  Widget songList(SetList setList) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(_setList.name),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (setList == null ||
                setList.songList.length == 0 ||
                index == setList.songList.length) {
              return AddSongItem(_songListBloc);
            } else {
              return SongListItem(setList.songList[index],
                  () => _songListBloc.deleteSong.add(setList.songList[index]));
            }
          },
          itemCount: setList == null ? 1 : setList.songList.length + 1,
        ));
  }
}
