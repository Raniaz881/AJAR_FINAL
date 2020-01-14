import 'package:flutter/material.dart';
import 'package:flutter_app/services/Sign_in.dart';

void main() => runApp(MyApp());

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
      home: SignIn(),



    );
  }

}