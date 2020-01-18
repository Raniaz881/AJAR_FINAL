import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
//
//String senderID = 'xHsC4JYdHxXS61vBaOMTFAxHjtB2';
//String yourOwnID = 'xHsC4JYdHxXS61vBaOMTFAxHjtB2';
//String receiverID = '9qCkDwc37egW0tzdm0fsZuNcsH12';
//String senderIDName = 'amrit';
//String receiverIDName = 'fateh';

String collectionRequests = 'requests';
String collectionFriends = 'friends';
String collectionContracts = 'contracts';

class SendProposal extends StatefulWidget {
  @override
  _SendProposalState createState() => _SendProposalState();
}

class _SendProposalState extends State<SendProposal> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: RaisedButton(onPressed: () {
//          final DocumentReference documentReference =
//          Firestore.instance.document("users/${fatehPreferences.getString('myUID')}/$collectionFriends/$receiverID");
//
//          documentReference.snapshots().listen((datasnapshot) {
//            //FINDING A SPECIFICDOCUMENT IS EXISTING INSIDE A COLLECTION
//
//            if (datasnapshot.exists) {
//              setState(() {
//                showDialog(context: context,builder: (_){
//                  return AlertDialog(
//                    content: Text('You are already friends, Please talk with him in chat section'),
//                  );
//                });
//             ///   myText1 = "Document exist";
//              });
//            } else if (!datasnapshot.exists) {
//              setState(() {
//               // myText2 = "Document not exist";
//                Firestore.instance
//                    .collection('users')
//                    .document(receiverID)
//                    .collection(collectionRequests)
//                    .document(senderID)
//                    .setData({
//                  'requestByID': senderID,
//                  'requestToID': receiverID,
//                  'requestByIDName': senderIDName,
//                  'requestToIDName': receiverIDName,
//                  'time': DateTime.now().millisecondsSinceEpoch
//                }).then((_){
//                  Fluttertoast.showToast(msg: 'Request Sent');
//                });
//
//              });
//            }
//          });


        }),
      ),
    );
  }
}


