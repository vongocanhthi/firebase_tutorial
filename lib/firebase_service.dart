import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        print("Sign up success");
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    String result = "";
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential != null) {
        print("Login success");
        result = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        print("Mật khẩu không chính xác");
        result = "wrong-password";
      } else if (e.code == "user-not-found") {
        print("Tài khoản không tồn tại");
        result = "user-not-found";
      }
    }
    return result;
  }

  void signOut() async {
    await _auth.signOut();
  }

  void sendEmailVerification() async {
    User? user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  void deleteUser() async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        print(
            "The user must reauthenticate before this operation can be executed.");
      } else {
        print(e.message);
      }
    }
  }
}
