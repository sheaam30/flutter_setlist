import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:setlist/model/setlist.dart';

class Api {
  final Firestore _firestore;
  final CollectionReference _setsRef;

  Api._(this._firestore) : _setsRef = _firestore.collection('setlists');

  static Api initialize(Firestore firestore) {
    api = Api._(firestore);
    return api;
  }

  static Api api;
  factory Api.instance() {
    return api;
  }

  void addSet(String userId, SetList setList) async {
    await _setsRef
        .document(nameUserHash(userId, setList.name))
        .setData(setList.toMap(userId))
        .whenComplete(() => print("Complete"))
        .catchError((onError) => print(onError));
  }

  void removeSet(String uid, SetList set) async {
    await _setsRef
        .document(nameUserHash(uid, set.name))
        .delete()
        .whenComplete(() => print("${set.name} Deleted"))
        .catchError((onError) => print(onError));
  }

  void updateSetList(String userId, SetList setList) async {
    await _setsRef
        .document(nameUserHash(userId, setList.name))
        .setData(setList.toMap(userId))
        .whenComplete(() => print("Updated: ${setList.name}"))
        .catchError((onError) => print(onError));
  }

  Stream<List<SetList>> fetchSetListsForUser(String userId) {
    return _setsRef
        .where('userId', isEqualTo: userId)
        .snapshots
        .asyncMap((QuerySnapshot snapshot) {
      return snapshot.documents.map((DocumentSnapshot document) {
        return SetList.fromSnapshot(document);
      }).toList();
    });
  }

  Stream<SetList> fetchSetListForUser(String setListName, String userId) {
    return _setsRef
        .where('userId', isEqualTo: userId)
        .where('name', isEqualTo: setListName)
        .snapshots
        .asyncMap((QuerySnapshot snapshot) {
      return SetList.fromSnapshot(snapshot.documents.first);
    });
  }

  String nameUserHash(String userId, String setListName) {
    return "${userId.hashCode + setListName.hashCode}";
  }
}
