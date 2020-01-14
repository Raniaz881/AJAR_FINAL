import 'dart:ui';

import 'package:flutter_app/Widgets/category_selector.dart';
import 'package:flutter_app/Widgets/favorite_contacts.dart';
import 'package:flutter_app/Widgets/recent_chats.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  //scaffold is a widget which provide a framework which enables you to build some stuff such as AppBar and similar things
       backgroundColor: Theme.of(context).primaryColor ,    // the primary color of the scaffold (Note: Rania when you wana change color)        
        appBar: AppBar(
          leading: IconButton(
            // a widget to be displayed before the title (Menu Button)
            icon: Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: Colors.white,
            onPressed:
                ()=> {Navigator.pop(context)}, // 
          ),
          title: Center(
            child: Text(
              'Chats',
             // textAlign: TextAlign.center, // this is not working idk why it is still on the left side
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          elevation: 0.0  , //this will remove the shadow line inbetween the horizontal list below  the Appbar
          actions: <Widget>[
            // this widget appears on the upper right side
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.white,
              onPressed:
                  () {}, // NOTE 
            ),
          ],
        ),
        body: Column(   //this is the main part of the app (Core) and we will design it as a columns
          children: <Widget>[
            CategorySelector(),  // this will call the caategory selector class  (1st coulmn) 
            Expanded (              // the expanded will take the full screen view 
               child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor , 
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0) ,
                    topRight: Radius.circular(30.0) , 
                     )
                ),
                 child: Column(                  // the beging of the favorites part
                   children: <Widget>[
                     FavoriteContacts()  ,  // calling favoriteContacts class h
                     RecentChats() , 
                  
                   
                   
                   ],
                 ) ,
                ),
            )

          ],
        ));
  }
}
