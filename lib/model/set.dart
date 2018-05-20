import 'package:scoped_model/scoped_model.dart';
import 'package:setlist/model/song.dart';

class Set extends Model {
  List<Song> songList = List();
  final String name;

  Set(this.name);

  void addSong(Song song) {
    songList.add(song);
  }

  void removeSong(Song song) {
    songList.remove(song);
  }

  Song getIndex(int index) {
    return songList[index];
  }
}
