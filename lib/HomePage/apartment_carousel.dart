import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AddProperty/addProperty.dart';
import 'package:flutter_app/HomePage/apartment.dart';
import 'package:flutter_app/description_screen.dart';


class ApartmentsCarousel extends StatelessWidget {
  List<NetworkImage> _listOfImages = <NetworkImage>[];

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
                'Apartments',
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
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Appartment').snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        _listOfImages =[];
                        for(int i = 0; i < snapshot.data.documents[index].data[AppartmentByFateh.url].length; i++ ) {
                          print(snapshot.data.documents[index].data[AppartmentByFateh.url].length);
                          debugPrint(snapshot.data.documents[index].data[AppartmentByFateh.url][i]);
                          _listOfImages.add(NetworkImage(snapshot.data.documents[index].data[AppartmentByFateh.url][i]));
                        }
                        //_listOfImages.add((value));

                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_)  =>  ApartmentScreen(
                                  documents: snapshot.data.documents[index],
                              ),
                            ),
                          ),
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
                                              snapshot.data.documents[index].data[AppartmentByFateh.address],
                                              style: TextStyle(
                                                  color: Colors.blueGrey
                                              ),
                                            ),
                                            SizedBox(height: 2.0),
                                            Text(
                                              '\$${snapshot.data.documents[index].data[AppartmentByFateh.price]}/ month',
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
                                            images: _listOfImages,
//                                            [
//                                              AssetImage('assets/images/1.jpg'),
//                                              AssetImage('assets/images/1a.jpg'),
//                                              AssetImage('assets/images/1b.jpg'),
//                                            ],
                                            autoplay: false,
                                            dotBgColor: Colors.white.withOpacity(0.5),
                                            indicatorBgPadding: 10.0,

                                            animationCurve: Curves.fastOutSlowIn,
                                            animationDuration: Duration(milliseconds: 2000)


                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      });
                }
                else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

              }
            ))
      ],
    );
  }
}