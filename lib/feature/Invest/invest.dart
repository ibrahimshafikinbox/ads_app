import 'package:ads_app/core/navigateion_helper.dart';
import 'package:ads_app/feature/Auth/Widgtes/default_botton.dart';
import 'package:ads_app/feature/Ads/View/create_new.dart';
import 'package:ads_app/feature/layout/views/Home_View.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class InvestView extends StatefulWidget {
  const InvestView({super.key});

  @override
  State<InvestView> createState() => _InvestViewState();
}

class _InvestViewState extends State<InvestView> {
  var oTPController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        AppSizedBox.sizedH50,
        const Column(
          children: [
            Text(
              "Invest in startups ",
              style: AppTextStyle.textStyleBoldBlack20,
            ),
          ],
        ),
        Image.asset("assets/images/image 1.png"),
        AppSizedBox.sizedH50,
        DefaultButton(
            function: () {
              navigateAndFinish(context, Home_View());
            },
            text: "Start as an Investor",
            textColor: AppColors.white,
            bottonColor: const Color.fromARGB(255, 158, 10, 13)),
        DefaultButton(
            function: () {
              navigateAndFinish(context, CreateNewAd());
            },
            text: "Start as Startup Owner",
            textColor: AppColors.white,
            bottonColor: const Color.fromARGB(255, 158, 10, 13)),
      ],
    ));
  }
}
