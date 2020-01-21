import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Friend_function/sendPropasal.dart';
import 'package:flutter_app/main.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Flexible(child: _buildBody(context)),
          ],
        ));
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(ajarPreferences.getString('myUID'))
          .collection(collectionRequests)
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
      child: Container(
        child: InkWell(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data['requestByIDName'],
                                style: TextStyle(
                                    color:Color(0xFF50A0A0),
                                    fontWeight: FontWeight.w500),
                                maxLines: 6,
                              )),
                        ],
                      ),
                    ),
                    Flexible(child: Container()),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 20.0, top: 13.0, right: 5.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Writing data to friends
                          Firestore.instance
                              .collection('users')
                              .document(data['TR'])
                              .collection(collectionFriends)
                              .document(data['requestToID'])
                              .setData({
                            'friendID': data['requestToID'],
                            'friendIDName': data['requestToIDName'],
                            'myID': data['requestByID'],
                            'myName': data['requestByIDName'],
                          });
                          // Writing data to own friends collection
                          Firestore.instance
                              .collection('users')
                              .document(data['requestToID'])
                              .collection(collectionFriends)
                              .document(data['requestByID']).setData({
                            'friendID': data['requestByID'],
                            'friendIDName': data['requestByIDName'],
                            'myID': data['requestToID'],
                            'myName': data['requestToIDName'],
                          });
                          // Deleting request
                          Firestore.instance
                              .collection('users')
                              .document(data['requestToID'])
                              .collection(collectionRequests)
                              .document(data['requestByID']).delete();
                        },
                        child: Text(
                          "Approve",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Color(0xFF50A0A0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 13.0, right: 10.0),
                      child: RaisedButton(
                        onPressed: () {
                          //  Deleting request
                          Firestore.instance
                              .collection('users')
                              .document(data['requestToID'])
                              .collection(collectionRequests)
                              .document(data['requestByID']).delete();
                        },
                        child: Text(
                          "Reject",
                          style: TextStyle(
                            color: Color(0xFF50A0A0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 5.0,
                  color: Colors.black,
                  indent: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
