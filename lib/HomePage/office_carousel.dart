import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage/apartment.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_app/HomePage/apartment.dart';

import '../description_screen.dart';
class OfficeCarousel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Offices',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => print('See All'),
                child: Text('See All',
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    )),
              )
            ],
          ),
        ),
        Container(
          height: 300.0,
          color: Colors.white30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              Office office  = offices[index];

              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) => OfficeScreen(
                    office: office,
                  ),
                )),
                child: Container(
                    margin: EdgeInsets.all(10.0),
                    width: 220.0,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          bottom: 15.0,
                          child: Container(
                            height: 120.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Text(
                                    office.location,
                                    style: TextStyle(
                                        color: Colors.blueGrey
                                    ),
                                  ),

                                  Text(
                                    '${office.description} description',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0,20.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Container(
                            height: 180.0,
                            width:  200.0,
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
                                indicatorBgPadding: 10.0,
                                animationCurve: Curves.fastOutSlowIn,
                                animationDuration: Duration(milliseconds: 2500),



                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            },),),
      ],
    );
  }
}