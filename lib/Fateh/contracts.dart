import 'dart:io';
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class ContractScreen extends StatefulWidget {
  @override
  _ContractScreenState createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
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
          .collection(ajarPreferences.getString('myUID'))
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
            width: MediaQuery.of(context).size.width,
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
                          data['contractByName'] ==
                                  ajarPreferences.getString('nickname')
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'you sent a contract to ${data['contractToName']}',
                                    style: TextStyle(
                                        color: Color(0xFF50A0A0),
                                        fontWeight: FontWeight.w500),
                                    maxLines: 6,
                                  ))
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${data['contractByName']} sent a contract',
                                    style: TextStyle(
                                        color: Color(0xFF50A0A0),
                                        fontWeight: FontWeight.w500),
                                    maxLines: 6,
                                  )),
                          data['contractByName'] ==
                                  ajarPreferences.getString('nickname')
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Your Status ${data['contractByAgree']}',
                                    style: TextStyle(
                                        color: Color(0xFF50A0A0),
                                        fontWeight: FontWeight.w500),
                                    maxLines: 6,
                                  ))
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Your Status ${data['contractToAgree']}',
                                    style: TextStyle(
                                        color: Color(0xFF50A0A0),
                                        fontWeight: FontWeight.w500),
                                    maxLines: 6,
                                  )),
                          data['contractByName'] !=
                                  ajarPreferences.getString('nickname')
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${data['contractByName']} Status ${data['contractByAgree']}',
                                    style: TextStyle(
                                        color: Color(0xFF50A0A0),
                                        fontWeight: FontWeight.w500),
                                    maxLines: 6,
                                  ))
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${data['contractToName']} Status ${data['contractToAgree']}',
                                    style: TextStyle(
                                        color: Color(0xFF50A0A0),
                                        fontWeight: FontWeight.w500),
                                    maxLines: 6,
                                  )),
                        ],
                      ),
                    ),
                    Flexible(child: Container()),

                  ],
                ),
                RaisedButton(
                  onPressed: () {
                    downloadFile(data['pdfUrl'], data['time']);
                  },
                  child: Text('View Agreement'),
                ),

                data['contractByID'] == ajarPreferences.getString('myUID') ||
                        data['contractToAgree'] == 'Accepted' ||
                        data['contractToAgree'] == 'Rejected'
                    ? Container()
                    : Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, top: 13.0, right: 5.0),
                        child: RaisedButton(
                          onPressed: () {
                            // Writing data  to own
                            Firestore.instance
                                .collection('users')
                                .document(ajarPreferences.getString('myUID'))
                                .collection(ajarPreferences.getString('myUID'))
                                .document(data.documentID)
                                .updateData({
                              'contractToAgree': 'Accepted',
                            });
                            // Writing to other documents
                            Firestore.instance
                                .collection('users')
                                .document(data['contractToID'])
                                .collection(data['contractToID'])
                                .document(data.documentID)
                                .updateData({
                              'contractToAgree': 'Accepted',
                            });
                            onSendMessage(
                                '${ajarPreferences.getString('nickname')} accepted your contract',
                                0,
                                data['groupID'],
                                data['contractToID'],
                                data['contractByID']);
                          },
                          child: Text(
                            "Approve",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          color:Color(0xFF50A0A0),
                        ),
                      ),
                data['contractByID'] == ajarPreferences.getString('myUID')
                    ||
                    data['contractToAgree'] == 'Accepted' ||
                    data['contractToAgree'] == 'Rejected'
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(top: 13.0, right: 10.0),
                        child: RaisedButton(
                          onPressed: () {
                            // Writing data  to own
                            Firestore.instance
                                .collection('users')
                                .document(ajarPreferences.getString('myUID'))
                                .collection(ajarPreferences.getString('myUID'))
                                .document(data.documentID)
                                .updateData({
                              'contractToAgree': 'Rejected',
                            });
                            // Writing to other documents
                            Firestore.instance
                                .collection('users')
                                .document(data['contractToID'])
                                .collection(data['contractToID'])
                                .document(data.documentID)
                                .updateData({
                              'contractToAgree': 'Rejected',
                            });
                            onSendMessage(
                                '${ajarPreferences.getString('nickname')} rejected your contract',
                                0,
                                data['groupID'],
                                data['contractToID'],
                                data['contractByID']);
                          },
                          child: Text(
                            "Reject",
                            style: TextStyle(
                              color:Color(0xFF50A0A0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Colors.white,
                        ),
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

  Future<void> downloadFile(String url, String fileName) async {
    String extension = 'pdf';
    var dio = new Dio();
    var dir = await getExternalStorageDirectory();
    var knockDir =
        await new Directory('${dir.path}/AZAR').create(recursive: true);
    print("Hello checking the pdf in Externaal Sorage ");
    io.File('${knockDir.path}/$fileName.$extension').exists().then((a) async {
      print(a);
      if (a) {
        print("Opening file");
        PdfViewer.loadFile('${knockDir.path}/$fileName.$extension');
        //PdfViewer.loadFile('${knockDir.path}/${fileName}.${extension}');
        //PdfViewer.loadFile('${knockDir.path}/${fileName}.${extension}');
        return;
      } else {
        Fluttertoast.showToast(msg: 'Downloading File, Please Wait');
        print("Downloading file");
        await dio.download(url, '${knockDir.path}/$fileName.$extension',
            onReceiveProgress: (rec, total) {
          //print("Rec: $rec , Total: $total");
          if (mounted) {
            setState(() {
              //    downloading = true;
              //progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
            });
          }
        });
        if (mounted) {
          setState(() {
            //downloading = false;
            //progressString = "Completed";
            print('${knockDir.path}');

            // TODO change with your pdf viewer
            PdfViewer.loadFile('${knockDir.path}/$fileName.$extension');
            //_message = "File is downloaded to your SD card 'iLearn' folder!";
          });
        }
        //downloadUpdate(document, false);
        print("Download completed");
      }
    });
    //Navigator.pop(context);
  }

  void onSendMessage(
      String content, int type, String groupChatId, String id, String peerId) {
    // type: 0 = text, 1 = file
    if (content.trim() != '') {
      var documentReference = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }
}
