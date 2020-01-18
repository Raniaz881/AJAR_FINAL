import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/app_data.dart';
import 'package:flutter_app/app_methods.dart';


class FirebaseMethods implements AppMethods{
  Firestore firestore = Firestore.instance;

  @override
  Future<String> addNewProperty({Map newProperty}) async {
    // TODO: implement addNewProperty
    String documentID;
    await firestore.collection(Properties).add(newProperty).then((documentRef){
      documentID = documentRef.documentID;
    });
    return documentID;
  }

  @override
  Future<List<String>> uploadImage({List<File> imageList, String docID})async {
    // TODO: implement uploadImage
    List<String> imagesUrl = new List();

      for(int s = 0; s <imageList.length; s++){
        final ref = FirebaseStorage.instance
            .ref()
            .child(Properties)
            .child(docID)
            .child(docID + "$s.jpg");
       StorageUploadTask uploadTask = ref.putFile(imageList[s]);
        StorageTaskSnapshot storageTaskSnapshot;
        StorageTaskSnapshot snapshot = await uploadTask.onComplete;
        if (snapshot.error == null) {
          storageTaskSnapshot = snapshot;
          final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
          imagesUrl.add(downloadUrl);

          print('Upload success');
        } else {
          print('Error from image repo ${snapshot.error.toString()}');
          throw ('This file is not an image');
        }
      }

    return imagesUrl;
  }

  @override
  Future<bool> updatePropertyImages({String docID, List<String> data}) async {
    // TODO: implement updatePropertyImages
    bool msg;
    await firestore
    .collection(Properties)
    .document(docID)
    .updateData({propertyImages: data}).whenComplete((){
      msg = true;
    });
    return msg;
  }

}