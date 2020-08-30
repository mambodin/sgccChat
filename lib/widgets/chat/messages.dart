import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('/ChatApp/PuC0dvcVj5P6i1B9Qmns/messages/')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final docs = streamSnapshot.data.documents;
                return ListView.builder(
                  reverse: true,
                  itemBuilder: (ctx, index) => MessageBubble(
                      docs[index]['chat'],
                      docs[index]['userId'] == futureSnapshot.data.uid,
                      docs[index]['username']),
                  itemCount: docs.length,
                );
              });
        });
  }
}
