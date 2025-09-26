import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/models/cubits/firebase_auth_cubit/firebase_auth_cubit_state.dart';
import 'package:flutter_task/services/app_firebase_auth.dart';

class FirebaseAuthCubit extends Cubit<FirebaseAuthCubitState> {
  FirebaseAuthCubit() : super(FirebaseAuthCubitInitial());

  Future<void> login(String email, String password) async {
    emit(FirebaseAuthCubitLoading());
    try {
      await AppFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(FirebaseAuthCubitSuccess());
    } catch (e) {
      emit(FirebaseAuthCubitFailure(e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    emit(FirebaseAuthCubitLoading());
    try {
      await AppFirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(FirebaseAuthCubitSuccess());
    } catch (e) {
      emit(FirebaseAuthCubitFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(FirebaseAuthCubitLoading());
    try {
      await AppFirebaseAuth.signOut();
      emit(FirebaseAuthCubitSuccess());
    } catch (e) {
      emit(FirebaseAuthCubitFailure(e.toString()));
    }
  }
}
