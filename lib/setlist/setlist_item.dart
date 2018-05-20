import 'package:flutter/material.dart';
import 'package:setlist/bloc/setlist_provider.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/set.dart';

class SetListItem extends StatelessWidget {
  final Set setList;
  final PageRoute route;

  SetListItem(this.setList, this.route);

  @override
  Widget build(BuildContext context) {
    var setListBloc = SetListProvider.of(context);

    return Dismissible(
      key: Key(setList.name),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setListBloc.remove.add(setList);
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
                    title: Text(setList.name,
                        style: TextStyle(
                            fontFamily: 'Rubik Medium', fontSize: 16.0)),
                    subtitle: Text(
                      "Songs ${setList.songList.length.toString()}",
                      style: TextStyle(fontSize: 12.0),
                    )),
              ],
            ),
          ),
          onTap: () {
            setListBloc.selected.add(setList);
            Navigator.push(context, route);
          }),
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
