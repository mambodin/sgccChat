import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userName =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance
        .collection('/ChatApp/PuC0dvcVj5P6i1B9Qmns/messages')
        .add({
      'chat': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userName['username']
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'Send Message...'),
                  onChanged: (value) {
                    setState(() {
                      _enteredMessage = value;
                    });
                  }),
            ),
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              onPressed: _sendMessage,
            )
          ],
        ));
  }
}
