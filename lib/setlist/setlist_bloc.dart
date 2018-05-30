import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:setlist/api/Api.dart';
import 'package:setlist/model/setlist.dart';

class SetListBloc {
  final Api _api = Api.api;


  StreamController<Null> _signIn = StreamController.broadcast(sync: true);
  Sink<Null> get signIn => _signIn;
  StreamController<Null> _signOut = StreamController.broadcast(sync: true);
  Sink<Null> get signOut => _signOut;

  Stream<List<SetList>> get setLists =>
      _api.fetchSetListForUser(userID)


  SetListBloc() {
  }
}
