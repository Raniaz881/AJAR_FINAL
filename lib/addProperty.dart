import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/app_data.dart';
import 'package:flutter_app/app_methods.dart';
import 'package:flutter_app/firebase_methods.dart';
import 'package:flutter_app/main.dart';
import 'package:image_picker/image_picker.dart';


class User {
  final String name , address , date;

  const User({
    this.name ,
    this.address ,
    this.date ,
  });
}



class PropertyAdv extends StatefulWidget {
  @override
  _PropertyAdvState createState() => _PropertyAdvState ( );

}

Map<String , File> imagesMap = new Map( );
TextEditingController titleController = new TextEditingController( );
TextEditingController addressController = new TextEditingController( );
TextEditingController rentController = new TextEditingController( );
TextEditingController areaController = new TextEditingController( );
TextEditingController bedroomsController = new TextEditingController( );
TextEditingController bathroomsController = new TextEditingController( );
TextEditingController descriptionController = new TextEditingController( );


class _PropertyAdvState extends State<PropertyAdv> {
  List<Object> images = List<Object> ();
  Future<File> _imageFile;

  void initState() {
    // TODO: implement initState
    super.initState ( );
    setState ( () {
      images.add ( "Add Image" );
      images.add ( "Add Image" );
      images.add ( "Add Image" );
      images.add ( "Add Image" );
      images.add ( "Add Image" );
      images.add ( "Add Image" );
      images.add ( "Add Image" );
      images.add ( "Add Image" );
      images.add ( "Add Image" );
    } );
  }
  List<File> imageList;
  AppMethods appMethod = new FirebaseMethods( );

  addNewProperty() async {
    // get the text from individual controllers title,rent,description..
    Map<String , dynamic> newProperty = {
      area: areaController.text ,
      title: titleController.text ,
      rent: rentController.text ,
      bedrooms: bedroomsController.text ,
      bathrooms: bathroomsController.text ,
      description: descriptionController.text ,
    };
    // adding the information to firebase
    String propertyID = await appMethod.addNewProperty (
        newProperty: newProperty );
    // to upload images to firestorage
    List<String> imagesURL = await appMethod.uploadImage (
        docID: propertyID , imageList: imageList );
    //update info after uploading
   // bool result = await appMethod.updatePropertyImages (
     //   docID: propertyID , data: imagesURL );

    //if(result !=null && result == true){
    //resetEverything();
    //}

    //   }else{

//  }

    //void resetEverything() {

    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Color ( 0xFF50A0A0 ) ,
      body: ListView ( children: <Widget>[
        Padding (
            padding: EdgeInsets.symmetric ( vertical: 20.0 ) ,
            child: Column ( children: <Widget>[
              Container (
                alignment: Alignment.centerLeft ,
                child: IconButton (
                  onPressed: () {
                    Navigator.push ( context ,
                        MaterialPageRoute ( builder: (context) {
                          return MyApp ( );
                        } ) );
                  } ,
                  padding: EdgeInsets.symmetric ( vertical: 5.0 ) ,
                  icon: Icon ( Icons.arrow_back_ios ) ,
                  color: Colors.white ,
                ) ,
              ) ,
              Padding (
                padding: EdgeInsets.symmetric (
                    horizontal: 20.0 , vertical: 5.0 ) ,
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.stretch ,
                  children: <Widget>[
                    Text (
                      'Add Property ' ,
                      style: TextStyle (
                          fontWeight: FontWeight.bold ,
                          color: Colors.white ,
                          fontSize: 25.0 ,
                          fontFamily: 'Raleway' ) ,
                    ) ,
                    Text (
                      'Your Information should be correct' ,
                      style: TextStyle (
                          color: Colors.white ,
                          fontSize: 10.0 ,
                          fontFamily: 'Raleway' ) ,
                    ) ,
                  ] ,
                ) ,
              ) ,
              Column (
                  crossAxisAlignment: CrossAxisAlignment.start , children: <
                  Widget>[
                Padding (
                    padding: EdgeInsets.only (
                      left: 30.0 ,
                      right: 30.0 ,
                      top: 25.0 ,
                    ) ,
                    child: Column (
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: <Widget>[
                          Text (
                            'Name Property' ,
                            style: TextStyle (
                              fontFamily: 'Raleway' ,
                              fontWeight: FontWeight.bold ,
                              color: Colors.white ,
                            ) ,
                          ) ,
                          Container (
                            alignment: Alignment.centerLeft ,
                            height: 60.0 ,
                            child: TextFormField (
                              keyboardType: TextInputType.text ,
                              controller: titleController ,

                              style: TextStyle (
                                color: Colors.white ,
                              ) ,
                              decoration: InputDecoration (
                                contentPadding: EdgeInsets.only ( top: 14.0 ) ,
                                hintText: 'please write title for your property' ,
                                hintStyle: TextStyle (
                                  color: Colors.white30 ,
                                ) ,
                              ) ,
                            ) ,
                          ) ,
                          SizedBox (
                            height: 10.0 ,
                          ) ,
                          Column (
                              crossAxisAlignment: CrossAxisAlignment.start ,
                              children: <Widget>[
                                Text (
                                  'Address ' ,
                                  style: TextStyle (
                                    fontFamily: 'Raleway' ,
                                    color: Colors.white ,
                                    fontWeight: FontWeight.bold ,
                                  ) ,
                                ) ,
                                Container (
                                  alignment: Alignment.centerLeft ,
                                  height: 60.0 ,
                                  child: TextFormField (
                                    keyboardType: TextInputType.text ,
                                    controller: addressController ,
                                    style: TextStyle (
                                      color: Colors.white ,
                                    ) ,
                                    decoration: InputDecoration (
                                      contentPadding: EdgeInsets.only (
                                          top: 14.0 ) ,
                                      hintText: 'Add address of property' ,
                                      hintStyle: TextStyle (
                                        color: Colors.white30 ,
                                      ) ,
                                    ) ,
                                  ) ,
                                ) ,
                                SizedBox (
                                  height: 10.0 ,
                                ) ,
                                Column (
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start ,
                                    children: <Widget>[
                                      Text (
                                        'Rent' ,
                                        style: TextStyle (
                                          fontFamily: 'Raleway' ,
                                          color: Colors.white ,
                                          fontWeight: FontWeight.bold ,
                                        ) ,
                                      ) ,
                                      Container (
                                        alignment: Alignment.centerLeft ,
                                        height: 60.0 ,
                                        child: TextFormField (
                                          keyboardType: TextInputType.datetime ,
                                          controller: rentController ,
                                          style: TextStyle (
                                            color: Colors.white ,
                                          ) ,
                                          decoration: InputDecoration (
                                            contentPadding:
                                            EdgeInsets.only ( top: 14.0 ) ,
                                            hintText: 'Add address of property' ,
                                            hintStyle: TextStyle (
                                              color: Colors.white30 ,
                                            ) ,
                                          ) ,
                                        ) ,
                                      ) ,
                                      SizedBox (
                                        height: 10.0 ,
                                      ) ,
                                      Column (
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start ,
                                        children: <Widget>[
                                          Text (
                                            'Property Specification ' ,
                                            style: TextStyle (
                                              fontFamily: 'Raleway' ,
                                              fontWeight: FontWeight.bold ,
                                              color: Colors.white ,
                                            ) ,
                                          ) ,
                                          Container (
                                            alignment: Alignment.centerLeft ,
                                            height: 60.0 ,
                                            child: TextField (
                                              keyboardType: TextInputType
                                                  .number ,
                                              controller: areaController ,
                                              style: TextStyle (
                                                color: Colors.white ,
                                              ) ,
                                              decoration: InputDecoration (
                                                contentPadding:
                                                EdgeInsets.only ( top: 14.0 ) ,
                                                hintText: 'Area in m²' ,
                                                hintStyle: TextStyle (
                                                  color: Colors.white30 ,
                                                ) ,
                                              ) ,
                                            ) ,
                                          ) ,
                                          Container (
                                            alignment: Alignment.centerLeft ,
                                            height: 60.0 ,
                                            child: TextField (
                                              keyboardType: TextInputType
                                                  .number ,
                                              controller: bedroomsController ,
                                              style: TextStyle (
                                                color: Colors.white ,
                                              ) ,
                                              decoration: InputDecoration (
                                                contentPadding:
                                                EdgeInsets.only ( top: 14.0 ) ,
                                                hintText: 'Total Bedrooms' ,
                                                hintStyle: TextStyle (
                                                  color: Colors.white30 ,
                                                ) ,
                                              ) ,
                                            ) ,
                                          ) ,
                                          Container (
                                            alignment: Alignment.centerLeft ,
                                            height: 60.0 ,
                                            child: TextField (
                                              keyboardType: TextInputType
                                                  .number ,
                                              controller: bathroomsController ,
                                              style: TextStyle (
                                                color: Colors.white ,
                                              ) ,
                                              decoration: InputDecoration (
                                                contentPadding:
                                                EdgeInsets.only ( top: 14.0 ) ,
                                                hintText: 'No.Of Bathrooms ' ,
                                                hintStyle: TextStyle (
                                                  color: Colors.white30 ,
                                                ) ,
                                              ) ,
                                            ) ,
                                          ) ,
                                          Column (
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start ,
                                            children: <Widget>[
                                              Text (
                                                'Description' ,
                                                style: TextStyle (
                                                  fontFamily: 'Raleway' ,
                                                  fontWeight: FontWeight.bold ,
                                                  color: Colors.white ,
                                                ) ,
                                              ) ,
                                              Container (
                                                alignment: Alignment
                                                    .centerLeft ,
                                                height: 60.0 ,
                                                child: TextField (
                                                  keyboardType:
                                                  TextInputType.text ,
                                                  controller: descriptionController ,
                                                  style: TextStyle (
                                                    color: Colors.white ,
                                                  ) ,
                                                  decoration: InputDecoration (
                                                    contentPadding:
                                                    EdgeInsets.only (
                                                        top: 14.0 ) ,
                                                    hintText:
                                                    'Write Description' ,
                                                    hintStyle: TextStyle (
                                                      color: Colors.white30 ,
                                                    ) ,
                                                  ) ,
                                                ) ,
                                              ) ,


                                              SizedBox (
                                                height: 10.0 ,
                                              ) ,
                                              Column (
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start ,
                                                children: <Widget>[
                                                  Text (
                                                    ' images' ,
                                                    style: TextStyle (
                                                      fontFamily: 'Raleway' ,
                                                      fontWeight: FontWeight
                                                          .bold ,
                                                      color: Colors.white ,
                                                    ) ,
                                                  ) ,
                                                  SizedBox ( height: 10.0 , ) ,
                                                  buildGridView ( ) ,
                                                ] ,
                                              ) ,
                                              SizedBox (
                                                height: 10.0 ,
                                              ) ,
                                              Padding (
                                                padding: EdgeInsets.symmetric (
                                                    horizontal: 100.0 ,
                                                    vertical: 20.0 ) ,
                                                child: FlatButton (
                                                  shape: RoundedRectangleBorder (
                                                      borderRadius:
                                                      BorderRadius.circular (
                                                          15.0 ) ,
                                                      side: BorderSide (
                                                        color: Colors.white30 ,
                                                      ) ) ,
                                                  color: Color ( 0xFF003232 ) ,
                                                  onPressed: ()  {Firestore.instance.collection(Properties).document().setData(addNewProperty());},
                                                  child: Text (
                                                    'Add property' ,
                                                    style: TextStyle (
                                                      color: Colors.white ,
                                                      fontFamily: 'Raleway',
                                                      fontSize: 20.0 ,
                                                      fontWeight: FontWeight
                                                          .bold ,
                                                    ) ,
                                                  ) ,
                                                ) ,
                                              ) ,

                                            ] ,
                                          ) ,
                                        ] ,
                                      ) ,
                                    ] ) ,
                              ], ) ,
                        ], ),
                ),
              ], ),
            ],
            ),
        ),
      ],
      ),

    );

  }

  Widget buildGridView() {
    return GridView.count (
      shrinkWrap: true ,
      crossAxisCount: 3 ,
      childAspectRatio: 1 ,
      children: List.generate ( images.length , (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card (
            clipBehavior: Clip.antiAlias ,
            child: Stack (
              children: <Widget>[
                Image.file (
                  uploadModel.imageFile ,
                  width: 300 ,
                  height: 300 ,
                ) ,
                Positioned (
                  right: 5 ,
                  top: 5 ,
                  child: InkWell (
                    child: Icon (
                      Icons.remove_circle ,
                      size: 20 ,
                      color: Colors.red ,
                    ) ,
                    onTap: () {
                      setState ( () {
                        images.replaceRange (
                            index , index + 1 , ['Add Image'] );
                      } );
                    } ,
                  ) ,
                ) ,
              ] ,
            ) ,
          );
        } else {
          return Card (
            child: IconButton (
              icon: Icon ( Icons.add ) ,
              onPressed: () {
                _onAddImageClick ( index );
              } ,
            ) ,
          );
        }
      } ) ,
    );
  }

  Future _onAddImageClick(int index) async {
    setState ( () {
      _imageFile = ImagePicker.pickImage ( source: ImageSource.gallery );
      getFileImage ( index );
    } );
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then ( (file) async {
      setState ( () {
        ImageUploadModel imageUpload = new ImageUploadModel( );
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange ( index , index + 1 , [imageUpload] );
      } );
    } );
  }
}


class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded ,
    this.uploading ,
    this.imageFile ,
    this.imageUrl ,
  });


}