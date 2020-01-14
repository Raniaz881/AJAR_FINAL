import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}
//CategorySelector is made because the container has more than one item
class _CategorySelectorState extends State<CategorySelector> {  
   int selectedIndex =0 ;                          
  final List<String> categories=['Messages','Online','Groups','Requests'] ; 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0, 
      color: Theme.of(context).primaryColor ,  // we took the orignal color of the app which we wrote in the main method 
      child: ListView.builder(  //ListView takes a list of children and makes it scorable 
         scrollDirection:Axis.horizontal,  // this will allow user to scroll the items in a horizontal direction 
        itemCount: categories.length , // the number of the items 
        itemBuilder: (BuildContext context ,int index){
          return   GestureDetector ( // this method to change the color of the text in the horizontal list everytime u click on it
                   onTap: (){           
                   setState(() {
                     selectedIndex= index ; 
                   });     
                   } , 
                      child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0 , vertical: 30.0 , ) , 
              child: Text(categories[index] ,
              style: TextStyle(
               color:  index ==selectedIndex ? Colors.white : Colors.white60 ,  //this statement to identify the selected item will be bright white and other items will be light white 
               fontSize: 24.0 , 
               fontWeight: FontWeight.bold , 
               letterSpacing: 1.2 ,            // this will make a space between the letter of the same word 
               )),
            ),
          ) ;
        },

      ),
      
    );
  }
}