import 'package:ads_app/core/navigateion_helper.dart';
import 'package:ads_app/core/show_toast.dart';
import 'package:ads_app/feature/Auth/Widgtes/default_botton.dart';
import 'package:ads_app/feature/Auth/Widgtes/form_field.dart';
import 'package:ads_app/feature/Auth/cubit/Sign_Up_cubit/signUp_states.dart';
import 'package:ads_app/feature/Auth/cubit/Sign_Up_cubit/sign_up_cubit.dart';
import 'package:ads_app/feature/Auth/views/login.dart';
import 'package:ads_app/feature/Auth/views/reset_pass.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpStates>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          showToast(text: "Create Account Success", state: ToastStates.SUCCESS);
        }
        if (state is SignUpErrorState) {
          showToast(text: "faild to create account ", state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: ListView(
          children: [
            AppSizedBox.sizedH50,
            const Column(
              children: [
                Text(
                  "Create  your Account ",
                  style: AppTextStyle.textStyleBoldBlack20,
                ),
                Text("Invest and double your income now"),
              ],
            ),
            AppSizedBox.sizedH50,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultFormField(
                controller: nameController,
                type: TextInputType.visiblePassword,
                label: " name  ",
                hint: 'name',
                // prefix: Icons.phone,
                onValidate: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Your name';
                  }
                  return null;
                },
              ),
            ),
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
              child: passwordFormField(
                controller: passwordController,
                type: TextInputType.visiblePassword,
                label: "password",
                hint: '********************',
                suffix: SignUpCubit.get(context).suffix,
                isPassword: SignUpCubit.get(context).isPassword,
                prefix: Icons.lock_outline,
                suffixPressed: () {
                  SignUpCubit.get(context).changePasswordVisibility();
                },
                onValidate: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '  enter Your Password';
                  }
                  return null;
                },
              ),
            ),
            DefaultButton(
                function: () {
                  SignUpCubit.get(context).signUpWithEmailAndPassword(
                    emailController.text,
                    passwordController.text,
                    nameController.text,
                  );
                },
                text: "Sign-Up",
                textColor: AppColors.white,
                bottonColor: AppColors.red),
            TextButton(
                onPressed: () {
                  navigateAndFinish(context, const LoginView());
                },
                child: const Text("Already have account ? ")),
            TextButton(
                onPressed: () {
                  navigateTo(context, ForgotPassword());
                },
                child: const Text(
                  'Forgotten my Password ?',
                  style: AppTextStyle.textStyleBoldBlack,
                )),
            AppSizedBox.sizedH40,
            DefaultButtonwithIcon(
                function: () {
                  SignUpCubit.get(context).signInWithGoogle();
                },
                text: "Sign in with Google",
                textColor: Colors.black,
                bottonColor: Colors.white,
                image: "assets/images/Group.png"),
            DefaultButtonwithIcon(
                function: () {},
                text: "Sign in with apple",
                textColor: Colors.black,
                bottonColor: Colors.white,
                image: "assets/images/Logo.png"),
          ],
        ));
      },
    );
  }
}
