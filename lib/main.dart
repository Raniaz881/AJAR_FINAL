import 'package:flutter/material.dart';
import 'package:flutter_app/AddProperty/addProperty.dart';
import 'package:flutter_app/Chat/chat_screen.dart';
import 'package:flutter_app/Fateh/combined.dart';
import 'package:flutter_app/HomePage/apartment.dart';
import 'package:flutter_app/HomePage/home_screen.dart';
import 'package:flutter_app/description_screen.dart';
import 'package:flutter_app/services/Sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
SharedPreferences fatehPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   fatehPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Ajar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF33CCB7),
        accentColor: Color(0xFFB2DFDB),
        scaffoldBackgroundColor: Color(0xFFEBEDEF),
      ),
      home:
      //HomeScreen()

      //PropertyAdv()
      //FirstScreen()
//      ChatScreen(
//        id: 'ZOqiQGm0KlhKppDWsGJz5CXtqnj2',
//        peerID : 'PhiRAhH0kMQ8POHrlYw76IESsez2',
//      )
//      ApartmentScreen(
//
//        apartment:
//        Apartment(
//          imageUrl: 'assets/images/4.jpg',
//          location: 'Rabia,Amman',
//          area: '230',
//          rentpermonth: 400,
//        ),
//      ),
      //ChatScreen()

      SignIn(),



    );
  }

}