import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:setlist/colors.dart';
import 'package:setlist/songlist/addsong_item.dart';
import 'package:setlist/songlist/songlist_item.dart';

class SongList extends StatefulWidget {
  final String setTitle;

  SongList(this.setTitle);

  @override
  SongListState createState() => SongListState();
}

class SongListState extends State<SongList> {
  SongListState();

  Future<String> fetchTrack(String url) async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    return responseJson;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Set>(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Column();
        } else {
          return songList(snapshot);
        }
      },
    );
  }

  Widget songList(AsyncSnapshot snapshot) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(snapshot.data.name),
        ),
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
          itemCount:
              snapshot.data == null ? 1 : snapshot.data.songList.length + 1,
        ));
  }
}
