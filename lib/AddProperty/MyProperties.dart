import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'addProperty.dart';

class ListProperty extends StatefulWidget {
  final User value;

  ListProperty({Key key, this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _ListPropertyState();
}

class _ListPropertyState extends State<ListProperty> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My Property",
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
                        margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 20.0),
                        height: 170.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),

                        child: Padding(
                          padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${widget.value.name}',
                                    style: TextStyle(
                                      color: Color(0xFF607D8B),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway',
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${widget.value.address}',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      color: Color(0xFF607D8B),
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${widget.value.date}',
                                    style: TextStyle(
                                      color: Color(0xFF607D8B),
                                      fontFamily: 'Raleway',
                                      fontSize: 18.0,
                                    ),
                                  ),
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