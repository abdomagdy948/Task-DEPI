import 'package:firebase_auth/firebase_auth.dart';

class AppFirebaseAuth {
  AppFirebaseAuth._();

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static User? get currentUser => _firebaseAuth.currentUser;

  static Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  static Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
