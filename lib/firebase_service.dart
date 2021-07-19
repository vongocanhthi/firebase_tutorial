import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    String result = "";
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        print("Sign up success");
        result = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        print("Tài khoản đã tồn tại");
        result = "email-already-in-use";
      }
      print("${e.code} : ${e.message}");
    }
    return result;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
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

  Future<String> sendPasswordResetEmail(String email) async {
    String result = "";
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if(e.code == "user-not-found"){
        print("Tài khoản không tồn tại");
        result = "user-not-found";
      }else if(e.code == "invalid-email"){
        print("Email không đúng định dạng");
        result = "invalid-email";
      }else{
        result = "error";
      }
      print("${e.code} : ${e.message}");
    }
    return result;
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
