

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AddProperty/addProperty.dart';
import 'package:flutter_app/Chat/ChatPage.dart';
import 'package:flutter_app/Contract/contract_template_screen.dart';
import 'package:flutter_app/Friend_function/combined.dart';
import 'package:flutter_app/HomePage/apartment_carousel.dart';
import 'package:flutter_app/HomePage/office_carousel.dart';
import 'package:flutter_app/Payment/passcode_screen.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/profile.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Payment/MyCardPage.dart';
import 'package:flutter_app/ListOfrequests.dart';

 AuthService _auth = new AuthService();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    registerNotification();
    configLocalNotification();
  }

  void registerNotification() {
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      showNotification(message['notification']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      Firestore.instance.collection('users').document(ajarPreferences.getString('myUID')).updateData({'pushToken': token});
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  void configLocalNotification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings(
        'app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.example.flutter_app'
          : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
    new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, message['title'].toString(), message['body'].toString(),
        platformChannelSpecifics,
        payload: json.encode(message));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFBF4),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              iconSize: 26,
              color: Color(0xFF354241),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: Drawer(

        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(colors: <Color>[
                  Colors.teal,
                  Colors.white,
                ],
                ),
              ),
              child: Container(
                child:Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 25,
                      child: Padding(padding: EdgeInsets.all(8.0),
                      child: Image.asset('images/assets/pp.jpg',width: 80,height:80 ,),
                    ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Rania Jamal',
                        style: TextStyle(
                          color:  Colors.white,
                          fontSize: 20,
                          
                        ),

                      ),
                    ),
                  ],
                  
                ),
              ),
            ),

                      CustomListTile(Icons.person_add,'Requests',()=>{
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SocialScreen()))}),
            CustomListTile(Icons.library_books,'Contracts',()=>{Navigator.push(context, MaterialPageRoute(builder: (context)=> TemplatePage()))}),


            CustomListTile(       Icons.info,
                'About Us',
                    () => {
                  showAboutDialog(
                      context: context,
                      applicationIcon: FlutterLogo(),
                      applicationName: 'AJAR',
                      applicationVersion: '0.1',
                      applicationLegalese:
                      'Deveoloped By AJAR Team Khattab, Rania, Marah and Jordan ',
                      children: <Widget>[
                        Text(
                            "AJAR application is a platforms that offer properties realestate services offcharge to each individual asking for it.  "),
                        Text(
                            "Providing many servies to ensure a complete,safe experiecnce for both Landlords and Tenants  "),
                        Text(
                            "Allowing the landlords to monitor their properties and advertising them to an increasing number of audience "),
                        Text(
                            "Tenants will be able to rent a property, sign it's contract and pay the owner with a safe and legitmate process all through AJAR "),
                      ]),
                }),
            CustomListTile(Icons.lock,'Log Out',()=>{_auth.signOut()}),

          ],

        ),
      ),
      body: SafeArea(

        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 120.0),
              child: RichText(
                text:TextSpan(
                  children: [
                    TextSpan(text: 'Hello, ', style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    )),
                    TextSpan(text: 'What are you looking for?',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF354241),
                      ),)

                  ],
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top:20),
              child: Column(
                children: <Widget>[
                  TextField(

                      decoration: InputDecoration(
                        hintText: ('Search by area...'),

                        prefixIcon:IconButton(

                         icon: Icon(Icons.search),
                       ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                      ),


                  ),
                  ),
                ],

              ),
            ),




            SizedBox(height: 40.0),
            ApartmentsCarousel(),
            SizedBox(height: 20.0),
            OfficeCarousel(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFB2DFDB),
        height: 50,

        items: <Widget>[
          Icon(Icons.home, size: 30, color: Color(0xFF354241),),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, size: 30, color: Color(0xFF354241
            ),
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context) => ChatPage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.add, size: 30, color: Color(0xFF354241
            ),
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context) => PropertyAdv()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.payment,
              size: 30,
              color: Color(0xFF354241),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PassCodeScreen()));
            },
          ),

          Icon(Icons.insert_drive_file, size: 30, color: Color(0xFF354241
          ),),
        ],
        animationDuration: Duration(
            milliseconds: 250
        ),

        onTap: (index) {
          debugPrint("Current Index is $index");
          //Handle button tap
        },
      ),

    );

  }
}

class CustomListTile extends  StatelessWidget{
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black26))
        ),
        child: InkWell(
          splashColor: Color(0xFF354241),
          onTap: onTap,
          child: Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Icon(
                 (icon),
                  color: Color(0xFF354241),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style:TextStyle(
                      fontSize: 16,
                      color:Color(0xFF354241),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}

