import 'package:ads_app/feature/Auth/views/login.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppSizedBox.sizedH100,
          SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/images/splash_logo.png")),
          AppSizedBox.sizedH25,
          const Text(
            "Invest In Your Future ",
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 25),
          ),
          AppSizedBox.sizedH100,
          AppSizedBox.sizedH100,
          const Text(
            "Best App To Transform ",
            style: AppTextStyle.textStyleBoldBlack,
          ),
          AppSizedBox.sizedH10,
          const Text("Small Investment to bigger ones ",
              style: AppTextStyle.textStyleBoldBlack)
        ],
      ),
    );
  }
}
