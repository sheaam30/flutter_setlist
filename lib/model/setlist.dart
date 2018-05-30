import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:setlist/model/song.dart';

class SetList extends Model {
  List<Song> songList = List();
  String name;

  SetList(this.name);

  void addSong(Song song) {
    songList.add(song);
  }

  void removeSong(Song song) {
    songList.remove(song);
  }

  Song getIndex(int index) {
    return songList[index];
  }

  static SetList fromSnapshot(DocumentSnapshot document) {}

  toMap() {
    return {
      "name": name,
      "songList": songList.map((song) => song.toJson()).toList()
    };
  }
}
