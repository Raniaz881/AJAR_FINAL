import 'package:flutter_app/models/message_model.dart';
import 'package:flutter_app/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  /// NOTE TO JORDAN : when your relate this to the backend you will need a room id and pass the room id and based on the room id you will populate the messages

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

_buildMessage(Message message,bool isMe){
 return Row(
   children: <Widget>[
     Container(
       margin: isMe? 
       EdgeInsets.only(top: 8.0, bottom: 8.0,left: 80.0 ) 
       :EdgeInsets.only(top: 8.0, bottom: 8.0, ),
       
       
        
       padding: EdgeInsets.symmetric(horizontal: 15.0 ,vertical: 15.0) , 

       width: MediaQuery.of(context).size.width*0.75 ,
       decoration: BoxDecoration(
         color: isMe?
        Theme.of(context).accentColor 
        :Color(0xFFFFFEFEE) ,



         borderRadius: isMe? BorderRadius.only(
           topLeft: Radius.circular(15.0),
           bottomLeft: Radius.circular(15.0),   ) 
           : BorderRadius.only(
           topRight: Radius.circular(15.0),
           bottomRight: Radius.circular(15.0),   )
           ),

       child:Column(
          crossAxisAlignment : CrossAxisAlignment.start ,
         children: <Widget>[
           Text(message.time , style: TextStyle(color:Colors.blueGrey , fontWeight: FontWeight.w600, fontSize: 16.0 , ),) , 
           SizedBox( height: 5.0) , 
           Text(message.text , style: TextStyle(color:Colors.blueGrey , fontWeight: FontWeight.w600, fontSize: 16.0 , ),),
         ],
       ) ,
       
       ),
           !isMe? IconButton(
              icon: message.isLiked ?
               Icon(Icons.favorite) 
              :Icon(Icons.favorite_border),
              iconSize: 30.0,
              color: message.isLiked?
               Theme.of(context).primaryColor 
              :Colors.blueGrey,
              onPressed: () {},
            ) :SizedBox.shrink()  , 

   ],
 );
}
_buildKeyBoard(){
   
  return Container(
padding: EdgeInsets.symmetric(horizontal: 8.0),
color: Colors.white,
height: 60.0 , 
child: Row(children: <Widget>[
  IconButton(
    icon:Icon(Icons.photo_library)  , 
    color:Theme.of(context).primaryColor , 
    onPressed: (){},
  ),
  Expanded(child: TextField(
    decoration: InputDecoration.collapsed(hintText: "Send a message ..", ),
    
  ),
  ),
  IconButton(
    icon:Icon(Icons.send)  , 
    color:Theme.of(context).primaryColor , 
    onPressed: (){
       
    },
  ) 

],
),

  );
} 





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Center(
            child: Text(
              widget.user.name,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      )),
                  child: ClipRRect( //this one activates when you scroll up the text won't go above the border it clips the text to maintain the shaped rounded view
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: ListView.builder(
                    //  reverse: true ,
                      padding: EdgeInsets.only(top:15.0) , 
                      itemCount: messages.length, 
                      itemBuilder: (BuildContext context, int index) {
                        final Message message=messages[index] ;
                        final bool isMe=message.sender.id==currentUser.id ;  
                        return _buildMessage(message,isMe);
                      },
                      
                    ),
                  )
                  ),
            ),

            _buildKeyBoard() , 
          ],
        )
        );
  }
}
