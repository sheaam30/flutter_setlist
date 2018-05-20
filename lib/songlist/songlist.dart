import 'package:flutter/material.dart';
import 'package:setlist/bloc/setlist_provider.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/set.dart';
import 'package:setlist/songlist/songlist_item.dart';

class SongList extends StatelessWidget {
  //The SetList these songs belong to
  final Set setList;

  @override
  Widget build(BuildContext context) {
    final setListBloc = SetListProvider.of(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text(setList.name), backgroundColor: primaryColor),
      body: StreamBuilder<Set>(
        stream: setListBloc.selectedSet,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (index == snapshot.data.length + 1) {
                 return
              } else {
                return SongListItem(snapshot.data[index]);
              }
            },
            itemCount: snapshot.data == null ? 1 : snapshot.data.length + 1,
          );
        },
      ),
    );
  }

  SongList(this.setList);
}
