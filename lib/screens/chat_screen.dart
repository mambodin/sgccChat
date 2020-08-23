import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SGCC CHAT"),
        actions: [
          DropdownButton(
              icon: Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [Icon(Icons.exit_to_app), Text('Logout')],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              }),
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      )),
    );
  }
}
// floatingActionButton: FloatingActionButton(
//     child: Icon(Icons.add),
//     onPressed: () {
//       Firestore.instance
//           .collection('/ChatApp/PuC0dvcVj5P6i1B9Qmns/messages')
//           .add({'chat': 'This was added when i click button'});
//       //   .snapshots()
//       //   .listen((data) {
//       // data.documents.forEach((element) {
//       //   print(element['chat']);
//       // });

//       // });
//     }),
