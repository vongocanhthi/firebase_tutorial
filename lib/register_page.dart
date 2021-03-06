import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorial/constant.dart';
import 'package:firebase_tutorial/firebase_service.dart';
import 'package:firebase_tutorial/model/account.dart';
import 'package:firebase_tutorial/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DatabaseReference _reference = FirebaseDatabase.instance.reference();
  String _name = "";
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    _name = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  onChanged: (value) {
                    _email = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  onChanged: (value) {
                    _password = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                  ),
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_name.isEmpty || _email.isEmpty || _password.isEmpty) {
                      Toast(context, "Vui l??ng nh???p th??ng tin t??i kho???n");
                    } else {
                      String result = await FirebaseService()
                          .createUserWithEmailAndPassword(_email, _password);
                      if (result == "email-already-in-use") {
                        Toast(context, "T??i kho???n ???? t???n t???i");
                      } else if (result == "weak-password") {
                        Toast(context, "M???t kh???u ph???i c?? ??t nh???t 6 k?? t???");
                      } else if (result == "error") {
                        Toast(context, "Error");
                      } else if (result == "success") {
                        String _uid = FirebaseAuth.instance.currentUser!.uid;
                        _reference
                            .child(Constant().ACCOUNTS)
                            .child(_uid)
                            .set(
                              Account(
                                uid: _uid,
                                name: _name,
                                email: _email,
                                password: _password,
                              ).toJson(),
                            )
                            .then((value) => Toast(context, "Sign up success"));
                      }
                    }
                  },
                  child: Text("Register"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
