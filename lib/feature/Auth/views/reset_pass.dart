// import 'package:ads_app/feature/Auth/Widgtes/default_botton.dart';
// import 'package:ads_app/feature/Auth/Widgtes/form_field.dart';
// import 'package:ads_app/feature/Auth/cubit/ForgotPasswordCubit/reset_cubit.dart';
// import 'package:ads_app/feature/Auth/cubit/ForgotPasswordCubit/reset_states.dart';
// import 'package:ads_app/feature/resources/colors/colors.dart';
// import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
// import 'package:ads_app/feature/resources/styles/app_text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ResetpasswordView extends StatelessWidget {
//   final TextEditingController oldPasswordController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmNewPasswordController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => ForgotPasswordCubit(),
//         child: BlocListener<ForgotPasswordCubit, ForgotPasswordStatus>(
//           listener: (context, state) {
//             if (state == ForgotPasswordStatus.success) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Password successfully updated")));
//             } else if (state == ForgotPasswordStatus.oldPasswordWrong) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Old password is incorrect")));
//             } else if (state == ForgotPasswordStatus.failure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Failed to update password")));
//             }
//           },
//           child: ListView(
//             children: [
//               AppSizedBox.sizedH50,
//               const Column(
//                 children: [
//                   Text(
//                     "Reset password ",
//                     style: AppTextStyle.textStyleBoldBlack20,
//                   ),
//                 ],
//               ),
//               AppSizedBox.sizedH100,
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: DefaultFormField(
//                   controller: oldPasswordController,
//                   type: TextInputType.visiblePassword,
//                   label: "old password",
//                   hint: '**********',
//                   // prefix: Icons.phone,
//                   onValidate: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter Your Password';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: DefaultFormField(
//                   controller: newPasswordController,
//                   type: TextInputType.visiblePassword,
//                   label: "  new password ",
//                   hint: '  new password',
//                   // prefix: Icons.phone,
//                   onValidate: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return 'please enter  new password';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               DefaultButton(
//                   function: () {
//                     if (newPasswordController.text ==
//                         confirmNewPasswordController.text) {
//                       BlocProvider.of<ForgotPasswordCubit>(context)
//                           .changePassword(oldPasswordController.text,
//                               newPasswordController.text);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text("Passwords do not match")));
//                     }
//                   },
//                   text: "confirm",
//                   textColor: AppColors.white,
//                   bottonColor: Color.fromARGB(255, 158, 10, 13)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:ads_app/feature/Auth/Widgtes/default_botton.dart';
import 'package:ads_app/feature/Auth/Widgtes/form_field.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:flutter/material.dart';

import 'package:email_otp/email_otp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // var nameController = TextEditingController();
  // var mailController = TextEditingController();
  // var confirmPassController = TextEditingController();
  // var codeController = TextEditingController();
  // var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  EmailOTP emailOTP = EmailOTP();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              AppSizedBox.sizedH15,

              Text(
                "Reset password ",
                style: AppTextStyle.textStyleBoldBlack20,
              ),
              AppSizedBox.sizedH15,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultFormField(
                  controller: emailController,
                  type: TextInputType.visiblePassword,
                  label: "email ",
                  hint: 'email',
                  // prefix: Icons.phone,
                  onValidate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'field is required ';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultFormField(
                  controller: otpController,
                  type: TextInputType.visiblePassword,
                  label: "OTP Code  ",
                  hint: 'OTP Code ',
                  // prefix: Icons.phone,
                  onValidate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'field is required ';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultFormField(
                  controller: newPasswordController,
                  type: TextInputType.visiblePassword,
                  label: "new Password ",
                  hint: '************',
                  // prefix: Icons.phone,
                  onValidate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'field is required ';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultFormField(
                  controller: confirmNewPasswordController,
                  type: TextInputType.visiblePassword,
                  label: "confirm new  Password ",
                  hint: '*******',
                  // prefix: Icons.phone,
                  onValidate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'field is required ';
                    }
                    return null;
                  },
                ),
              ),
              AppSizedBox.sizedH20,
              DefaultButton(
                function: () async {
                  emailOTP.setConfig(
                      appEmail: "me@rohitchouhan.com",
                      appName: "Email OTP",
                      userEmail: emailController.text,
                      otpLength: 6,
                      otpType: OTPType.digitsOnly);
                  if (await emailOTP.sendOTP() == true) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("OTP has been sent"),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Oops, OTP send failed"),
                    ));
                  }
                },
                text: "Send OTP",
                textColor: AppColors.white,
                bottonColor: AppColors.red,
              ),
              // ElevatedButton(

              //     child: const Text("Send OTP")),

              DefaultButton(
                function: () async {
                  if (await emailOTP.verifyOTP(otp: otpController.text) ==
                      true) {
                    if (newPasswordController.text ==
                        confirmNewPasswordController.text) {
                      // Implement your password reset logic here
                      // Update the user's password in your database
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Password has been reset successfully"),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Passwords do not match"),
                      ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Invalid OTP"),
                    ));
                  }
                },
                text: 'Confirm  ',
                textColor: AppColors.white,
                bottonColor: AppColors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
