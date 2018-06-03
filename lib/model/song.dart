import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';

class Song extends Model {
  @required
  String name;
  String artist = "";
  String imageUrl;

  Song(this.name, [this.artist, this.imageUrl]);

  static Song fromSnapshot(Map<String, dynamic> json) {
    return Song(json['name'], json['artist'], json['imageUrl']);
  }

  toMap() {
    return {"name": name, "artist": artist, "imageUrl": imageUrl};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          artist == other.artist &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode => name.hashCode ^ artist.hashCode ^ imageUrl.hashCode;
}
