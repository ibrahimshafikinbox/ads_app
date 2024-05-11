import 'package:ads_app/core/navigateion_helper.dart';
import 'package:ads_app/core/show_toast.dart';
import 'package:ads_app/feature/Auth/Widgtes/default_botton.dart';
import 'package:ads_app/feature/Auth/Widgtes/form_field.dart';
import 'package:ads_app/feature/Auth/cubit/Login_cubit/Login_states.dart';
import 'package:ads_app/feature/Auth/cubit/Login_cubit/login_cubit.dart';
import 'package:ads_app/feature/Auth/views/sign_Up.dart';
import 'package:ads_app/feature/Invest/invest.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          showToast(text: "Logged in Success", state: ToastStates.SUCCESS);
          navigateTo(context, const InvestView());
        }
        if (state is LoginErrorState) {
          showToast(text: "faild to login ", state: ToastStates.ERROR);
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
                  "Login Account ",
                  style: AppTextStyle.textStyleBoldBlack20,
                ),
                Text("Invest and double your income now"),
              ],
            ),
            AppSizedBox.sizedH50,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultFormField(
                controller: emailController,
                type: TextInputType.visiblePassword,
                label: " Email Adress  ",
                hint: 'user@gmail.com',
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
                suffix: LoginCubit.get(context).suffix,
                isPassword: LoginCubit.get(context).isPassword,
                prefix: Icons.lock_outline,
                suffixPressed: () {
                  LoginCubit.get(context).changePasswordVisibility();
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
                  LoginCubit.get(context).logInWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                      nameController.text);
                },
                text: "Login",
                textColor: AppColors.white,
                bottonColor: AppColors.red),
            TextButton(
                onPressed: () {
                  navigateTo(context, const SignUpView());
                },
                child: const Text("Create Account  ? ")),
            DefaultButtonwithIcon(
              function: () {
                LoginCubit.get(context).signInWithGoogle();
              },
              text: "Sign in with Google",
              textColor: Colors.black,
              bottonColor: Colors.white,
              image: "assets/images/Group.png",
            ),
            DefaultButtonwithIcon(
                function: () {},
                text: "Sign in with apple",
                textColor: Colors.black,
                bottonColor: Colors.white,
                image: "assets/images/Logo.png"),
            AppSizedBox.sizedH40,
          ],
        ));
      },
    );
  }
}
