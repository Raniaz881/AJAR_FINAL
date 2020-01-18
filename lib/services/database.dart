import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future<void> updateUserData({String email, String pass, String firstName, String lastName, String phoneNumber}) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'pass': pass,
      'nickname': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
      'id': uid,
      'chattingWith': '',
    });
  }

}