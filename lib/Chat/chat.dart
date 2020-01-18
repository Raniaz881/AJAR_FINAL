//import 'dart:async';
//import 'dart:io';
//
//import 'package:flutter/material.dart';
//
//import 'package:flutter/services.dart';
//import 'package:file_picker/file_picker.dart';
//
////import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:intl/intl.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//
//import 'dart:ui';
//
//final themeColor = Color(0xfff5a623);
//final primaryColor = Color(0xff203152);
//final greyColor = Color(0xffaeaeae);
//final greyColor2 = Color(0xffE8E8E8);
//
//class Chat extends StatelessWidget {
//  final String peerId;
//  final String peerAvatar;
//
//  Chat({Key key, @required this.peerId, @required this.peerAvatar}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(
//          'CHAT',
//          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
//        ),
//        centerTitle: true,
//      ),
//      body: new ChatScreen(
//        peerId: peerId,
//        peerAvatar: peerAvatar,
//      ),
//    );
//  }
//}
//
//class ChatScreen extends StatefulWidget {
//  final String peerId;
//  final String peerAvatar;
//
//  ChatScreen({Key key, @required this.peerId, @required this.peerAvatar}) : super(key: key);
//
//  @override
//  State createState() => new ChatScreenState(peerId: peerId, peerAvatar: peerAvatar);
//}
//
//class ChatScreenState extends State<ChatScreen> {
//  ChatScreenState({Key key, @required this.peerId, @required this.peerAvatar});
//  String peerId;
//  String peerAvatar;
//  String id;
//
//  var listMessage;
//  String groupChatId;
//  SharedPreferences prefs;
//
//  File imageFile;
//  bool isLoading;
//  bool isShowSticker;
//  String imageUrl;
//
//  final TextEditingController textEditingController = new TextEditingController();
//  final ScrollController listScrollController = new ScrollController();
//  final FocusNode focusNode = new FocusNode();
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
//
//    readLocal();
//  }
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
//    id = prefs.getString('id') ?? '';
//    if (id.hashCode <= peerId.hashCode) {
//      groupChatId = '$id-$peerId';
//    } else {
//      groupChatId = '$peerId-$id';
//    }
//
//    Firestore.instance.collection('users').document(id).updateData({'chattingWith': peerId});
//
//    setState(() {});
//  }
//
//  Future getImage() async {
//    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//    if (imageFile != null) {
//      setState(() {
//        isLoading = true;
//      });
//      uploadFile();
//    }
//  }
//
//  void getSticker() {
//    // Hide keyboard when sticker appear
//    focusNode.unfocus();
//    setState(() {
//      isShowSticker = !isShowSticker;
//    });
//  }
//
//  Future uploadFile() async {
//    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
//    StorageUploadTask uploadTask = reference.putFile(imageFile);
//    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
//      imageUrl = downloadUrl;
//      setState(() {
//        isLoading = false;
//        onSendMessage(imageUrl, 1);
//      });
//    }, onError: (err) {
//      setState(() {
//        isLoading = false;
//      });
//      Fluttertoast.showToast(msg: 'This file is not an image');
//    });
//  }
//
//  void onSendMessage(String content, int type) {
//    // type: 0 = text, 1 = image, 2 = sticker
//    if (content.trim() != '') {
//      textEditingController.clear();
//
//      var documentReference = Firestore.instance
//          .collection('messages')
//          .document(groupChatId)
//          .collection(groupChatId)
//          .document(DateTime.now().millisecondsSinceEpoch.toString());
//
//      Firestore.instance.runTransaction((transaction) async {
//        await transaction.set(
//          documentReference,
//          {
//            'idFrom': id,
//            'idTo': peerId,
//            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
//            'content': content,
//            'type': type
//          },
//        );
//      });
//      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//    } else {
//      Fluttertoast.showToast(msg: 'Nothing to send');
//    }
//  }
//
//  Widget buildItem(int index, DocumentSnapshot document) {
//    if (document['idFrom'] == id) {
//      // Right (my message)
//      return Row(
//        children: <Widget>[
//          document['type'] == 0
//          // Text
//              ? Container(
//            child: Text(
//              document['content'],
//              style: TextStyle(color: primaryColor),
//            ),
//            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//            width: 200.0,
//            decoration: BoxDecoration(color: greyColor2, borderRadius: BorderRadius.circular(8.0)),
//            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
//          )
//              :
//          // PDF Container
//              Container(
//                width: 100.0,
//                height: 100.0,
//                color: Colors.red,
//            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
//          ),
//        ],
//        mainAxisAlignment: MainAxisAlignment.end,
//      );
//    } else {
//      // Left (peer message)
//      return Container(
//        child: Column(
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                isLastMessageLeft(index)
//                    ? Material(
//                  child: CircleAvatar(),
//                  borderRadius: BorderRadius.all(
//                    Radius.circular(18.0),
//                  ),
//                  clipBehavior: Clip.hardEdge,
//                )
//                    : Container(width: 35.0),
//                document['type'] == 0
//                    ? Container(
//                  child: Text(
//                    document['content'],
//                    style: TextStyle(color: Colors.white),
//                  ),
//                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                  width: 200.0,
//                  decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(8.0)),
//                  margin: EdgeInsets.only(left: 10.0),
//                )
//
//
//                    : Container(
//                  width: 100.0,
//                  height: 100.0,
//                  color: Colors.pink,
//                  margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
//                ),
//              ],
//            ),
//
//            // Time
//            isLastMessageLeft(index)
//                ? Container(
//              child: Text(
//                DateFormat('dd MMM kk:mm')
//                    .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document['timestamp']))),
//                style: TextStyle(color: greyColor, fontSize: 12.0, fontStyle: FontStyle.italic),
//              ),
//              margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
//            )
//                : Container()
//          ],
//          crossAxisAlignment: CrossAxisAlignment.start,
//        ),
//        margin: EdgeInsets.only(bottom: 10.0),
//      );
//    }
//  }
//
//  bool isLastMessageLeft(int index) {
//    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] == id) || index == 0) {
//      return true;
//    } else {
//      return false;
//    }
//  }
//
//  bool isLastMessageRight(int index) {
//    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] != id) || index == 0) {
//      return true;
//    } else {
//      return false;
//    }
//  }
//
//  Future<bool> onBackPress() {
//    if (isShowSticker) {
//      setState(() {
//        isShowSticker = false;
//      });
//    } else {
//      Firestore.instance.collection('users').document(id).updateData({'chattingWith': null});
//      Navigator.pop(context);
//    }
//
//    return Future.value(false);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      child: Stack(
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              // List of messages
//              buildListMessage(),
//
//              // Sticker
//
//
//              // Input content
//              buildInput(),
//            ],
//          ),
//
//          // Loading
//          buildLoading()
//        ],
//      ),
//      onWillPop: onBackPress,
//    );
//  }
//
//  Widget buildSticker() {
//    return Container(
//      child: Column(
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              FlatButton(
//                onPressed: () => onSendMessage('mimi1', 2),
//                child: new Image.asset(
//                  'images/mimi1.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              ),
//              FlatButton(
//                onPressed: () => onSendMessage('mimi2', 2),
//                child: new Image.asset(
//                  'images/mimi2.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              ),
//              FlatButton(
//                onPressed: () => onSendMessage('mimi3', 2),
//                child: new Image.asset(
//                  'images/mimi3.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              )
//            ],
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          ),
//          Row(
//            children: <Widget>[
//              FlatButton(
//                onPressed: () => onSendMessage('mimi4', 2),
//                child: new Image.asset(
//                  'images/mimi4.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              ),
//              FlatButton(
//                onPressed: () => onSendMessage('mimi5', 2),
//                child: new Image.asset(
//                  'images/mimi5.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              ),
//              FlatButton(
//                onPressed: () => onSendMessage('mimi6', 2),
//                child: new Image.asset(
//                  'images/mimi6.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              )
//            ],
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          ),
//          Row(
//            children: <Widget>[
//              FlatButton(
//                onPressed: () => onSendMessage('mimi7', 2),
//                child: new Image.asset(
//                  'images/mimi7.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              ),
//              FlatButton(
//                onPressed: () => onSendMessage('mimi8', 2),
//                child: new Image.asset(
//                  'images/mimi8.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              ),
//              FlatButton(
//                onPressed: () => onSendMessage('mimi9', 2),
//                child: new Image.asset(
//                  'images/mimi9.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              )
//            ],
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          )
//        ],
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      ),
//      decoration: new BoxDecoration(
//          border: new Border(top: new BorderSide(color: greyColor2, width: 0.5)), color: Colors.white),
//      padding: EdgeInsets.all(5.0),
//      height: 180.0,
//    );
//  }
//
//  Widget buildLoading() {
//    return Positioned(
//      child: isLoading
//          ? Container(
//        child: Center(
//          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
//        ),
//        color: Colors.white.withOpacity(0.8),
//      )
//          : Container(),
//    );
//  }
//
//  Widget buildInput() {
//    return Container(
//      child: Row(
//        children: <Widget>[
//          // Button send image
//          Material(
//            child: new Container(
//              margin: new EdgeInsets.symmetric(horizontal: 1.0),
//              child: new IconButton(
//                icon: new Icon(Icons.image),
//                onPressed: getImage,
//                color: primaryColor,
//              ),
//            ),
//            color: Colors.white,
//          ),
//          Material(
//            child: new Container(
//              margin: new EdgeInsets.symmetric(horizontal: 1.0),
//              child: new IconButton(
//                icon: new Icon(Icons.face),
//                onPressed: getSticker,
//                color: primaryColor,
//              ),
//            ),
//            color: Colors.white,
//          ),
//
//          // Edit text
//          Flexible(
//            child: Container(
//              child: TextField(
//                style: TextStyle(color: primaryColor, fontSize: 15.0),
//                controller: textEditingController,
//                decoration: InputDecoration.collapsed(
//                  hintText: 'Type your message...',
//                  hintStyle: TextStyle(color: greyColor),
//                ),
//                focusNode: focusNode,
//              ),
//            ),
//          ),
//
//          // Button send message
//          Material(
//            child: new Container(
//              margin: new EdgeInsets.symmetric(horizontal: 8.0),
//              child: new IconButton(
//                icon: new Icon(Icons.send),
//                onPressed: () => onSendMessage(textEditingController.text, 0),
//                color: primaryColor,
//              ),
//            ),
//            color: Colors.white,
//          ),
//        ],
//      ),
//      width: double.infinity,
//      height: 50.0,
//      decoration: new BoxDecoration(
//          border: new Border(top: new BorderSide(color: greyColor2, width: 0.5)), color: Colors.white),
//    );
//  }
//
//  Widget buildListMessage() {
//    return Flexible(
//      child: groupChatId == ''
//          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
//          : StreamBuilder(
//        stream: Firestore.instance
//            .collection('messages')
//            .document(groupChatId)
//            .collection(groupChatId)
//            .orderBy('timestamp', descending: true)
//            .limit(20)
//            .snapshots(),
//        builder: (context, snapshot) {
//          if (!snapshot.hasData) {
//            return Center(
//                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
//          } else {
//            listMessage = snapshot.data.documents;
//            return ListView.builder(
//              padding: EdgeInsets.all(10.0),
//              itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index]),
//              itemCount: snapshot.data.documents.length,
//              reverse: true,
//              controller: listScrollController,
//            );
//          }
//        },
//      ),
//    );
//  }
//}
//
//
//
//
//
//
//
//
//class FilePickerDemo extends StatefulWidget {
//  @override
//  _FilePickerDemoState createState() => new _FilePickerDemoState();
//}
//
//class _FilePickerDemoState extends State<FilePickerDemo> {
//  String _fileName;
//  String _path;
//  Map<String, String> _paths;
//  String _extension;
//  bool _loadingPath = false;
//  bool _multiPick = false;
//  bool _hasValidMime = false;
//  FileType _pickingType;
//  TextEditingController _controller = new TextEditingController();
//
//  @override
//  void initState() {
//    super.initState();
//    _controller.addListener(() => _extension = _controller.text);
//  }
//
//  void _openFileExplorer() async {
//    if (_pickingType != FileType.CUSTOM || _hasValidMime) {
//      print(_pickingType);
//      print(_hasValidMime);
//      setState(() => _loadingPath = true);
//      try {
//        if (_multiPick) {
//          _path = null;
//          _paths = await FilePicker.getMultiFilePath(
//              type: _pickingType, fileExtension: _extension);
//        } else {
//          _paths = null;
//          //await FilePicker.getFile(fileExtension: ,type: )
//          _path = await FilePicker.getFilePath(
//              type: _pickingType, fileExtension: _extension);
//        }
//      } on PlatformException catch (e) {
//        print("Unsupported operation" + e.toString());
//      }
//      if (!mounted) return;
//      setState(() {
//        _loadingPath = false;
//        _fileName = _path != null
//            ? _path.split('/').last
//            : _paths != null ? _paths.keys.toString() : '...';
//      });
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: const Text('File Picker example app'),
//        ),
//        body: new Center(
//            child: new Padding(
//              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//              child: new SingleChildScrollView(
//                child: new Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    new Padding(
//                      padding: const EdgeInsets.only(top: 20.0),
//                      child: new DropdownButton(
//                          hint: new Text('LOAD PATH FROM'),
//                          value: _pickingType,
//                          items: <DropdownMenuItem>[
//                            new DropdownMenuItem(
//                              child: new Text('FROM AUDIO'),
//                              value: FileType.AUDIO,
//                            ),
//                            new DropdownMenuItem(
//                              child: new Text('FROM IMAGE'),
//                              value: FileType.IMAGE,
//                            ),
//                            new DropdownMenuItem(
//                              child: new Text('FROM VIDEO'),
//                              value: FileType.VIDEO,
//                            ),
//                            new DropdownMenuItem(
//                              child: new Text('FROM ANY'),
//                              value: FileType.ANY,
//                            ),
//                            new DropdownMenuItem(
//                              child: new Text('CUSTOM FORMAT'),
//                              value: FileType.CUSTOM,
//                            ),
//                          ],
//                          onChanged: (value) => setState(() {
//                            _pickingType = value;
//                            if (_pickingType != FileType.CUSTOM) {
//                              _controller.text = _extension = '';
//                            }
//                          })),
//                    ),
//                    new ConstrainedBox(
//                      constraints: BoxConstraints.tightFor(width: 100.0),
//                      child: _pickingType == FileType.CUSTOM
//                          ? new TextFormField(
//                        maxLength: 15,
//                        autovalidate: true,
//                        controller: _controller,
//                        decoration:
//                        InputDecoration(labelText: 'File extension'),
//                        keyboardType: TextInputType.text,
//                        textCapitalization: TextCapitalization.none,
//                        validator: (value) {
//                          RegExp reg = new RegExp(r'[^a-zA-Z0-9]');
//                          if (reg.hasMatch(value)) {
//                            _hasValidMime = false;
//                            return 'Invalid format';
//                          }
//                          _hasValidMime = true;
//                          return null;
//                        },
//                      )
//                          : new Container(),
//                    ),
//                    new ConstrainedBox(
//                      constraints: BoxConstraints.tightFor(width: 200.0),
//                      child: new SwitchListTile.adaptive(
//                        title: new Text('Pick multiple files',
//                            textAlign: TextAlign.right),
//                        onChanged: (bool value) =>
//                            setState(() => _multiPick = value),
//                        value: _multiPick,
//                      ),
//                    ),
//                    new Padding(
//                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
//                      child: new RaisedButton(
//                        onPressed: () => _openFileExplorer(),
//                        child: new Text("Open file picker"),
//                      ),
//                    ),
//                    new Builder(
//                      builder: (BuildContext context) => _loadingPath
//                          ? Padding(
//                          padding: const EdgeInsets.only(bottom: 10.0),
//                          child: const CircularProgressIndicator())
//                          : _path != null || _paths != null
//                          ? new Container(
//                        padding: const EdgeInsets.only(bottom: 30.0),
//                        height: MediaQuery.of(context).size.height * 0.50,
//                        child: new Scrollbar(
//                            child: new ListView.separated(
//                              itemCount: _paths != null && _paths.isNotEmpty
//                                  ? _paths.length
//                                  : 1,
//                              itemBuilder: (BuildContext context, int index) {
//                                final bool isMultiPath =
//                                    _paths != null && _paths.isNotEmpty;
//                                final String name = 'File $index: ' +
//                                    (isMultiPath
//                                        ? _paths.keys.toList()[index]
//                                        : _fileName ?? '...');
//                                final path = isMultiPath
//                                    ? _paths.values.toList()[index].toString()
//                                    : _path;
//
//                                return new ListTile(
//                                  title: new Text(
//                                    name,
//                                  ),
//                                  subtitle: new Text(path),
//                                );
//                              },
//                              separatorBuilder:
//                                  (BuildContext context, int index) =>
//                              new Divider(),
//                            )),
//                      )
//                          : new Container(),
//                    ),
//                  ],
//                ),
//              ),
//            )),
//      ),
//    );
//  }
//}
//
//void main() => runApp(MyApp());
//
//class MainScreen extends StatefulWidget {
//  final String currentUserId;
//
//  MainScreen({Key key, @required this.currentUserId}) : super(key: key);
//
//  @override
//  State createState() => MainScreenState(currentUserId: currentUserId);
//}
//
//class MainScreenState extends State<MainScreen> {
//  MainScreenState({Key key, @required this.currentUserId});
//
//  final String currentUserId;
//  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
//  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//  final GoogleSignIn googleSignIn = GoogleSignIn();
//
//  bool isLoading = false;
//  List<Choice> choices = const <Choice>[
//    const Choice(title: 'Settings', icon: Icons.settings),
//    const Choice(title: 'Log out', icon: Icons.exit_to_app),
//  ];
//
//  @override
//  void initState() {
//    super.initState();
//    registerNotification();
//    configLocalNotification();
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
//      Firestore.instance.collection('users').document(currentUserId).updateData({'pushToken': token});
//    }).catchError((err) {
//      Fluttertoast.showToast(msg: err.message.toString());
//    });
//  }
//
//  void configLocalNotification() {
//    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
//    var initializationSettingsIOS = new IOSInitializationSettings();
//    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin.initialize(initializationSettings);
//  }
//
//  void onItemMenuPress(Choice choice) {
//    if (choice.title == 'Log out') {
//      handleSignOut();
//    } else {
//      Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
//    }
//  }
//
//  void showNotification(message) async {
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//      Platform.isAndroid ? 'com.dfa.flutterchatdemo': 'com.duytq.flutterchatdemo',
//      'Flutter chat demo',
//      'your channel description',
//      playSound: true,
//      enableVibration: true,
//      importance: Importance.Max,
//      priority: Priority.High,
//    );
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//    var platformChannelSpecifics =
//    new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics,
//        payload: json.encode(message));
//  }
//
//  Future<bool> onBackPress() {
//    openDialog();
//    return Future.value(false);
//  }
//
//  Future<Null> openDialog() async {
//    switch (await showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return SimpleDialog(
//            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
//            children: <Widget>[
//              Container(
//                color: themeColor,
//                margin: EdgeInsets.all(0.0),
//                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
//                height: 100.0,
//                child: Column(
//                  children: <Widget>[
//                    Container(
//                      child: Icon(
//                        Icons.exit_to_app,
//                        size: 30.0,
//                        color: Colors.white,
//                      ),
//                      margin: EdgeInsets.only(bottom: 10.0),
//                    ),
//                    Text(
//                      'Exit app',
//                      style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
//                    ),
//                    Text(
//                      'Are you sure to exit app?',
//                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
//                    ),
//                  ],
//                ),
//              ),
//              SimpleDialogOption(
//                onPressed: () {
//                  Navigator.pop(context, 0);
//                },
//                child: Row(
//                  children: <Widget>[
//                    Container(
//                      child: Icon(
//                        Icons.cancel,
//                        color: primaryColor,
//                      ),
//                      margin: EdgeInsets.only(right: 10.0),
//                    ),
//                    Text(
//                      'CANCEL',
//                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
//                    )
//                  ],
//                ),
//              ),
//              SimpleDialogOption(
//                onPressed: () {
//                  Navigator.pop(context, 1);
//                },
//                child: Row(
//                  children: <Widget>[
//                    Container(
//                      child: Icon(
//                        Icons.check_circle,
//                        color: primaryColor,
//                      ),
//                      margin: EdgeInsets.only(right: 10.0),
//                    ),
//                    Text(
//                      'YES',
//                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
//                    )
//                  ],
//                ),
//              ),
//            ],
//          );
//        })) {
//      case 0:
//        break;
//      case 1:
//        exit(0);
//        break;
//    }
//  }
//
//  Future<Null> handleSignOut() async {
//    this.setState(() {
//      isLoading = true;
//    });
//
//    await FirebaseAuth.instance.signOut();
//    await googleSignIn.disconnect();
//    await googleSignIn.signOut();
//
//    this.setState(() {
//      isLoading = false;
//    });
//
//    Navigator.of(context)
//        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (Route<dynamic> route) => false);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          'MAIN',
//          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
//        ),
//        centerTitle: true,
//        actions: <Widget>[
//          PopupMenuButton<Choice>(
//            onSelected: onItemMenuPress,
//            itemBuilder: (BuildContext context) {
//              return choices.map((Choice choice) {
//                return PopupMenuItem<Choice>(
//                    value: choice,
//                    child: Row(
//                      children: <Widget>[
//                        Icon(
//                          choice.icon,
//                          color: primaryColor,
//                        ),
//                        Container(
//                          width: 10.0,
//                        ),
//                        Text(
//                          choice.title,
//                          style: TextStyle(color: primaryColor),
//                        ),
//                      ],
//                    ));
//              }).toList();
//            },
//          ),
//        ],
//      ),
//      body: WillPopScope(
//        child: Stack(
//          children: <Widget>[
//            // List
//            Container(
//              child: StreamBuilder(
//                stream: Firestore.instance.collection('users').snapshots(),
//                builder: (context, snapshot) {
//                  if (!snapshot.hasData) {
//                    return Center(
//                      child: CircularProgressIndicator(
//                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                      ),
//                    );
//                  } else {
//                    return ListView.builder(
//                      padding: EdgeInsets.all(10.0),
//                      itemBuilder: (context, index) => buildItem(context, snapshot.data.documents[index]),
//                      itemCount: snapshot.data.documents.length,
//                    );
//                  }
//                },
//              ),
//            ),
//
//            // Loading
//            Positioned(
//              child: isLoading
//                  ? Container(
//                child: Center(
//                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
//                ),
//                color: Colors.white.withOpacity(0.8),
//              )
//                  : Container(),
//            )
//          ],
//        ),
//        onWillPop: onBackPress,
//      ),
//    );
//  }
//
//  Widget buildItem(BuildContext context, DocumentSnapshot document) {
//    if (document['id'] == currentUserId) {
//      return Container();
//    } else {
//      return Container(
//        child: FlatButton(
//          child: Row(
//            children: <Widget>[
//              Material(
//                child: document['photoUrl'] != null
//                    ? CachedNetworkImage(
//                  placeholder: (context, url) => Container(
//                    child: CircularProgressIndicator(
//                      strokeWidth: 1.0,
//                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                    ),
//                    width: 50.0,
//                    height: 50.0,
//                    padding: EdgeInsets.all(15.0),
//                  ),
//                  imageUrl: document['photoUrl'],
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                )
//                    : Icon(
//                  Icons.account_circle,
//                  size: 50.0,
//                  color: greyColor,
//                ),
//                borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                clipBehavior: Clip.hardEdge,
//              ),
//              Flexible(
//                child: Container(
//                  child: Column(
//                    children: <Widget>[
//                      Container(
//                        child: Text(
//                          'Nickname: ${document['nickname']}',
//                          style: TextStyle(color: primaryColor),
//                        ),
//                        alignment: Alignment.centerLeft,
//                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
//                      ),
//                      Container(
//                        child: Text(
//                          'About me: ${document['aboutMe'] ?? 'Not available'}',
//                          style: TextStyle(color: primaryColor),
//                        ),
//                        alignment: Alignment.centerLeft,
//                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
//                      )
//                    ],
//                  ),
//                  margin: EdgeInsets.only(left: 20.0),
//                ),
//              ),
//            ],
//          ),
//          onPressed: () {
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => Chat(
//                      peerId: document.documentID,
//                      peerAvatar: document['photoUrl'],
//                    )));
//          },
//          color: greyColor2,
//          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
//          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//        ),
//        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
//      );
//    }
//  }
//}
//
//class Choice {
//  const Choice({this.title, this.icon});
//
//  final String title;
//  final IconData icon;
//}