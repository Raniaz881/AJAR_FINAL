import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

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

class _PropertyAdvState extends State<PropertyAdv> {
  var _nameController = TextEditingController();
  var priceController = TextEditingController();
  var _viewController = TextEditingController();
  var _numberOfBedroom = TextEditingController();
  var _numberOfBathRooms = TextEditingController();
  var _size = TextEditingController();
  var _specialrooms = TextEditingController();
  var _garagerooms = TextEditingController();
  var _description = TextEditingController();
  var _address = TextEditingController();
  List<Object> images = List<Object>();
  List<File> _listOFImages = <File>[];
  List<String> _listOFImagesUrl = <String>[];
  File _imageFile;
  bool isUploading = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isUploading = false;
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
  Widget buildLoading() {
    return Positioned(
      child: isUploading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent)),
        ),
        color: Colors.white.withOpacity(0.8),
      )
          : Container(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Color(0xFF50A0A0),
          body: ListView(children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
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
                              // Name Controller Used
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
                                    hintText:
                                        'please write title for your property',
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
                                      'Address',
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

                                        controller: _address,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.only(top: 14.0),
                                          hintText:
                                          'Add addrees of property',
                                          hintStyle: TextStyle(
                                            color: Colors.white30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    // Price controller
                                    Text(
                                      'Price',
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
                                        keyboardType: TextInputType.number,
                                        controller: priceController,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 14.0),
                                          hintText:
                                              'Add price of property per month',
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
                                            'View of Appartment',
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
                                              controller: _viewController,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(top: 14.0),
                                                hintText:
                                                    'Add view of property like city view',
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
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  controller: _size,
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
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _numberOfBedroom,
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
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _numberOfBathRooms,
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
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                height: 60.0,
                                                child: TextField(
                                                  controller: _specialrooms,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(top: 14.0),
                                                    hintText:
                                                        'Special rooms like laundary rooms',
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
                                                  controller: _garagerooms,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(top: 14.0),
                                                    hintText:
                                                        'Special Facility Like garages',
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
                                                      controller: _description,
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      buildGridView(),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      FlatButton(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 80.0,
                                                                vertical: 20.0),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                                side: BorderSide(
                                                                  color: Colors
                                                                      .white30,
                                                                )),
                                                        color: Colors.blue,
                                                        child: Text(
                                                          'Add Property',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Raleway',
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        onPressed: () async {



                                                          setState(() {
                                                            isUploading = true;
                                                          });
                                                          uploadMultipleFiles();

                                                          //  Navigator.of(context).push(route);
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
                            ]))
                  ])
                ]))
          ]),
        ),
        buildLoading()
      ],
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
                        _listOFImages.removeLast();
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
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_imageFile != null) {
      _listOFImages.add(_imageFile);
    }
    ImageUploadModel imageUpload = new ImageUploadModel();
    imageUpload.isUploaded = false;
    imageUpload.uploading = false;
    imageUpload.imageFile = _imageFile;
    imageUpload.imageUrl = '';
    images.replaceRange(index, index + 1, [imageUpload]);
    //getFileImage(index);
    setState(() {});
  }

//  void getFileImage(int index) async {
////    var dir = await path_provider.getTemporaryDirectory();
//
//    _imageFile.then((file) async {
//      setState(() {
//        ImageUploadModel imageUpload = new ImageUploadModel();
//        imageUpload.isUploaded = false;
//        imageUpload.uploading = false;
//        imageUpload.imageFile = file;
//        imageUpload.imageUrl = '';
//        images.replaceRange(index, index + 1, [imageUpload]);
//      });
//    });
//  }

  void uploadMultipleFiles() {
    print(_imageFile);
    print(_listOFImages);
    if (_listOFImages.length == 0) {
      Fluttertoast.showToast(
          msg: 'Please atleast add one immage', gravity: ToastGravity.CENTER);
    }
    //print('fbfdd');
    else {
      _listOFImages.forEach((file) {
        // Uploading single file
        uploadFile(file);
      });
      print(_listOFImagesUrl);
    }
    //return _listOFImagesUrl;
    //Firestore.instance.collection('Appartments');
  }

  Future uploadFile(File file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(file);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      //imageUrl = downloadUrl;
      _listOFImagesUrl.add(downloadUrl);
      if (_listOFImagesUrl.length == _listOFImages.length) {
        print(_listOFImagesUrl);
        Firestore.instance
            .collection('Appartment')
            .document(
                '${ajarPreferences.getString('myUID')}-${DateTime.now().millisecondsSinceEpoch.toString()}')
            .setData({
          AppartmentByAjar.bedrooms : _numberOfBedroom.text,
          AppartmentByAjar.bathrooms : _numberOfBathRooms.text,
          AppartmentByAjar.propertyName : _nameController.text,
          AppartmentByAjar.price: priceController.text,
          AppartmentByAjar.viewside: _viewController.text,
          AppartmentByAjar.size: _size.text,
          AppartmentByAjar.specialRooms: _specialrooms.text,
          AppartmentByAjar.garageRooms: _garagerooms.text,
          AppartmentByAjar.description: _description.text,
          AppartmentByAjar.address: _address.text,
          AppartmentByAjar.url : _listOFImagesUrl,
          AppartmentByAjar.ownerUID : ajarPreferences.getString('myUID'),
          AppartmentByAjar.ownenerName : ajarPreferences.getString('nickname')
            }
          );
        setState(() {
          isUploading = false;
        });
      }
    }, onError: (err) {
      Fluttertoast.showToast(msg: 'Error while uploading');
    });
  }
}
class AppartmentByAjar{
  static const  String bedrooms = 'beedrooms';
  static const  String bathrooms = 'bathdrooms';
  static const  String propertyName = 'propertyName';
  static const  String price = 'price';
  static const  String viewside = 'viewside';
  static const  String size = 'size';
  static const  String specialRooms = 'specialRooms';
  static const  String  garageRooms = 'garageRooms';
  static const  String description = 'description';
  static const  String address = 'address';
  static const String url = 'url';
  static const String ownerUID = 'uid';
  static const String ownenerName = 'ownerName';
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
