import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class Listrequest extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ListrequestState();
}

class _ListrequestState extends State<Listrequest> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(" List Of Request",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF607D8B),
          ),),
      ),
      backgroundColor: Color(0xFF607D8B),

      body:
      Column(
          children: <Widget>[
            Expanded(
                child: Stack(
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                        height: 170.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),

                        child: Padding(
                          padding: EdgeInsets.fromLTRB(50.0, 40.0, 50.0, 40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('add the name for tenant from Firebase automaticlly',
                                  style: TextStyle(
                                    color: Color(0xFF607D8B),
                                    fontFamily: 'Raleway',
                                    fontSize: 18.0,)),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 10.0),

                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),

                                        side: BorderSide(
                                          color: Colors.white30,
                                        )),
                                    color: Colors.blue,
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                    },
                                  ),

                                  FlatButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 10.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        side: BorderSide(
                                          color: Colors.white30,
                                        )),
                                    color: Colors.blue,
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                    },
                                  )
                                ],
                              ),


                            ],
                          ),
                        ),
                      ),
                    ]))
          ]),

    );
  }
}