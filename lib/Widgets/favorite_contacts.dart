import 'package:flutter_app/chat//chat_screen.dart';
import 'package:flutter_app/models/message_model.dart';
import 'package:flutter/material.dart';

class FavoriteContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // this will make a space between the Favorite contacts and the icon (each at a side)
              children: <Widget>[
                //first child of the coulmn (text,more_horiz button)
                Text("Favorites Contacts",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                    )),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Container(
            //the second child list of the avatars+their names
            height: 120,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              // this will make a space from the left side so avatars and names don't stick to the left side
              itemCount: favorites.length,
              // this is the size of the list based on the number of favorites in the Message Class
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (_) => ChatScreen(user: favorites[index])),
//                    ),
                  },
                  // why did we wrap the padding not the container  is because the container mainly has the colors and the other properties while the padding is the widget which contains the actual avatars

                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      //sub-section inside the container
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:
                              AssetImage(favorites[index].imageUrl),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          favorites[index].name,
                          //  this will print the names of the favorites based on the index (because we made a list of users(objects)
                          //in the message_model and each object has 3 properties which is id and name and imageUrl)
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
