import 'package:flutter_app/chat/chat_screen.dart';
import 'package:flutter_app/models/message_model.dart';
import 'package:flutter/material.dart';

class RecentChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            )),
        child: ListView.builder(    //the list of the recent chats (avatar+timing+recent chat )
          itemCount: chats.length,  //size of the recent chat
          itemBuilder: (BuildContext context, int index) {  // content of the list 
           final Message chat=chats[index] ; // we made a variable chat so we don't have to write chat[index] in each time we need to use it 
            return GestureDetector(

              onTap:() => Navigator.push(context , MaterialPageRoute(builder: (_)  => ChatScreen(user: chat.sender)), ), //(curse), we used navigator because it goes forward and backward and will pass the vairable to the chat_screen and we already know the releation between user and sender which is already in message_model 
                          child: Container(
               decoration: BoxDecoration(
                 color: chat.unread ? Color(0xFFFFFEFEE) : Colors.white  , //if statement in case unread=true then the color is light red otherise it will be white 
               ),
               
                padding: EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10.0 , ), //padding->refers to the inner border of the container 
                margin: EdgeInsets.only(top: 5.0 , bottom: 5.0 , right: 20.0 ), //margin-> refers to the outter border of the whole container 
                child: Row(  // why we made nested rows is because to avoid the time and the notification alarm to come across the text message when  the message is short so we separate it by making nested rows and inside the second row we put  a coulmn inside it the time and the notification button
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // a space between the two rows 
                  children: <Widget>[
                    Row(       // each row 
                      children: <Widget>[
                        CircleAvatar(radius:35.0 ,backgroundImage: AssetImage(chat.sender.imageUrl),) , // we tookthe image from the chat list then through the sender which it's datatype is user so this way we can access the image Url and we used chat because we wana relate the text of each user to the other one 
                       SizedBox(width: 10,), // this is a space inbetween the avatar and the name and text next to it 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,  /// this will let the text +name of the users next to their photos(same as a space)
                          children: <Widget>[
                            Text( chat.sender.name, style: TextStyle(
                              color:Colors.grey , 
                              fontWeight: FontWeight.bold  ,
                              fontSize: 15.0 ,  
                              )
                              
                            ),
                            SizedBox(height : 5.0) , // a space inbetween the name and the draft message 
                            Container(
                              width: MediaQuery.of(context).size.width*0.45 , // this works with the overflow together to make a text disappear from the right edge 
                              child: Text(chat.text , 
                              style: TextStyle(
                                color:Colors.blueGrey , 
                                fontWeight: FontWeight.w600  ,
                                fontSize: 15.0 ,  
                                ) ,
                                overflow: TextOverflow.ellipsis,
                                ),
                            ) , 
                          ],
                        ),
                      ],
                    ),
                   Column(children: <Widget>[ //(this is concered to the time )
                     Text(chat.time ,style: TextStyle(
                              color:Colors.grey , 
                              fontWeight: FontWeight.bold  ,
                              fontSize: 15.0 ,  
                              ) ),
                              SizedBox(height: 5.0,),  
                      chat.unread ? Container(           // All these properties is concered to the (NEW ) notification word beneath the time // and if statement is added to show the NEW incase the msg is unread otherwise empty tet
                        width: 40.0 ,
                        height: 20.0 ,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor ,  // color of the button (primary color)
                          borderRadius: BorderRadius.circular(30.0) ,  // border of the (NEW) word 
                        ),
                        alignment: Alignment.center , // setting the NEW word in the middle of the container 
                       child: 
                        Text("New" ,style: TextStyle(
                              color:Colors.white , 
                              fontWeight: FontWeight.bold  ,
                              fontSize: 12.0 ,  
                              )  )
                              ) : Text('') ,  // the New word will disappear when the msg is  opened 
                     
                   ],) , 
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
