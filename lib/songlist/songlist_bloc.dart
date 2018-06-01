import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:setlist/api/Api.dart';
import 'package:setlist/model/setlist.dart';
import 'package:setlist/model/song.dart';

class SetListResult {
  final SetList results;
  final bool hasError;

  SetListResult(this.results, [this.hasError = false]);
}

class SongListBloc {
  final Api _api;
  final SetList _setList;
  final FirebaseUser _firebaseUser;

  StreamController<Song> _addSong = StreamController.broadcast(sync: true);
  Sink<Song> get addSong => _addSong;

  StreamController<Song> _deleteSong = StreamController.broadcast(sync: true);
  Sink<Song> get deleteSong => _deleteSong;

  Stream<SetListResult> get setList {
    return _api
        .fetchSetListForUser(_setList.name, _firebaseUser.uid)
        .map((setList) => SetListResult(setList));
  }

  void dispose() {
    _addSong.close();
  }

  SongListBloc(this._firebaseUser, this._setList, this._api) {
    _addSong.stream.listen((song) =>
        _api.updateSetList(_firebaseUser.uid, _setList.addSong(song)));

    _deleteSong.stream.listen((song) =>
        _api.updateSetList(_firebaseUser.uid, _setList.removeSong(song)));
  }
}
