import 'package:flutter/material.dart';
import 'package:setlist/model/track_result.dart';

class SearchItem extends StatelessWidget {
  final TrackResult trackResult;
  final Function addFunction;

  SearchItem(this.trackResult, this.addFunction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              trailing: ActionChip(
                label: Text("Add"),
                onPressed: () => addFunction(trackResult),
              ),
              leading: Image.network(trackResult.imageUrl),
              title: Text(trackResult.name,
                  style: TextStyle(fontFamily: 'Rubik Medium', fontSize: 16.0)),
              subtitle: Text(
                trackResult.artist == null ? "" : trackResult.artist,
                style: TextStyle(fontSize: 12.0),
              )),
        ],
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
