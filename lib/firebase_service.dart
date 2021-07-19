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
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
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
