import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:setlist/api/Api.dart';
import 'package:setlist/model/setlist.dart';

class SetListResult {
  final List<SetList> results;
  final bool hasError;

  SetListResult(this.results, [this.hasError = false]);
}

class SetListBloc {
  final Api _api;
  final FirebaseUser _firebaseUser;

  StreamController<SetList> _addSet = StreamController.broadcast(sync: true);
  Sink<SetList> get addSet => _addSet;

  Stream<SetListResult> get setLists {
    return _api
        .fetchSetListsForUser(_firebaseUser.uid)
        .map((setList) => SetListResult(setList));
  }

  SetListBloc(this._api, this._firebaseUser) {
    _addSet.stream.listen((set) => _api.addSet(_firebaseUser.uid, set));
  }

  void dispose() {
    _addSet.close();
  }
}
