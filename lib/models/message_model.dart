import 'package:flutter_app/models/users_model.dart';



class Message{

final User sender ;  //User >> Sender >> name (one inside the other )
final String time ;
final String text ;
final bool isLiked ; 
final bool unread ; 


Message({

this.sender ,
this.time   ,
this.text   ,
this.isLiked,
this.unread, 

});//end of the default constructor 
}
/// CURRENT USER 
final User currentUser = User (
id: 0 ,
name:  'Current User ' , 
imageUrl:  'assets/images/greg.jpg' , 


);///end current user object 

final User greg= User (
id:1 ,
name:'Greg' , 
imageUrl:'assets/images/greg.jpg' , 

); //end of the Greg Object 

final User james= User (
id:2 ,
name:'james' , 
imageUrl:'assets/images/james.jpg' , 

); //end of the James Object 

final User john= User (
id:3 ,
name:'john' , 
imageUrl:'assets/images/john.jpg' , 

); //end of the john Object

final User olivia= User (
id:4 ,
name:'olivia' , 
imageUrl:'assets/images/olivia.jpg' , 

); //end of the olivia Object

final User sam= User (
id:5 ,
name:'sam' , 
imageUrl:'assets/images/sam.jpg' , 

); //end of the sam Object

final User sophia= User (
id:6 ,
name:'sophia' , 
imageUrl:'assets/images/sophia.jpg' , 

); //end of the Sophia Object

final User steven= User (
id:7 ,
name:'steven' , 
imageUrl:'assets/images/steven.jpg' , 

); //end of the Steven Object

//Upper Bar Favorite Contacts
List<User> favorites = [sam, olivia, john, james, greg] ; 

List<Message> chats = [
Message(
  sender: james , 
  time : '5:30 PM' , 
  text : 'Hey How are you' ,
  isLiked : true ,
  unread: false , 
 
) , 

Message(
  sender: olivia , 
  time : '2:30 PM' , 
  text : 'Are you there' ,
  isLiked : false ,
  unread: false , 
 
) , 
Message(
  sender: john , 
  time : '6:30 PM' , 
  text : 'I Wana talk to you as soon as possible ' ,
  isLiked : false ,
  unread: true , 
 
) , 
Message(
  sender: sam , 
  time : '9:30 PM' , 
  text : 'Call me ASAP' ,
  isLiked : false ,
  unread: true, 
 
) , 
Message(
  sender: greg  , 
  time : '9:30 PM' , 
  text : 'Call me ASAP' ,
  isLiked : false ,
  unread: true, 
 
) , 
Message(
  sender: sophia  , 
  time : '9:30 PM' , 
  text : 'Call me ASAP' ,
  isLiked : false ,
  unread: true, 
 
) ,
Message(
  sender: steven  , 
  time : '9:30 PM' , 
  text : 'Call me ASAP' ,
  isLiked : false ,
  unread: true, 
 
) ,

]; // end of chats List 


//Example Messages that occur in chat screen (Actual chat between 2 users James and currentUser(me))

List<Message> messages= [
 Message(
  sender: currentUser , 
  time: '5:30 PM' , 
  text:'Good morning judges' ,
  isLiked: false ,
  unread: true , 

 ),

  Message(
  sender: james , 
  time: '5:30 PM' , 
  text:'Morning AJAR' ,
  isLiked: true ,
  unread: true , 

 ),

 Message(
  sender: currentUser , 
  time: '5:30 PM' , 
  text:'Check Point i\'v heard' ,
  isLiked: false ,
  unread: true , 

 ),

  Message(
  sender: james , 
  time: '5:30 PM' , 
  text:'kk' ,
  isLiked: false ,
  unread: true , 

 ),
   Message(
  sender: currentUser , 
  time: '5:30 PM' , 
  text:'ok let\s get is started then' ,
  isLiked: true ,
  unread: true , 

 ),
   Message(
  sender: james , 
  time: '5:30 PM' , 
  text:'Alright' ,
  isLiked: true ,
  unread: false , 

 ),
 
   Message(
  sender: currentUser , 
  time: '5:30 PM' , 
  text:'Helo' ,
  isLiked: false ,
  unread: true , 

 ),



];

