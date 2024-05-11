import 'package:ads_app/feature/Auth/cubit/Login_cubit/Login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logInWithEmailAndPassword(
      String email, String password, String name) async {
    emit(LoginLoadingState());
    try {
      final logindata = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveLoginState();
      emit(LoginSuccessState());
      print(logindata.toString());
    } on FirebaseAuthException catch (e) {
      print(">>>>${e.toString()}");
      emit(LoginErrorState());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _auth.signInWithCredential(credential);
      await saveLoginState();
      emit(LoginSuccessState());
    } on Exception catch (_, e) {
      print('exception->$e');
    }
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Removes just the login state
    // await prefs.clear();  // Use this if you want to clear all data stored in SharedPreferences
  }

  Future<void> saveLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswwordState());
  }
}
