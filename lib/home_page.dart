import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorial/constant.dart';
import 'package:firebase_tutorial/model/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _menuOptions = ["Đổi mật khẩu", "Đăng xuất"];

  int _currentIndexItem = 0;

  // List<Account> _accountList = [];
  DatabaseReference _reference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          decoration: InputDecoration(
            hintText: "Tìm bạn bè ...",
            hintStyle: TextStyle(
              color: Colors.white54,
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              _handleClick(value);
            },
            itemBuilder: (BuildContext context) {
              return _menuOptions.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getAccountList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Account>? _accountList = snapshot.data as List<Account>?;
              return ListView.builder(
                itemCount: _accountList!.length,
                itemBuilder: (context, index) {
                  Account _account = _accountList[index];
                  return ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 50,
                    ),
                    title: Text("${_account.name}"),
                    subtitle: Text("SubTitle"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(_account.name),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
            ;
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: _currentIndexItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            title: Text("Tin nhắn"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page_outlined),
            title: Text("Danh bạ"),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndexItem = index;
          });
        },
      ),
    );
  }

  void _handleClick(String value) {
    if (value == _menuOptions[0]) {
      print(_menuOptions[0]);
    } else if (value == _menuOptions[1]) {
      print(_menuOptions[1]);
    }
  }

  Future<List<Account>> _getAccountList() async {
    List<Account> _accountList = [];
    var _user = FirebaseAuth.instance.currentUser;

    await _reference
        .child(Constant().ACCOUNTS)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> data = snapshot.value;
      data.forEach((key, value) {
        if (value["uid"] != _user!.uid) {
          Account account = Account(
            uid: value["uid"],
            name: value["name"],
            email: value["email"],
            password: value["password"],
          );
          _accountList.add(account);
        }
      });
    });
    print("${_accountList.length}");
    return _accountList;
  }
}
