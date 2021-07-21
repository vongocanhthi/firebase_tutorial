import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  String? name;

  ChatPage(this.name);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isShowButtonSend = false;
  String _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.account_circle,
              size: 40,
            ),
            SizedBox(width: 10),
            Text(widget.name!),
          ],
        ),
        actions: [],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.image_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
                Flexible(
                  flex: 1,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _message = value;
                        _isShowButtonSend = _message.isEmpty ? false : true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Tin nhắn ...",
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: _isShowButtonSend
                //       ? IconButton(
                //           icon: Icon(Icons.send),
                //           color: Colors.blue,
                //           onPressed: () {},
                //         )
                //       : IconButton(
                //           icon: Icon(Icons.favorite),
                //           color: Colors.red,
                //           onPressed: () {},
                //         ),
                // ),
                IconButton(
                  icon: Icon(_isShowButtonSend ? Icons.favorite : Icons.send),
                  color: _isShowButtonSend ? Colors.red : Colors.blue,
                  onPressed: () {
                    if (_isShowButtonSend) {
                      print("aaa");
                    } else {
                      print("bbb");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Row(
      //   children: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.sticky_note_2_outlined,
      //         color: Colors.blue,
      //       ),
      //     ),
      //     Expanded(
      //       child: TextField(
      //         onChanged: (value) {},
      //         decoration: InputDecoration(
      //           hintText: "Tin nhắn ...",
      //           border: InputBorder.none,
      //         ),
      //         keyboardType: TextInputType.text,
      //       ),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.send,
      //         color: Colors.blue,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
