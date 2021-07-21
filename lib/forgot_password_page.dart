import 'package:firebase_tutorial/firebase_service.dart';
import 'package:firebase_tutorial/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String _email = "";
  bool _isClick = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
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
            ElevatedButton(
              onPressed: () async {
                if (_isClick) {
                  if (_email.isEmpty) {
                    Toast(context, "Vui lòng nhập email");
                  } else {
                    String result =
                        await FirebaseService().sendPasswordResetEmail(_email);
                    if (result == "user-not-found") {
                      Toast(context, "Tài khoản không tồn tại");
                    } else if (result == "invalid-email") {
                      Toast(
                          context,
                          "Email không đúng định dạng"
                          "");
                    } else if (result == "error") {
                      Toast(context, "error");
                    } else if (result == "") {
                      setState(() {
                        _isClick = false;
                        Toast(context,
                            "Reset password thành công. Vui lòng kiểm tra email");
                        Future.delayed(Duration(seconds: 5)).then((value) {
                          setState(() {
                            _isClick = true;
                          });
                        });
                      });
                    }
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    _isClick ? Colors.blue : Colors.grey),
              ),
              child: Text("Send password"),
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
