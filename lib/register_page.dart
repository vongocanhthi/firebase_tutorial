import 'dart:ui';

import 'package:firebase_tutorial/firebase_service.dart';
import 'package:firebase_tutorial/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                if (_email.isEmpty || _password.isEmpty) {
                  Toast(context, "Vui lòng nhập thông tin tài khoản");
                } else {
                  String result = await FirebaseService()
                      .createUserWithEmailAndPassword(_email, _password);
                  if(result == "email-already-in-use"){
                    Toast(context, "Tài khoản đã tồn tại");
                  }else if(result == "success"){
                    Toast(context, "Sign up success");
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
    );
  }
}
