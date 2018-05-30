import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:setlist/api/Api.dart';
import 'package:setlist/auth_manager.dart';
import 'package:setlist/model/setlist.dart';
import 'package:setlist/model/song.dart';

class LoginBloc {
  final AuthManager _authManager = AuthManager();
  final Api _api = Api.api;

  StreamController<Null> _signIn = StreamController.broadcast(sync: true);
  Sink<Null> get signIn => _signIn;
  StreamController<Null> _signOut = StreamController.broadcast(sync: true);
  Sink<Null> get signOut => _signOut;

  Stream<FirebaseUser> get authStateChanged =>
      _authManager.firebaseInstance.onAuthStateChanged;
  Stream<FirebaseUser> get currentUser =>
      _authManager.firebaseInstance.currentUser().asStream();

  LoginBloc() {
    _signIn.stream.listen((_) => _authManager.signInWithGoogle());
    _signOut.stream.listen((_) => _authManager.signOutWithGoogle());
    SetList setList = SetList("MySet");
    setList.addSong(Song("name", "first"));
    setList.addSong(Song("name", "second"));
    setList.addSong(Song("name", "third"));
    _api.addSet(setList);
  }

  void dispose() {
    _signIn.close();
    _signOut.close();
  }
}
