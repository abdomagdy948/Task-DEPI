import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStore {
  static var db = FirebaseFirestore.instance;

  static addUser({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
  }) {
    var user = {
      'userName': userName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
    db.collection('users').add(user);
  }
}
