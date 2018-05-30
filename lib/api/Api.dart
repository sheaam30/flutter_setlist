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

  void addSet(SetList set) async {
    await _setsRef.document(set.name).setData(set.toMap()).whenComplete(() {
      print("Complete");
    }).catchError((onError) {
      print(onError);
    });
  }

  Stream<List<SetList>> fetchSetListForUser(String userID) {
    return _setsRef
        .where('userID', isEqualTo: userID)
        .snapshots
        .asyncMap((QuerySnapshot snapshot) {
      return snapshot.documents.map((DocumentSnapshot document) {
        return SetList.fromSnapshot(document);
      }).toList();
    });
  }
}
