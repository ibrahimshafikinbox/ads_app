import 'package:ads_app/feature/Auth/cubit/verify_cubit/verfication_cubit.dart';
import 'package:ads_app/feature/Auth/cubit/verify_cubit/verfication_state.dart';
import 'package:flutter/material.dart';

import 'package:ads_app/feature/Auth/Widgtes/default_botton.dart';
import 'package:ads_app/feature/Auth/Widgtes/form_field.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyAccountView extends StatefulWidget {
  const VerifyAccountView({super.key});

  @override
  State<VerifyAccountView> createState() => _VerifyAccountViewState();
}

class _VerifyAccountViewState extends State<VerifyAccountView> {
  var oTPController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: AppColors.black,
              )),
        ),
        body: BlocConsumer<VerificationCubit, VerficationStates>(
          listener: (context, state) {
            if (state is VerifyAccountSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("OTP is verified")),
              );
            } else if (state is VerifyAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cannot verify account")),
              );
            } else if (state is SendOTPSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("OTP has been sent")),
              );
            } else if (state is SendOTPError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Oops, OTP send failed")),
              );
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                AppSizedBox.sizedH50,
                const Column(
                  children: [
                    Text(
                      "Verify Account ",
                      style: AppTextStyle.textStyleBoldBlack20,
                    ),
                  ],
                ),
                SizedBox(
                    height: 150,
                    child: Image.asset("assets/images/add-photo 2.png")),
                AppSizedBox.sizedH50,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultFormField(
                    controller: emailController,
                    type: TextInputType.visiblePassword,
                    label: " Email Adress  ",
                    hint: 'email@gmail.com',
                    // prefix: Icons.phone,
                    onValidate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Your email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultFormField(
                    controller: oTPController,
                    type: TextInputType.visiblePassword,
                    label: "OTP ",
                    hint: 'OTP',
                    // prefix: Icons.phone,
                    onValidate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter OTP';
                      }
                      return null;
                    },
                  ),
                ),
                DefaultButton(
                    function: () {
                      VerificationCubit.get(context)
                          .sendOTP(emailController.text);
                    },
                    text: "Resend Code",
                    textColor: AppColors.white,
                    bottonColor: Color.fromARGB(255, 158, 10, 13)),
                DefaultButton(
                    function: () {
                      VerificationCubit.get(context)
                          .verifyOTP(oTPController.text);
                    },
                    text: "Continue",
                    textColor: AppColors.white,
                    bottonColor: Color.fromARGB(255, 158, 10, 13)),
              ],
            );
          },
        ));
  }
}
