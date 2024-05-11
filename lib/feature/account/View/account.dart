import 'package:ads_app/core/navigateion_helper.dart';
import 'package:ads_app/feature/Auth/cubit/Login_cubit/login_cubit.dart';
import 'package:ads_app/feature/Auth/views/verfiy.dart';
import 'package:ads_app/feature/Splash/splash_view.dart';
import 'package:ads_app/feature/account/Model/profile_model.dart';
import 'package:ads_app/feature/account/View/contact_info.dart';
import 'package:ads_app/feature/account/cubit/profile_cubit.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountView extends StatefulWidget {
  AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    print(FirebaseAuth.instance.currentUser?.uid);
    UserProfileCubit.get(context)
        .fetchUserProfile("${FirebaseAuth.instance.currentUser?.uid}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit(),
      child: Scaffold(
        body: BlocBuilder<UserProfileCubit, UserProfile?>(
          builder: (context, userProfile) {
            if (userProfile == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                AppSizedBox.sizedH50,
                buildUserProfile(context, userProfile),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget buildUserProfile(BuildContext context, UserProfile user) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Profile ", style: AppTextStyle.textStyleBoldBlack20),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              UserProfileCubit.get(context).fetchUserProfile(
                  "${FirebaseAuth.instance.currentUser?.uid}");
            },
          )
        ],
      ),
      AppSizedBox.sizedH30,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("${user.imageUrl}"),
            radius: 50,
          ),
        ],
      ),
      AppSizedBox.sizedH10,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${user.name}",
            style: AppTextStyle.textStyleBoldBlack,
          ),
        ],
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("investor ", style: AppTextStyle.textStyleMediumBlack),
        ],
      ),
      AppSizedBox.sizedH50,
      Material(
        elevation: 4,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                const Icon(Icons.contact_emergency),
                AppSizedBox.sizedW20,
                const Text("Contact Info"),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      navigateTo(context, ContactInfoPage());
                    },
                    child: Icon(Icons.arrow_forward_ios_rounded))
              ],
            ),
          ),
        ),
      ),
      AppSizedBox.sizedH25,
      GestureDetector(
        onTap: () async {
          await LoginCubit.get(context).logOut();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SplashScreen()),
              (Route<dynamic> route) => false);
        },
        child: Material(
          elevation: 4,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(Icons.logout),
                  AppSizedBox.sizedW20,
                  Text("Log Out"),
                ],
              ),
            ),
          ),
        ),
      ),
      AppSizedBox.sizedH25,
      GestureDetector(
        onTap: () {
          navigateTo(context, VerifyAccountView());
        },
        child: Material(
          elevation: 4,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(Icons.verified),
                  AppSizedBox.sizedW20,
                  Text("Verify Account"),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
          ),
        ),
      ),
    ]),
  );
}
