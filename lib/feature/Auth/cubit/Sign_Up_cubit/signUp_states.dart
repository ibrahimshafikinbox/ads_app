import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {
  // final User? user;

  // SignUpSuccessState(this.user);
}

class SignUpErrorState extends SignUpStates {
  final String error;

  SignUpErrorState(this.error);
}

class ChangePasswwordState extends SignUpStates {}
