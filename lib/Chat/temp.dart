//
//import 'dart:convert';
//import 'dart:io';
//import 'dart:io' as io;
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dio/dio.dart';
//import 'package:file_picker/file_picker.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter_app/models/message_model.dart';
//import 'package:flutter_app/models/users_model.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:intl/intl.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:pdftron_flutter/pdftron_flutter.dart';
//import 'dart:ui';
//import 'package:shared_preferences/shared_preferences.dart';
//
//final themeColor = Color(0xfff5a623);
//final primaryColor = Color(0xff203152);
//final greyColor = Color(0xffaeaeae);
//final greyColor2 = Color(0xffE8E8E8);
//
//class ChatScreen extends StatefulWidget {
//  final String peerID, id;
//
//  /// NOTE TO JORDAN : when your relate this to the backend you will
//  /// need a room id and pass the room id and based on the room id you will populate the messages
//
//  ChatScreen({this.peerID, this.id});
//
//  @override
//  _ChatScreenState createState() => _ChatScreenState(peerId: peerID, id: id);
//}
//
//class _ChatScreenState extends State<ChatScreen> {
//  _ChatScreenState({
//    Key key,
//    @required this.peerId,
//    @required this.id,
//  });
//
//  String peerId;
//  String id;
//
//  var listMessage;
//  String groupChatId;
//  SharedPreferences prefs;
//  File imageFile;
//  bool isLoading;
//  bool isShowSticker;
//  String imageUrl;
//  String tempDT;
//  bool isContractFileUploading = false;
//  bool downloading = true;
//  String tempDTD;
//  final TextEditingController textEditingController =
//  new TextEditingController();
//  final ScrollController listScrollController = new ScrollController();
//  final FocusNode focusNode = new FocusNode();
//  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
//  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//
//
////  _buildMessage(Message message, bool isMe) {
////    return Row(
////      children: <Widget>[
////        Container(
////          margin: isMe
////              ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
////              : EdgeInsets.only(
////                  top: 8.0,
////                  bottom: 8.0,
////                ),
////          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
////          width: MediaQuery.of(context).size.width * 0.75,
////          decoration: BoxDecoration(
////              color: isMe ? Theme.of(context).accentColor : Color(0xFFFFFEFEE),
////              borderRadius: isMe
////                  ? BorderRadius.only(
////                      topLeft: Radius.circular(15.0),
////                      bottomLeft: Radius.circular(15.0),
////                    )
////                  : BorderRadius.only(
////                      topRight: Radius.circular(15.0),
////                      bottomRight: Radius.circular(15.0),
////                    )),
////          child: Column(
////            crossAxisAlignment: CrossAxisAlignment.start,
////            children: <Widget>[
////              Text(
////                message.time,
////                style: TextStyle(
////                  color: Colors.blueGrey,
////                  fontWeight: FontWeight.w600,
////                  fontSize: 16.0,
////                ),
////              ),
////              SizedBox(height: 5.0),
////              Text(
////                message.text,
////                style: TextStyle(
////                  color: Colors.blueGrey,
////                  fontWeight: FontWeight.w600,
////                  fontSize: 16.0,
////                ),
////              ),
////            ],
////          ),
////        ),
////        !isMe
////            ? IconButton(
////                icon: message.isLiked
////                    ? Icon(Icons.favorite)
////                    : Icon(Icons.favorite_border),
////                iconSize: 30.0,
////                color: message.isLiked
////                    ? Theme.of(context).primaryColor
////                    : Colors.blueGrey,
////                onPressed: () {},
////              )
////            : SizedBox.shrink(),
////      ],
////    );
////  }
//
//  @override
//  void initState() {
//    super.initState();
//    focusNode.addListener(onFocusChange);
//
//    groupChatId = '';
//
//    isLoading = false;
//    isShowSticker = false;
//    imageUrl = '';
//    registerNotification();
//    configLocalNotification();
//
//    readLocal();
//  }
//
//  void registerNotification() {
//    firebaseMessaging.requestNotificationPermissions();
//
//    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
//      print('onMessage: $message');
//      showNotification(message['notification']);
//      return;
//    }, onResume: (Map<String, dynamic> message) {
//      print('onResume: $message');
//      return;
//    }, onLaunch: (Map<String, dynamic> message) {
//      print('onLaunch: $message');
//      return;
//    });
//
//    firebaseMessaging.getToken().then((token) {
//      print('token: $token');
//      //Firestore.instance.collection('users').document(id).updateData({'pushToken': token});
//    }).catchError((err) {
//      Fluttertoast.showToast(msg: err.message.toString());
//    });
//  }
//
//  void configLocalNotification() {
//    var initializationSettingsAndroid = new AndroidInitializationSettings(
//        'app_icon');
//    var initializationSettingsIOS = new IOSInitializationSettings();
//    var initializationSettings = new InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin.initialize(initializationSettings);
//  }
//
//  void showNotification(message) async {
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//      Platform.isAndroid
//          ? 'com.example.flutter_app'
//          : 'com.duytq.flutterchatdemo',
//      'Flutter chat demo',
//      'your channel description',
//      playSound: true,
//      enableVibration: true,
//      importance: Importance.Max,
//      priority: Priority.High,
//    );
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//    var platformChannelSpecifics =
//    new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, message['title'].toString(), message['body'].toString(),
//        platformChannelSpecifics,
//        payload: json.encode(message));
//  }
//
//
//  void onFocusChange() {
//    if (focusNode.hasFocus) {
//      // Hide sticker when keyboard appear
//      setState(() {
//        isShowSticker = false;
//      });
//    }
//  }
//
//  readLocal() async {
//    prefs = await SharedPreferences.getInstance();
//    //id = prefs.getString('id') ?? '';
//    if (id.hashCode <= peerId.hashCode) {
//      groupChatId = '$id-$peerId';
//    } else {
//      groupChatId = '$peerId-$id';
//    }
//// TODO Uncomment it
//    Firestore.instance
//        .collection('users')
//        .document(id)
//        .updateData({'chattingWith': peerId});
//
//    setState(() {});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        backgroundColor: Theme
//            .of(context)
//            .primaryColor,
//        appBar: AppBar(
//          title: Center(
//            child: Text(
//              //            widget.user.name,
//              "hbhbhj",
//              style: TextStyle(
//                fontSize: 28.0,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//          ),
//          elevation: 0.0,
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.more_horiz),
//              iconSize: 30.0,
//              color: Colors.white,
//              onPressed: () {},
//            ),
//          ],
//        ),
//        body: Stack(
//          children: <Widget>[
//            Column(
//              children: <Widget>[
//                Expanded(
//                  child: Container(
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(30.0),
//                            topRight: Radius.circular(30.0),
//                          )),
//                      child: ClipRRect(
//                        //this one activates when you scroll up the text won't go above the border it clips the text to maintain the shaped rounded view
//                          borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(30.0),
//                            topRight: Radius.circular(30.0),
//                          ),
//                          child: buildListMessage())),
//                ),
//                showContact? _buildFullContract(): Container(),
//                showContact ?Container(): _buildContract(),
//                showContact ?Container(): _buildKeyBoard()
//              ],
//            ),
//            buildLoading()
//          ],
//        ));
//  }
//
//  Widget buildListMessage() {
//    return groupChatId == ''
//        ? Center(
//        child: CircularProgressIndicator(
//            valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
//        : StreamBuilder(
//      stream: Firestore.instance
//          .collection('messages')
//          .document(groupChatId)
//          .collection(groupChatId)
//          .orderBy('timestamp', descending: true)
//          .snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return Center(
//              child: CircularProgressIndicator(
//                  valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
//        } else {
//          listMessage = snapshot.data.documents;
//          return ListView.builder(
//            padding: EdgeInsets.all(10.0),
//            itemBuilder: (context, index) =>
//                x(index, snapshot.data.documents[index]),
//            itemCount: snapshot.data.documents.length,
//            reverse: true,
//            controller: listScrollController,
//          );
//        }
//      },
//    );
//  }
//
//  Widget x(int index, DocumentSnapshot document) {
//    return Row(
//      children: <Widget>[
//        Container(
//          margin: document['idFrom'] == id
//              ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 70.0)
//              : EdgeInsets.only(
//            top: 8.0,
//            bottom: 8.0,
//          ),
//          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
//          width: MediaQuery
//              .of(context)
//              .size
//              .width * 0.75,
//          decoration: BoxDecoration(
//              color: document['idFrom'] == id
//                  ? Theme
//                  .of(context)
//                  .accentColor
//                  : Color(0xFFFFFEFEE),
//              borderRadius: document['idFrom'] == id
//                  ? BorderRadius.only(
//                topLeft: Radius.circular(15.0),
//                bottomLeft: Radius.circular(15.0),
//              )
//                  : BorderRadius.only(
//                topRight: Radius.circular(15.0),
//                bottomRight: Radius.circular(15.0),
//              )),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                DateFormat('dd MMM kk:mm').format(
//                    DateTime.fromMillisecondsSinceEpoch(
//                        int.parse(document['timestamp']))),
//                style: TextStyle(
//                  color: Colors.blueGrey,
//                  fontWeight: FontWeight.w600,
//                  fontSize: 10.0,
//                ),
//              ),
//              SizedBox(height: 5.0),
//              document['type'] == 0
//                  ? Text(
//                document['content'],
//                style: TextStyle(
//                  color: Colors.blueGrey,
//                  fontWeight: FontWeight.w600,
//                  fontSize: 16.0,
//                ),
//              )
//                  : Container(
//                child: Row(
//                  children: <Widget>[
//                    document['content'] == ''
//                        ? Container(
//                      height: 20,
//                      width: 20,
//                      child: Center(
//                        child: CircularProgressIndicator(
//                            valueColor:
//                            AlwaysStoppedAnimation<Color>(
//                                themeColor)),
//                      ),
//                    )
//                        : document[tempDTD] == null
//                        ? InkWell(
//                      onTap: () {
//                        tempDTD = DateTime
//                            .now()
//                            .millisecondsSinceEpoch
//                            .toString();
//
//                        downloadFile(document['content'],
//                            document['fileName'], document);
//                      },
//                      child: Icon(Icons.file_download),
//                    )
//                        : document[tempDTD] == false
//                        ? InkWell(
//                      onTap: () {
//                        tempDTD = DateTime
//                            .now()
//                            .millisecondsSinceEpoch
//                            .toString();
//
//                        downloadFile(document['content'],
//                            document['fileName'], document);
//                      },
//                      child: Icon(Icons.file_download),
//                    )
//                        : Container(
//                      height: 20,
//                      width: 20,
//                      child: Center(
//                        child: CircularProgressIndicator(
//                            valueColor:
//                            AlwaysStoppedAnimation<
//                                Color>(themeColor)),
//                      ),
//                    ),
//                    document['content'] == ''
//                        ? Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Text('File Uploading'),
//                    )
//                        : (document[tempDTD] == null
//                        ? Text('PDF File')
//                        : (document[tempDTD] == false)
//                        ? Text('PDF File')
//                        : Text('File Downloading')),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget buildLoading() {
//    return Positioned(
//      child: isLoading
//          ? Container(
//        child: Center(
//          child: CircularProgressIndicator(
//              valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
//        ),
//        color: Colors.white.withOpacity(0.8),
//      )
//          : Container(),
//    );
//  }
//
//  _buildKeyBoard() {
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 8.0),
//      color: Colors.white,
//      height: 60.0,
//      child: Row(
//        children: <Widget>[
//          IconButton(
//            icon: Icon(Icons.photo_library),
//            color: Theme
//                .of(context)
//                .primaryColor,
//            onPressed: () {
//              // TODO Pick File
//              showDialog(
//                  context: context,
//                  builder: (_) {
//                    return AlertDialog(
//                      content: Column(
//                        mainAxisSize: MainAxisSize.min,
//                        children: <Widget>[
//                          InkWell(
//                              onTap: () {
//                                pickFileFromPhone();
//                                Navigator.pop(context);
//                              },
//                              child: Text('Pick File From Phone')),
//                          InkWell(
//                              onTap: () {},
//                              child: Text('Pick File From Template')),
//                        ],
//                      ),
//                    );
//                  });
//            },
//          ),
//          Expanded(
//            child: TextField(
//              style: TextStyle(color: primaryColor, fontSize: 15.0),
//              controller: textEditingController,
//              decoration: InputDecoration.collapsed(
//                hintText: 'Type your message...',
//                hintStyle: TextStyle(color: greyColor),
//              ),
//              focusNode: focusNode,
//            ),
//          ),
//          Material(
//            child: new Container(
//              margin: new EdgeInsets.symmetric(horizontal: 8.0),
//              child: new IconButton(
//                icon: new Icon(Icons.send),
//                onPressed: () => onSendMessage(textEditingController.text, 0),
//                color: Theme
//                    .of(context)
//                    .primaryColor,
//              ),
//            ),
//            color: Colors.white,
//          ),
//        ],
//      ),
//    );
//  }
//
//  bool isLastMessageLeft(int index) {
//    if ((index > 0 &&
//        listMessage != null &&
//        listMessage[index - 1]['idFrom'] == id) ||
//        index == 0) {
//      return true;
//    } else {
//      return false;
//    }
//  }
//
//  bool isLastMessageRight(int index) {
//    if ((index > 0 &&
//        listMessage != null &&
//        listMessage[index - 1]['idFrom'] != id) ||
//        index == 0) {
//      return true;
//    } else {
//      return false;
//    }
//  }
//
//  void onSendMessage(String content, int type) {
//    // type: 0 = text, 1 = file
//    if (content.trim() != '') {
//      textEditingController.clear();
//      var documentReference = Firestore.instance
//          .collection('messages')
//          .document(groupChatId)
//          .collection(groupChatId)
//          .document(DateTime
//          .now()
//          .millisecondsSinceEpoch
//          .toString());
//
//      Firestore.instance.runTransaction((transaction) async {
//        await transaction.set(
//          documentReference,
//          {
//            'idFrom': id,
//            'idTo': peerId,
//            'timestamp': DateTime
//                .now()
//                .millisecondsSinceEpoch
//                .toString(),
//            'content': content,
//            'type': type
//          },
//        );
//      });
//      listScrollController.animateTo(0.0,
//          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//    } else {
//      Fluttertoast.showToast(msg: 'Nothing to send');
//    }
//  }
//
//  Future<void> pickFileFromPhone() async {
//    imageFile =
//    await FilePicker.getFile(fileExtension: 'pdf', type: FileType.CUSTOM);
//
//    if (imageFile != null) {
//      setState(() {
//        isLoading = true;
//      });
//      tempDT = DateTime
//          .now()
//          .millisecondsSinceEpoch
//          .toString();
//      onSendMessagePDF('', 1, tempDT);
//      setState(() {
//        isLoading = false;
//      });
//      uploadFile();
//    }
//  }
//
//  Future<void> downloadFile(String url, String fileName,
//      DocumentSnapshot document) async {
//    downloadUpdate(document, true);
//
//    String extension = 'pdf';
//    var dio = new Dio();
//    var dir = await getExternalStorageDirectory();
//    var knockDir =
//    await new Directory('${dir.path}/AZAR').create(recursive: true);
//    print("Hello checking the pdf in Externaal Sorage ");
//    io.File('${knockDir.path}/$fileName.$extension').exists().then((a) async {
//      print(a);
//      if (a) {
//        print("Opening file");
//        downloadUpdate(document, false);
//        showDialog(
//            context: context,
//            builder: (_) {
//              return AlertDialog(
//                content: Text('File has already been downloaded'),
//                actions: <Widget>[
//                  RaisedButton(onPressed: () {
//                    // TODO change with your pdf viewer
//                    PdfViewer.loadFile('${knockDir.path}/$fileName.$extension');
//                  },
//                    child: Text('Open File'),
//                  )
//                ],
//              );
//            });
//
//        //PdfViewer.loadFile('${knockDir.path}/${fileName}.${extension}');
//        return;
//      } else {
//        print("Downloading file");
//        await dio.download(url, '${knockDir.path}/$fileName.$extension',
//            onReceiveProgress: (rec, total) {
//              //print("Rec: $rec , Total: $total");
//              if (mounted) {
//                setState(() {
//                  downloading = true;
//                  //progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
//                });
//              }
//            });
//        if (mounted) {
//          setState(() {
//            downloading = false;
//            //progressString = "Completed";
//            print('${knockDir.path}');
//
//            // TODO change with your pdf viewer
//            PdfViewer.loadFile('${knockDir.path}/$fileName.$extension');
//            //_message = "File is downloaded to your SD card 'iLearn' folder!";
//          });
//        }
//        downloadUpdate(document, false);
//        print("Download completed");
//      }
//    });
//    //Navigator.pop(context);
//  }
//
//  Future uploadFile() async {
//    String fileName = DateTime
//        .now()
//        .millisecondsSinceEpoch
//        .toString();
//    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
//    StorageUploadTask uploadTask = reference.putFile(imageFile);
//    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
//      imageUrl = downloadUrl;
//      setState(() {
//        isLoading = false;
//        onSendMessagePDF(imageUrl, 1, tempDT);
//      });
//    }, onError: (err) {
//      setState(() {
//        isLoading = false;
//        imageFile=null;
//      });
//      Fluttertoast.showToast(msg: 'This file is not an pdf');
//    });
//  }
//  Future uploadContractFile() async {
//    print(imageFile);
//    String fileName = DateTime
//        .now()
//        .millisecondsSinceEpoch
//        .toString();
//    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
//    StorageUploadTask uploadTask = reference.putFile(imageFile);
//    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
//      imageUrl = downloadUrl;
//      setState(() {
//        isLoading = false;
//        isContractFileUploading = false;
//        imageFile=null;
//        onSendMessage('Contract has been sent to you, pleace trace it in contract section', 0,);
//      });
//    }, onError: (err) {
//      print(err);
//      setState(() {
//        isLoading = false;
//      });
//      Fluttertoast.showToast(msg: 'This file is not an pdf');
//    });
//  }
//
//  void onSendMessagePDF(String content, int type, String time) {
//    var documentReference = Firestore.instance
//        .collection('messages')
//        .document(groupChatId)
//        .collection(groupChatId)
//        .document(tempDT);
//
//    Firestore.instance.runTransaction((transaction) async {
//      await transaction.set(
//        documentReference,
//        {
//          'idFrom': id,
//          'idTo': peerId,
//          'timestamp': DateTime
//              .now()
//              .millisecondsSinceEpoch
//              .toString(),
//          'content': content,
//          'type': type,
//          'fileName': tempDT
//        },
//      );
//    });
//    listScrollController.animateTo(0.0,
//        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//  }
//
//  downloadUpdate(DocumentSnapshot document, bool isDownloading) {
//    var documentReference = Firestore.instance
//        .collection('messages')
//        .document(groupChatId)
//        .collection(groupChatId)
//        .document(document.documentID);
//
//    Firestore.instance.runTransaction((transaction) async {
//      await transaction.update(
//        documentReference,
//        {tempDTD: isDownloading},
//      );
//    });
//  }
//
//  Widget _buildContract() {
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 8.0),
//      color: Colors.greenAccent,
//      height: 60.0,
//      child: InkWell(
//        onTap: (){
//          setState(() {
//            showContact = true;
//          });
//        },
//        child: Row(
//          children: <Widget>[
//            Icon(Icons.add),
//            Text('Make Contract'),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _buildFullContract() {
//
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 8.0),
//      color: Colors.grey,
//      height: 120.0,
//      child: Column(
//        children: <Widget>[
//          Text('Make Contract'),
//          Row(
//            children: <Widget>[
//              IconButton(
//                icon: Icon(Icons.attach_file),
//                color: Theme
//                    .of(context)
//                    .primaryColor,
//                onPressed: () async {
//                  imageFile=null;
//                  imageFile =
//                  await FilePicker.getFile(fileExtension: 'pdf', type: FileType.CUSTOM);
//                },
//              ),
//              Text('Pick PDF File'),
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Checkbox(value: checkBoxValue, onChanged: checkBoxFunction),
//              RaisedButton(onPressed: (){
//                if(imageFile!=null){
//                  uploadContractFile();
//                  setState(() {
//                    showDialog(context: context,builder: (_){
//                      return AlertDialog(
//                        content: Text('Contract Send, You  can track the details in contract section'),
//                        actions: <Widget>[
//                          RaisedButton(onPressed: (){
//                            Navigator.pop(context);
//                          },
//                            child: Text('OK'),
//                          )
//                        ],
//                      );
//                    });
//                    showContact = false;
//                  });
//                }
//                else{
//                  showDialog(context: context,builder: (_){
//                    return AlertDialog(
//                      content: Text('Please attach pdf file'),
//                      actions: <Widget>[
//                        RaisedButton(onPressed: (){
//                          Navigator.pop(context);
//                        },
//                          child: Text('OK'),
//                        )
//                      ],
//                    );
//                  });
//                }
//              },
//                child: Text('Make Contrct'),
//              ),
//            ],
//          )
//        ],
//      ),
//    );
//  }
//
//  bool checkBoxValue = false;
//  bool showContact = false;
//  void checkBoxFunction(bool value) {
//    setState(() {
//      checkBoxValue = value;
//    });
//  }
//}
//
//class MakeContract extends StatefulWidget {
//  @override
//  _MakeContractState createState() => _MakeContractState();
//}
//
//class _MakeContractState extends State<MakeContract> {
//  bool checkBoxValue = false;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Column(
//        children: <Widget>[
//          Text('Please attach PDF file for contract '),
//          RaisedButton(onPressed: (){
//
//          },
//            child: Text('Attach File'),
//          ),
//          Checkbox(value: checkBoxValue, onChanged: checkBoxFunction),
//          RaisedButton(onPressed: (){
//
//          },
//            child: Text('Make Contrct'),
//          ),
//
//
//        ],
//      ),
//
//    );
//  }
//
//  void checkBoxFunction(bool value) {
//    setState(() {
//      checkBoxValue = value;
//    });
//  }
//}
//
//
//import 'dart:convert';
//import 'dart:io';
//import 'dart:io' as io;
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dio/dio.dart';
//import 'package:file_picker/file_picker.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter_app/models/message_model.dart';
//import 'package:flutter_app/models/users_model.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:intl/intl.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:pdftron_flutter/pdftron_flutter.dart';
//import 'dart:ui';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_app/Fateh/sendPropasal.dart';
//final themeColor = Color(0xfff5a623);
//final primaryColor = Color(0xff203152);
//final greyColor = Color(0xffaeaeae);
//final greyColor2 = Color(0xffE8E8E8);
//
//class ChatScreen extends StatefulWidget {
//  final String peerID, id;
//
//  /// NOTE TO JORDAN : when your relate this to the backend you will
//  /// need a room id and pass the room id and based on the room id you will populate the messages
//
//  ChatScreen({this.peerID, this.id});
//
//  @override
//  _ChatScreenState createState() => _ChatScreenState(peerId: peerID, id: id);
//}
//
//class _ChatScreenState extends State<ChatScreen> {
//  _ChatScreenState({
//    Key key,
//    @required this.peerId,
//    @required this.id,
//  });
//
//  String peerId;
//  String id;
//
//  var listMessage;
//  String groupChatId;
//  SharedPreferences prefs;
//  File imageFile;
//  bool isLoading;
//  bool isShowSticker;
//  String imageUrl;
//  String tempDT;
//  bool isContractFileUploading = false;
//  bool downloading = true;
//  String tempDTD;
//  final TextEditingController textEditingController =
//  new TextEditingController();
//  final ScrollController listScrollController = new ScrollController();
//  final FocusNode focusNode = new FocusNode();
//  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
//  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//
//
////  _buildMessage(Message message, bool isMe) {
////    return Row(
////      children: <Widget>[
////        Container(
////          margin: isMe
////              ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
////              : EdgeInsets.only(
////                  top: 8.0,
////                  bottom: 8.0,
////                ),
////          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
////          width: MediaQuery.of(context).size.width * 0.75,
////          decoration: BoxDecoration(
////              color: isMe ? Theme.of(context).accentColor : Color(0xFFFFFEFEE),
////              borderRadius: isMe
////                  ? BorderRadius.only(
////                      topLeft: Radius.circular(15.0),
////                      bottomLeft: Radius.circular(15.0),
////                    )
////                  : BorderRadius.only(
////                      topRight: Radius.circular(15.0),
////                      bottomRight: Radius.circular(15.0),
////                    )),
////          child: Column(
////            crossAxisAlignment: CrossAxisAlignment.start,
////            children: <Widget>[
////              Text(
////                message.time,
////                style: TextStyle(
////                  color: Colors.blueGrey,
////                  fontWeight: FontWeight.w600,
////                  fontSize: 16.0,
////                ),
////              ),
////              SizedBox(height: 5.0),
////              Text(
////                message.text,
////                style: TextStyle(
////                  color: Colors.blueGrey,
////                  fontWeight: FontWeight.w600,
////                  fontSize: 16.0,
////                ),
////              ),
////            ],
////          ),
////        ),
////        !isMe
////            ? IconButton(
////                icon: message.isLiked
////                    ? Icon(Icons.favorite)
////                    : Icon(Icons.favorite_border),
////                iconSize: 30.0,
////                color: message.isLiked
////                    ? Theme.of(context).primaryColor
////                    : Colors.blueGrey,
////                onPressed: () {},
////              )
////            : SizedBox.shrink(),
////      ],
////    );
////  }
//
//  @override
//  void initState() {
//    super.initState();
//    focusNode.addListener(onFocusChange);
//
//    groupChatId = '';
//
//    isLoading = false;
//    isShowSticker = false;
//    imageUrl = '';
//    registerNotification();
//    configLocalNotification();
//
//    readLocal();
//  }
//
//  void registerNotification() {
//    firebaseMessaging.requestNotificationPermissions();
//
//    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
//      print('onMessage: $message');
//      showNotification(message['notification']);
//      return;
//    }, onResume: (Map<String, dynamic> message) {
//      print('onResume: $message');
//      return;
//    }, onLaunch: (Map<String, dynamic> message) {
//      print('onLaunch: $message');
//      return;
//    });
//
//    firebaseMessaging.getToken().then((token) {
//      print('token: $token');
//      //Firestore.instance.collection('users').document(id).updateData({'pushToken': token});
//    }).catchError((err) {
//      Fluttertoast.showToast(msg: err.message.toString());
//    });
//  }
//
//  void configLocalNotification() {
//    var initializationSettingsAndroid = new AndroidInitializationSettings(
//        'app_icon');
//    var initializationSettingsIOS = new IOSInitializationSettings();
//    var initializationSettings = new InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin.initialize(initializationSettings);
//  }
//
//  void showNotification(message) async {
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//      Platform.isAndroid
//          ? 'com.example.flutter_app'
//          : 'com.duytq.flutterchatdemo',
//      'Flutter chat demo',
//      'your channel description',
//      playSound: true,
//      enableVibration: true,
//      importance: Importance.Max,
//      priority: Priority.High,
//    );
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//    var platformChannelSpecifics =
//    new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, message['title'].toString(), message['body'].toString(),
//        platformChannelSpecifics,
//        payload: json.encode(message));
//  }
//
//
//  void onFocusChange() {
//    if (focusNode.hasFocus) {
//      // Hide sticker when keyboard appear
//      setState(() {
//        isShowSticker = false;
//      });
//    }
//  }
//
//  readLocal() async {
//    prefs = await SharedPreferences.getInstance();
//    //id = prefs.getString('id') ?? '';
//    if (id.hashCode <= peerId.hashCode) {
//      groupChatId = '$id-$peerId';
//    } else {
//      groupChatId = '$peerId-$id';
//    }
//// TODO Uncomment it
//    Firestore.instance
//        .collection('users')
//        .document(id)
//        .updateData({'chattingWith': peerId});
//
//    setState(() {});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        backgroundColor: Theme
//            .of(context)
//            .primaryColor,
//        appBar: AppBar(
//          title: Center(
//            child: Text(
//              //            widget.user.name,
//              "hbhbhj",
//              style: TextStyle(
//                fontSize: 28.0,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//          ),
//          elevation: 0.0,
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.more_horiz),
//              iconSize: 30.0,
//              color: Colors.white,
//              onPressed: () {},
//            ),
//          ],
//        ),
//        body: Stack(
//          children: <Widget>[
//            Column(
//              children: <Widget>[
//                Expanded(
//                  child: Container(
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(30.0),
//                            topRight: Radius.circular(30.0),
//                          )),
//                      child: ClipRRect(
//                        //this one activates when you scroll up the text won't go above the border it clips the text to maintain the shaped rounded view
//                          borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(30.0),
//                            topRight: Radius.circular(30.0),
//                          ),
//                          child: buildListMessage())),
//                ),
//                showContact ? _buildFullContract() : Container(),
//                showContact ? Container() : _buildContract(),
//                showContact ? Container() : _buildKeyBoard()
//              ],
//            ),
//            buildLoading()
//          ],
//        ));
//  }
//
//  Widget buildListMessage() {
//    return groupChatId == ''
//        ? Center(
//        child: CircularProgressIndicator(
//            valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
//        : StreamBuilder(
//      stream: Firestore.instance
//          .collection('messages')
//          .document(groupChatId)
//          .collection(groupChatId)
//          .orderBy('timestamp', descending: true)
//          .snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return Center(
//              child: CircularProgressIndicator(
//                  valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
//        } else {
//          listMessage = snapshot.data.documents;
//          return ListView.builder(
//            padding: EdgeInsets.all(10.0),
//            itemBuilder: (context, index) =>
//                x(index, snapshot.data.documents[index]),
//            itemCount: snapshot.data.documents.length,
//            reverse: true,
//            controller: listScrollController,
//          );
//        }
//      },
//    );
//  }
//
//  Widget x(int index, DocumentSnapshot document) {
//    return Row(
//      children: <Widget>[
//        Container(
//          margin: document['idFrom'] == id
//              ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 70.0)
//              : EdgeInsets.only(
//            top: 8.0,
//            bottom: 8.0,
//          ),
//          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
//          width: MediaQuery
//              .of(context)
//              .size
//              .width * 0.75,
//          decoration: BoxDecoration(
//              color: document['idFrom'] == id
//                  ? Theme
//                  .of(context)
//                  .accentColor
//                  : Color(0xFFFFFEFEE),
//              borderRadius: document['idFrom'] == id
//                  ? BorderRadius.only(
//                topLeft: Radius.circular(15.0),
//                bottomLeft: Radius.circular(15.0),
//              )
//                  : BorderRadius.only(
//                topRight: Radius.circular(15.0),
//                bottomRight: Radius.circular(15.0),
//              )),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                DateFormat('dd MMM kk:mm').format(
//                    DateTime.fromMillisecondsSinceEpoch(
//                        int.parse(document['timestamp']))),
//                style: TextStyle(
//                  color: Colors.blueGrey,
//                  fontWeight: FontWeight.w600,
//                  fontSize: 10.0,
//                ),
//              ),
//              SizedBox(height: 5.0),
//              document['type'] == 0
//                  ? Text(
//                document['content'],
//                style: TextStyle(
//                  color: Colors.blueGrey,
//                  fontWeight: FontWeight.w600,
//                  fontSize: 16.0,
//                ),
//              )
//                  : Container(
//                child: Row(
//                  children: <Widget>[
//                    document['content'] == ''
//                        ? Container(
//                      height: 20,
//                      width: 20,
//                      child: Center(
//                        child: CircularProgressIndicator(
//                            valueColor:
//                            AlwaysStoppedAnimation<Color>(
//                                themeColor)),
//                      ),
//                    )
//                        : document[tempDTD] == null
//                        ? InkWell(
//                      onTap: () {
//                        tempDTD = DateTime
//                            .now()
//                            .millisecondsSinceEpoch
//                            .toString();
//
//                        downloadFile(document['content'],
//                            document['fileName'], document);
//                      },
//                      child: Icon(Icons.file_download),
//                    )
//                        : document[tempDTD] == false
//                        ? InkWell(
//                      onTap: () {
//                        tempDTD = DateTime
//                            .now()
//                            .millisecondsSinceEpoch
//                            .toString();
//
//                        downloadFile(document['content'],
//                            document['fileName'], document);
//                      },
//                      child: Icon(Icons.file_download),
//                    )
//                        : Container(
//                      height: 20,
//                      width: 20,
//                      child: Center(
//                        child: CircularProgressIndicator(
//                            valueColor:
//                            AlwaysStoppedAnimation<
//                                Color>(themeColor)),
//                      ),
//                    ),
//                    document['content'] == ''
//                        ? Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Text('File Uploading'),
//                    )
//                        : (document[tempDTD] == null
//                        ? Text('PDF File')
//                        : (document[tempDTD] == false)
//                        ? Text('PDF File')
//                        : Text('File Downloading')),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget buildLoading() {
//    return Positioned(
//      child: isLoading
//          ? Container(
//        child: Center(
//          child: CircularProgressIndicator(
//              valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
//        ),
//        color: Colors.white.withOpacity(0.8),
//      )
//          : Container(),
//    );
//  }
//
//  _buildKeyBoard() {
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 8.0),
//      color: Colors.white,
//      height: 60.0,
//      child: Row(
//        children: <Widget>[
//          IconButton(
//            icon: Icon(Icons.photo_library),
//            color: Theme
//                .of(context)
//                .primaryColor,
//            onPressed: () {
//              // TODO Pick File
//              showDialog(
//                  context: context,
//                  builder: (_) {
//                    return AlertDialog(
//                      content: Column(
//                        mainAxisSize: MainAxisSize.min,
//                        children: <Widget>[
//                          InkWell(
//                              onTap: () {
//                                pickFileFromPhone();
//                                Navigator.pop(context);
//                              },
//                              child: Text('Pick File From Phone')),
//                          InkWell(
//                              onTap: () {},
//                              child: Text('Pick File From Template')),
//                        ],
//                      ),
//                    );
//                  });
//            },
//          ),
//          Expanded(
//            child: TextField(
//              style: TextStyle(color: primaryColor, fontSize: 15.0),
//              controller: textEditingController,
//              decoration: InputDecoration.collapsed(
//                hintText: 'Type your message...',
//                hintStyle: TextStyle(color: greyColor),
//              ),
//              focusNode: focusNode,
//            ),
//          ),
//          Material(
//            child: new Container(
//              margin: new EdgeInsets.symmetric(horizontal: 8.0),
//              child: new IconButton(
//                icon: new Icon(Icons.send),
//                onPressed: () => onSendMessage(textEditingController.text, 0),
//                color: Theme
//                    .of(context)
//                    .primaryColor,
//              ),
//            ),
//            color: Colors.white,
//          ),
//        ],
//      ),
//    );
//  }
//
//  bool isLastMessageLeft(int index) {
//    if ((index > 0 &&
//        listMessage != null &&
//        listMessage[index - 1]['idFrom'] == id) ||
//        index == 0) {
//      return true;
//    } else {
//      return false;
//    }
//  }
//
//  bool isLastMessageRight(int index) {
//    if ((index > 0 &&
//        listMessage != null &&
//        listMessage[index - 1]['idFrom'] != id) ||
//        index == 0) {
//      return true;
//    } else {
//      return false;
//    }
//  }
//
//  void onSendMessage(String content, int type) {
//    // type: 0 = text, 1 = file
//    if (content.trim() != '') {
//      textEditingController.clear();
//      var documentReference = Firestore.instance
//          .collection('messages')
//          .document(groupChatId)
//          .collection(groupChatId)
//          .document(DateTime
//          .now()
//          .millisecondsSinceEpoch
//          .toString());
//
//      Firestore.instance.runTransaction((transaction) async {
//        await transaction.set(
//          documentReference,
//          {
//            'idFrom': id,
//            'idTo': peerId,
//            'timestamp': DateTime
//                .now()
//                .millisecondsSinceEpoch
//                .toString(),
//            'content': content,
//            'type': type
//          },
//        );
//      });
//      listScrollController.animateTo(0.0,
//          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//    } else {
//      Fluttertoast.showToast(msg: 'Nothing to send');
//    }
//  }
//
//  Future<void> pickFileFromPhone() async {
//    imageFile =
//    await FilePicker.getFile(fileExtension: 'pdf', type: FileType.CUSTOM);
//
//    if (imageFile != null) {
//      setState(() {
//        isLoading = true;
//      });
//      tempDT = DateTime
//          .now()
//          .millisecondsSinceEpoch
//          .toString();
//      onSendMessagePDF('', 1, tempDT);
//      setState(() {
//        isLoading = false;
//      });
//      uploadFile();
//    }
//  }
//
//  Future<void> downloadFile(String url, String fileName,
//      DocumentSnapshot document) async {
//    downloadUpdate(document, true);
//
//    String extension = 'pdf';
//    var dio = new Dio();
//    var dir = await getExternalStorageDirectory();
//    var knockDir =
//    await new Directory('${dir.path}/AZAR').create(recursive: true);
//    print("Hello checking the pdf in Externaal Sorage ");
//    io.File('${knockDir.path}/$fileName.$extension').exists().then((a) async {
//      print(a);
//      if (a) {
//        print("Opening file");
//        downloadUpdate(document, false);
//        showDialog(
//            context: context,
//            builder: (_) {
//              return AlertDialog(
//                content: Text('File has already been downloaded'),
//                actions: <Widget>[
//                  RaisedButton(onPressed: () {
//                    // TODO change with your pdf viewer
//                    PdfViewer.loadFile('${knockDir.path}/$fileName.$extension');
//                  },
//                    child: Text('Open File'),
//                  )
//                ],
//              );
//            });
//
//        //PdfViewer.loadFile('${knockDir.path}/${fileName}.${extension}');
//        return;
//      } else {
//        print("Downloading file");
//        await dio.download(url, '${knockDir.path}/$fileName.$extension',
//            onReceiveProgress: (rec, total) {
//              //print("Rec: $rec , Total: $total");
//              if (mounted) {
//                setState(() {
//                  downloading = true;
//                  //progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
//                });
//              }
//            });
//        if (mounted) {
//          setState(() {
//            downloading = false;
//            //progressString = "Completed";
//            print('${knockDir.path}');
//
//            // TODO change with your pdf viewer
//            PdfViewer.loadFile('${knockDir.path}/$fileName.$extension');
//            //_message = "File is downloaded to your SD card 'iLearn' folder!";
//          });
//        }
//        downloadUpdate(document, false);
//        print("Download completed");
//      }
//    });
//    //Navigator.pop(context);
//  }
//
//  Future uploadFile() async {
//    String fileName = DateTime
//        .now()
//        .millisecondsSinceEpoch
//        .toString();
//    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
//    StorageUploadTask uploadTask = reference.putFile(imageFile);
//    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
//      imageUrl = downloadUrl;
//      setState(() {
//        isLoading = false;
//        onSendMessagePDF(imageUrl, 1, tempDT);
//      });
//    }, onError: (err) {
//      setState(() {
//        isLoading = false;
//        imageFile = null;
//      });
//      Fluttertoast.showToast(msg: 'This file is not an pdf');
//    });
//  }
//
//  Future uploadContractFile() async {
//    onSendMessage(
//      'Contract has been sent to you, pleace trace it in contract section', 0,);
//    print(imageFile);
//    String fileName = DateTime
//        .now()
//        .millisecondsSinceEpoch
//        .toString();
//    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
//    StorageUploadTask uploadTask = reference.putFile(imageFile);
//    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
//      imageUrl = downloadUrl;
//      setState(() {
//        isLoading = false;
//        isContractFileUploading = false;
//        imageFile = null;
//      });
//    }, onError: (err) {
//      print(err);
//      setState(() {
//        isLoading = false;
//      });
//      Fluttertoast.showToast(msg: 'This file is not an pdf');
//    });
//  }
//
//  void onSendMessagePDF(String content, int type, String time) {
//    var documentReference = Firestore.instance
//        .collection('messages')
//        .document(groupChatId)
//        .collection(groupChatId)
//        .document(tempDT);
//
//    Firestore.instance.runTransaction((transaction) async {
//      await transaction.set(
//        documentReference,
//        {
//          'idFrom': id,
//          'idTo': peerId,
//          'timestamp': DateTime
//              .now()
//              .millisecondsSinceEpoch
//              .toString(),
//          'content': content,
//          'type': type,
//          'fileName': tempDT
//        },
//      );
//    });
//    listScrollController.animateTo(0.0,
//        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//  }
//
//  downloadUpdate(DocumentSnapshot document, bool isDownloading) {
//    var documentReference = Firestore.instance
//        .collection('messages')
//        .document(groupChatId)
//        .collection(groupChatId)
//        .document(document.documentID);
//
//    Firestore.instance.runTransaction((transaction) async {
//      await transaction.update(
//        documentReference,
//        {tempDTD: isDownloading},
//      );
//    });
//  }
//
//  Widget _buildContract() {
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 8.0),
//      color: Colors.greenAccent,
//      height: 60.0,
//      child: InkWell(
//        onTap: () {
//          setState(() {
//            showContact = true;
//          });
//        },
//        child: Row(
//          children: <Widget>[
//            Icon(Icons.add),
//            Text('Make Contract'),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _buildFullContract() {
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 8.0),
//      color: Colors.grey,
//      height: 120.0,
//      child: Column(
//        children: <Widget>[
//          Text('Make Contract'),
//          Row(
//            children: <Widget>[
//              IconButton(
//                icon: Icon(Icons.attach_file),
//                color: Theme
//                    .of(context)
//                    .primaryColor,
//                onPressed: () async {
//                  imageFile = null;
//                  imageFile =
//                  await FilePicker.getFile(
//                      fileExtension: 'pdf', type: FileType.CUSTOM);
//                },
//              ),
//              Text('Pick PDF File'),
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Checkbox(value: checkBoxValue, onChanged: checkBoxFunction),
//              RaisedButton(onPressed: () {
//                if (imageFile != null) {
//                  if (checkBoxValue != true) {
//                    showDialog(context: context, builder: (_) {
//                      return AlertDialog(
//                        content: Text(
//                            'Please agree on contract terms and conditioons'),
//                        actions: <Widget>[
//                          RaisedButton(onPressed: () {
//                            Navigator.pop(context);
//                          },
//                            child: Text('OK'),
//                          )
//                        ],
//                      );
//                    });
//                  }
//                  else {
//                    uploadContractFile().then((k){
//
//                    });
//                    String temp = DateTime.now().millisecondsSinceEpoch.toString();
//
//                    // Writing to own documents
//                    Firestore.instance.collection('users')
//                        .document(id)
//                        .collection(id).document("$groupChatId-$temp").setData({
//                      'contractByID': id,
//                      'contractByName': senderIDName,
//                      'contractByAgree': checkBoxValue,
//                      'contractToID': peerId,
//                      'contractToName': receiverIDName,
//                      'contractToAgree': 'Waiting',
//                      'pdfUrl': imageUrl,
//                      'time': temp
//                    });
//                    // Writing to other documents
//                    Firestore.instance.collection('users')
//                        .document(peerId)
//                        .collection(peerId).document("$groupChatId-$temp").setData({
//                      'contractByID': id,
//                      'contractByName': senderIDName,
//                      'contractByAgree': checkBoxValue,
//                      'contractToID': peerId,
//                      'contractToName': receiverIDName,
//                      'contractToAgree': 'Waiting',
//                      'pdfUrl': imageUrl,
//                      'time': temp
//                    });
//
//                    setState(() {
//                      showDialog(context: context, builder: (_) {
//                        return AlertDialog(
//                          content: Text(
//                              'Contract Send, You  can track the details in contract section'),
//                          actions: <Widget>[
//                            RaisedButton(onPressed: () {
//                              Navigator.pop(context);
//                            },
//                              child: Text('OK'),
//                            )
//                          ],
//                        );
//                      });
//                      showContact = false;
//                    });
//                  }
//                }
//                else {
//                  showDialog(context: context, builder: (_) {
//                    return AlertDialog(
//                      content: Text('Please attach pdf file'),
//                      actions: <Widget>[
//                        RaisedButton(onPressed: () {
//                          Navigator.pop(context);
//                        },
//                          child: Text('OK'),
//                        )
//                      ],
//                    );
//                  });
//                }
//              },
//                child: Text('Make Contrct'),
//              ),
//            ],
//          )
//        ],
//      ),
//    );
//  }
//
//  bool checkBoxValue = false;
//  bool showContact = false;
//
//  void checkBoxFunction(bool value) {
//    setState(() {
//      checkBoxValue = value;
//    });
//  }
//}
//
//class MakeContract extends StatefulWidget {
//  @override
//  _MakeContractState createState() => _MakeContractState();
//}
//
//class _MakeContractState extends State<MakeContract> {
//  bool checkBoxValue = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Column(
//        children: <Widget>[
//          Text('Please attach PDF file for contract '),
//          RaisedButton(onPressed: () {
//
//          },
//            child: Text('Attach File'),
//          ),
//          Checkbox(value: checkBoxValue, onChanged: checkBoxFunction),
//          RaisedButton(onPressed: () {
//
//          },
//            child: Text('Make Contrct'),
//          ),
//
//
//        ],
//      ),
//
//    );
//  }
//
//  void checkBoxFunction(bool value) {
//    setState(() {
//      checkBoxValue = value;
//    });
//  }
//}
//
