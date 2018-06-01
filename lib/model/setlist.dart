import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:setlist/model/song.dart';

class SetList extends Model {
  List<Song> _songList = List();
  String _name;

  get name => _name;
  get songList => _songList;

  SetList(this._name);

  SetList addSong(Song song) {
    _songList.add(song);
    return this;
  }

  SetList removeSong(Song song) {
    _songList.remove(song);
    return this;
  }

  Song getIndex(int index) {
    return _songList[index];
  }

  static SetList fromSnapshot(DocumentSnapshot document) {
    List<Song> songList = List();

    List list = document.data['songList'];
    for (int i = 0; i < list.length; i++) {
      songList.add(
          Song.fromSnapshot(new Map<String, dynamic>.from(list.elementAt(i))));
    }

    return SetList(document.data['name']).._songList = songList;
  }

  toMap(String userId) {
    return {
      "userId": userId,
      "name": _name,
      "songList": _songList.map((song) => song.toMap()).toList()
    };
  }
}
