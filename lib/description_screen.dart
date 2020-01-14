import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage/apartment.dart';
import 'package:flutter_app/request_property.dart';


class ApartmentScreen extends StatefulWidget {
  final Apartment apartment;

  ApartmentScreen({this.apartment});

  @override
  _ApartmentScreenState createState() => _ApartmentScreenState();
}

class _ApartmentScreenState extends State<ApartmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 20.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              Positioned(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Carousel(
                          boxFit: BoxFit.cover,
                          images: [
                            AssetImage('assets/images/1.jpg'),
                            AssetImage('assets/images/1a.jpg'),
                            AssetImage('assets/images/1b.jpg'),
                          ],
                          autoplay: false,
                          dotBgColor: Colors.white.withOpacity(0.5),
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 2000)),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2 - 20.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 98,
                bottom: 0,
                right: 25,

                child: Container(


                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,

                  ),
                  child: IconButton(
                    icon: Icon(Icons.favorite_border),
                    color: Colors.red,
                    iconSize: 40,
                    onPressed: (){},
                  ),

                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 35.0,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + 25.0,
                left: 15.0,
                child: Container(
                  height: (MediaQuery.of(context).size.height / 2) - 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: [
                      Text(
                        '500 JDs',
                        style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF726B68)),
                      ),
                      SizedBox(height: 7.0),
                      Text(
                        'Per month',
                        style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black26),
                      ),

                      SizedBox(height: 10.0),
                      //This is the line
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Container(
                          height: 0.5,
                          color: Color(0xFFC6C4C4),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Utilities',
                        style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF726B68)),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                          height: 110.0,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                buildIngredientItem(
                                  '4 Bedrooms',
                                  Icon(Icons.hotel,
                                      size: 20.0, color: Colors.white),
                                  Color(0xFF6FC5DA),
                                ),
                                buildIngredientItem(
                                    '240 m²',
                                    Icon(Icons.home,
                                        size: 20.0, color: Colors.white),
                                    Color(0xFF615955)),
                                buildIngredientItem(
                                    'City view',
                                    Icon(Icons.location_city,
                                        size: 20.0, color: Colors.white),
                                    Color(0xFFF39595)),
                                buildIngredientItem(
                                    'Laundry room',
                                    Icon(Icons.local_laundry_service,
                                        size: 20.0, color: Colors.white),
                                    Color(0xFF8FC28A)),
                                buildIngredientItem(
                                    '3 Bathrooms',
                                    Icon(Icons.wc,
                                        size: 20.0, color: Colors.white),
                                    Color(0xFF3B8079)),
                                buildIngredientItem(
                                    'Personal garage',
                                    Icon(Icons.directions_car,
                                        size: 20.0, color: Colors.white),
                                    Color(0xFFF8B870)),
                                SizedBox(width: 25.0),
                              ])),
                      Padding(
                          padding: const EdgeInsets.only(right: 35.0),
                          child: Container(
                            height: 0.5,
                            color: Color(0xFFC6C4C4),
                          )),
                      SizedBox(
                        height: 10.0,
                        width: 10.0,
                      ),
                      Text(
                        'Furnished apartment located in Amman.Located 2.6 km from US Embassy',
                        style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF726B68)),
                      ),

                      //Line
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Colors.white30,
                                )),
                            color: Colors.blue,
                            child: Text(
                              'Request Property',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Raleway',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RequestForm());
                              Navigator.of(context).push(route);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildIngredientItem(String name, Icon iconName, Color bgColor) {
    return Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Column(children: [
          Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0), color: bgColor),
              child: Center(child: iconName)),
          SizedBox(height: 4.0),
          Container(
              width: 75.0,
              child: Center(
                  child: Text(name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'nunito',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC2C0C0)))))
        ]));
  }
}

class OfficeScreen extends StatefulWidget {
  final Office office;

  OfficeScreen({this.office});

  @override
  _OfficeScreenState createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 20.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              Positioned(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Carousel(
                          boxFit: BoxFit.cover,
                          images: [
                            AssetImage('assets/images/b1.jpg'),
                            AssetImage('assets/images/02.jpg'),
                            AssetImage('assets/images/o1.jpg'),
                            AssetImage('assets/images/03.webp'),
                          ],
                          autoplay: false,
                          dotBgColor: Colors.white.withOpacity(0.5),
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 2000)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2 - 20.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 35.0,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + 25.0,
                left: 15.0,
                child: Container(
                  height: (MediaQuery.of(context).size.height / 2) - 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: [
                      Text(
                        '30,000 JDs',
                        style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF726B68)),
                      ),
                      SizedBox(height: 7.0),
                      Text(
                        'Per Year',
                        style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black26),
                      ),

                      SizedBox(height: 10.0),
                      //This is the line
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Container(
                          height: 0.5,
                          color: Color(0xFFC6C4C4),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Utilities',
                        style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF726B68)),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                          height: 110.0,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                buildIngredientItem(
                                    '270 m²',
                                    Icon(Icons.home,
                                        size: 20.0, color: Colors.white),
                                    Color(0xFF615955)),
                                buildIngredientItem(
                                    ' 5 Office rooms',
                                    Icon(Icons.location_city,
                                        size: 20.0, color: Colors.white),
                                    Color(0xFFF39595)),
                                buildIngredientItem(
                                    '6 Desks',
                                    Icon(Icons.desktop_windows,
                                        size: 20.0, color: Colors.white),
                                    Color(0xFF8FC28A)),
                                buildIngredientItem(
                                    '3 Bathrooms',
                                    Icon(Icons.wc,
                                        size: 20.0, color: Colors.white),
                                    Color(0xFF3B8079)),
                                buildIngredientItem(
                                    ' Garage',
                                    Icon(Icons.directions_car,
                                        size: 20.0, color: Colors.white),
                                    Color(0xFFF8B870)),
                                SizedBox(width: 25.0),
                              ])),
                      Padding(
                          padding: const EdgeInsets.only(right: 35.0),
                          child: Container(
                            height: 0.5,
                            color: Color(0xFFC6C4C4),
                          )),
                      SizedBox(
                        height: 10.0,
                        width: 10.0,
                      ),
                      Text(
                        'Furnished apartment located in Amman.Located 2.6 km from US Embassy',
                        style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF726B68)),
                      ),
                      SizedBox(height: 15.0),
                      //Line
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100.0, vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Colors.white30,
                                )),
                            color: Colors.blue,
                            child: Text(
                              'Request Property',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Raleway',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RequestForm());
                              Navigator.of(context).push(route);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildIngredientItem(String name, Icon iconName, Color bgColor) {
    return Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Column(children: [
          Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0), color: bgColor),
              child: Center(child: iconName)),
          SizedBox(height: 4.0),
          Container(
              width: 75.0,
              child: Center(
                  child: Text(name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'nunito',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC2C0C0)))))
        ]));
  }
}
