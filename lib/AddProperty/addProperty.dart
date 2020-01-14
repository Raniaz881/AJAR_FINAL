import 'dart:io';
import 'MyProperties.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class User {
  final String name, address, date;

  const User({
    this.name,
    this.address,
    this.date,
  });
}

class AddProperty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PropertyAdv(),
    );
  }
}

// ignore: must_be_immutable
class PropertyAdv extends StatefulWidget {
  @override
  _PropertyAdvState createState() {
    return _PropertyAdvState();
  }
}
var _nameController = new TextEditingController();
var _addressController = new TextEditingController();
var _dateController = new TextEditingController();

class _PropertyAdvState extends State<PropertyAdv> {
  List<Object> images = List<Object>();
  Future<File> _imageFile;

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF607D8B),
      body: ListView(children: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return MyApp();
                        }));
                  },
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Add Property ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'Raleway'),
                    ),
                    Text(
                      'Your Information should be correct',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontFamily: 'Raleway'),
                    ),
                  ],
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
                Padding(
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 25.0,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Name Property',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 60.0,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _nameController,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 14.0),
                                hintText: 'please write title for your property',
                                hintStyle: TextStyle(
                                  color: Colors.white30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Address ',
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 60.0,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: _addressController,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      hintText: 'Add address of property',
                                      hintStyle: TextStyle(
                                        color: Colors.white30,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Rent Date',
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 60.0,
                                        child: TextFormField(
                                          keyboardType: TextInputType.datetime,
                                          controller: _dateController,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                            EdgeInsets.only(top: 14.0),
                                            hintText: 'Add address of property',
                                            hintStyle: TextStyle(
                                              color: Colors.white30,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Property Specification ',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: 60.0,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                EdgeInsets.only(top: 14.0),
                                                hintText: 'Size',
                                                hintStyle: TextStyle(
                                                  color: Colors.white30,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: 60.0,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                EdgeInsets.only(top: 14.0),
                                                hintText: 'Total Beedrooms',
                                                hintStyle: TextStyle(
                                                  color: Colors.white30,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: 60.0,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                EdgeInsets.only(top: 14.0),
                                                hintText: 'No.Of Bathrooms ',
                                                hintStyle: TextStyle(
                                                  color: Colors.white30,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'More Describe',
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                height: 60.0,
                                                child: TextField(
                                                  keyboardType:
                                                  TextInputType.text,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                    EdgeInsets.only(
                                                        top: 14.0),
                                                    hintText:
                                                    'Write more describe',
                                                    hintStyle: TextStyle(
                                                      color: Colors.white30,
                                                    ),
                                                  ),
                                                ),
                                              ),


                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    ' images',
                                                    style: TextStyle(
                                                      fontFamily: 'Raleway',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0,),
                                                  buildGridView(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  FlatButton(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 100.0,
                                                        vertical: 20.0),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(15.0),
                                                        side: BorderSide(
                                                          color: Colors.white30,
                                                        )),
                                                    color: Colors.blue,
                                                    child: Text(
                                                      'Add Property',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Raleway',
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      var route = new MaterialPageRoute(
                                                        builder:
                                                            (BuildContext context) =>
                                                        new ListProperty(
                                                            value: User(
                                                              name: _nameController.text,
                                                              address:
                                                              _addressController.text,
                                                              date: _dateController.text,
                                                            )),
                                                      );
                                                      Navigator.of(context).push(route);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                              ]),
                        ] )
                )])
            ]))
      ]),
    );

  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}