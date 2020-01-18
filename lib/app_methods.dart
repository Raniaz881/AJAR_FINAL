import 'dart:async';
import 'dart:io';


abstract class AppMethods{
Future<String> addNewProperty({Map newProperty});
Future<List<String>> uploadImage({List<File> imageList, String docID});
Future<bool> updatePropertyImages({String docID,List<String> data});

}

