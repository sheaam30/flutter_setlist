import 'package:scoped_model/scoped_model.dart';

class Song extends Model {
  String name;
  String artist;

  Song(this.name, this.artist);

  toJson() {
    return {"name": name, "artist": artist};
  }
}
