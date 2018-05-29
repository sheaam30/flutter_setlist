import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  FirebaseAuth get firebaseInstance => _auth;

  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount currentUser = _googleSignIn.currentUser;
    if (currentUser == null) {
      currentUser = await _googleSignIn.signInSilently();
    }
    if (currentUser == null) {
      try {
        currentUser = await _googleSignIn.signIn();
      } catch (error) {
        print(error);
      }
    }

    if (currentUser != null) {
      FirebaseUser user = _validateUser(currentUser);
      return user;
    }

    return null;
  }

  _validateUser(GoogleSignInAccount currentUser) async {
    if (currentUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await currentUser.authentication;

      final FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      assert(!user.isAnonymous);

      return user;
    }
  }

  Future<Null> signOutWithGoogle() async {
    await _auth.signOut();
    _googleSignIn.signOut();
  }
}
