import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Chat/chat_screen.dart';

class Hello extends StatefulWidget {
  @override
  _HelloState createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: RaisedButton(onPressed: () async {
          FirebaseUser u = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: 'A91989@gmail.com', password: '1234567')).user;
          if(u!=null){
            Firestore.instance.collection('users').document(u.uid).setData({
              'nickname': 'A',
              'photoUrl': '',
              'id': u.uid,
              'createdAt': DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString(),
              'chattingWith': null
            });
            Route route = MaterialPageRoute(builder: (q)=>ChatScreen(
              id: u.uid,
              peerID: 'PhiRAhH0kMQ8POHrlYw76IESsez2',
            ));
            Navigator.push(context, route);
          }

        }),
      ),
    );
  }
}
