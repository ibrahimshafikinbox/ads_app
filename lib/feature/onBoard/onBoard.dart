import 'package:ads_app/feature/Auth/Widgtes/default_botton.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({super.key});

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppSizedBox.sizedH100,
          SizedBox(
            height: 300,
            width: 400,
            child: Image.asset(
              "assets/images/3d-stripy-savings-1@2x.png",
            ),
          ),
          AppSizedBox.sizedH20,
          const Text(
            'Stay on top of your finance with us.',
            style: AppTextStyle.textStyleBoldBlack20,
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "We are your new financial Advisorsto recommed the best investments for you.",
                  style: AppTextStyle.textStyleMediumAppBlack,
                ),
              ],
            ),
          ),
          DefaultButton(
              function: () {},
              text: "Create Account",
              textColor: AppColors.white,
              bottonColor: AppColors.red),
          DefaultButton(
              function: () {},
              text: "Login",
              textColor: AppColors.red,
              bottonColor: AppColors.white)
        ],
      ),
    );
  }
}
