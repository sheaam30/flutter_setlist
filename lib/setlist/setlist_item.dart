import 'package:flutter/material.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/setlist.dart';

class SetListItem extends StatelessWidget {
  final SetList setList;
  final PageRoute route;
  final Function dismissFunction;

  SetListItem(this.setList, this.route, this.dismissFunction);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(setList.name),
      direction: DismissDirection.endToStart,
      background: buildContainer(),
      onDismissed: (direction) => dismissFunction(),
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
