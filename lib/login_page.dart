import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/home_page.dart';
import 'package:firebase_tutorial/register_page.dart';
import 'package:firebase_tutorial/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'firebase_service.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                      .signInWithEmailAndPassword(_email, _password);
                  if (result == "wrong-password") {
                    Toast(context, "Mật khẩu không chính xác");
                  } else if (result == "user-not-found") {
                    Toast(context, "Tài khoản không tồn tại");
                  }else if (result == "user-disabled") {
                    Toast(context, "Tài khoản đã bị khóa");
                  }else if (result == "error") {
                    Toast(context, "Error");
                  } else if (result == "success") {
                    Toast(context, "Login success");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: Text("Forgot password"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }

  void _checkLogin() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    });
  }
}
