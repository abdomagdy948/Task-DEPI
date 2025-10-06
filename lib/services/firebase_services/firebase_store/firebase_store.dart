import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStore {
  String documentId = 'rbqXmlBSQv5NTSjWZHEE';
  static var db = FirebaseFirestore.instance;

  static addUserRegistration({
    required String email,
    required String password,
    required String firstName,
    required String middleName,
    required String lastName,
    required String age,
    required String phoneNumber,
    required String gender,
  }) {
    var user = {
      'email': email,
      'password': password,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'timeStamp': FieldValue.serverTimestamp(),
    };
    db.collection('users').add(user);
  }

  static updateUserProfile({
    required String email,
    required String password,
    required String firstName,
    required String middleName,
    required String lastName,
    required String age,
    required String gender,
  }) {
    var user = {
      'email': email,
      'password': password,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'timeStamp': FieldValue.serverTimestamp(),
    };
    db.collection('users').doc('b7MxqiV06jtWWUgnjjHg').update(user);
  }

  static addUserLogin({required String email, required String password}) {
    var user = {
      'email': email,
      'password': password,
      'timeStamp': FieldValue.serverTimestamp(),
    };
    db.collection('users').doc('b7MxqiV06jtWWUgnjjHg').update(user);
  }

  static Future<Map<String, dynamic>?> getData() async {
    DocumentSnapshot doc = await db
        .collection('users')
        .doc('b7MxqiV06jtWWUgnjjHg')
        .get();

    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      print("Document not found");
      return null;
    }
  }

  static deleteUserAccount() {
    db.collection('users').doc('b7MxqiV06jtWWUgnjjHg').delete();
  }
}
