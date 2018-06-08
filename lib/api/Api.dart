import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:setlist/model/setlist.dart';
import 'package:setlist/model/track_result.dart';

class Api {
  static const BASE_URL = "https://ws.audioscrobbler.com/2.0/";
  static const API_KEY = "ee84f4035ead21374b212a3924180a6c";

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
        .snapshots()
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
        .snapshots()
        .asyncMap((QuerySnapshot snapshot) {
      return SetList.fromSnapshot(snapshot.documents.first);
    });
  }

  String nameUserHash(String userId, String setListName) {
    return "${userId.hashCode + setListName.hashCode}";
  }

  Future<SearchResult> trackSearch(String searchString) async {
    final String path =
        "?method=track.search&track=$searchString&api_key=$API_KEY&format=json";
    final response = await http.get(BASE_URL + path);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      if (responseJson != null) {
        return SearchResult.fromJson(responseJson);
      }
    } else {}
    return null;
  }
}
