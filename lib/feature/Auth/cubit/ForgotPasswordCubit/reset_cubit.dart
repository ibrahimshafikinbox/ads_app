import 'package:ads_app/feature/Auth/cubit/ForgotPasswordCubit/reset_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStatus> {
  ForgotPasswordCubit() : super(ForgotPasswordStatus.initial);

  Future<void> changePassword(String oldPassword, String newPassword) async {
    emit(ForgotPasswordStatus.loading);
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && newPassword.isNotEmpty) {
      // Re-authenticate the user with the old password
      AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!, password: oldPassword);

      try {
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        emit(ForgotPasswordStatus.success);
      } catch (error) {
        if (error is FirebaseAuthException && error.code == 'wrong-password') {
          emit(ForgotPasswordStatus.oldPasswordWrong);
        } else {
          emit(ForgotPasswordStatus.failure);
        }
      }
    } else {
      emit(ForgotPasswordStatus.failure);
    }
  }
}
