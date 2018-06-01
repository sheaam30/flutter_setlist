import 'package:scoped_model/scoped_model.dart';

class Song extends Model {
  String name;
  String artist;
  DateTime dateAdded;

  Song(this.name, this.artist, this.dateAdded);

  static Song fromSnapshot(Map<String, dynamic> json) {
    return Song(json['name'], json['artist'], json['dateAdded']);
  }

  toMap() {
    return {"name": name, "artist": artist, "dateAdded": dateAdded};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          artist == other.artist;

  @override
  int get hashCode => name.hashCode ^ artist.hashCode;
}
