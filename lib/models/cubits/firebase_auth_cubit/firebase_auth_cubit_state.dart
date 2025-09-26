class FirebaseAuthCubitState {}

class FirebaseAuthCubitInitial extends FirebaseAuthCubitState {}

class FirebaseAuthCubitLoading extends FirebaseAuthCubitState {}

class FirebaseAuthCubitSuccess extends FirebaseAuthCubitState {}

class FirebaseAuthCubitFailure extends FirebaseAuthCubitState {
  final String errorMessage;
  FirebaseAuthCubitFailure(this.errorMessage);
}
