import 'package:ads_app/feature/Auth/cubit/verify_cubit/verfication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerificationCubit extends Cubit<VerficationStates> {
  final EmailOTP myauth = EmailOTP();
  static VerificationCubit get(context) =>
      BlocProvider.of<VerificationCubit>(context);

  VerificationCubit() : super(VerifyAccountInitial()) {
    ;
  }

  void sendOTP(String email) async {
    emit(SendOTPLoding());
    myauth.setConfig(
        appEmail: "me@rohitchouhan.com",
        appName: "Email OTP",
        userEmail: email,
        otpLength: 6,
        otpType: OTPType.digitsOnly);
    if (await myauth.sendOTP()) {
      emit(SendOTPSuccess());
    } else {
      emit(SendOTPError());
    }
  }

  void verifyOTP(String otp) async {
    emit(VerifyAccountLoding());
    if (await myauth.verifyOTP(otp: otp)) {
      emit(VerifyAccountSuccess());
    } else {
      emit(VerifyAccountError());
    }
  }
  // void verifyOTP(String otp) async {
  //   emit(VerifyAccountLoding());
  //   if (await myauth.verifyOTP(otp: otp)) {
  //     emit(VerifyAccountSuccess());
  //     saveVerificationStatus(
  //         true); // Make sure this is called on successful verification
  //     await registerToken();
  //   } else {
  //     emit(VerifyAccountError());
  //   }
  // }

  // Future<void> registerToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   var user = FirebaseAuth.instance.currentUser;
  //   if (user != null && token != null) {
  //     await FirebaseFirestore.instance
  //         .collection('user_tokens')
  //         .doc(user.uid)
  //         .set({'token': token}, SetOptions(merge: true));
  //   }
  // }

  // void saveVerificationStatus(bool isVerified) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isVerified', isVerified);
  // }

  // void checkVerificationStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isVerified = prefs.getBool('isVerified') ?? false;
  //   if (isVerified) {
  //     print(
  //         "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Verified >>>>>>>>>>>>>>>>>>");
  //   } else {
  //     print(
  //         "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Not Verified >>>>>>>>>>>>>>>>>>");
  //   }
  // }

  // Future<void> logout() async {
  //   try {
  //     await clearSharedPreferences();
  //     await deleteUserToken();
  //     await FirebaseAuth.instance.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<void> clearSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.clear(); // This clears all data stored in SharedPreferences
  // }

  // Future<void> deleteUserToken() async {
  //   var user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     await FirebaseFirestore.instance
  //         .collection('user_tokens')
  //         .doc(user.uid)
  //         .delete();
  //   }
  // }
}
