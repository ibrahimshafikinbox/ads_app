import 'package:ads_app/feature/Auth/cubit/ForgotPasswordCubit/reset_cubit.dart';
import 'package:ads_app/feature/Auth/cubit/Login_cubit/login_cubit.dart';
import 'package:ads_app/feature/Auth/cubit/Sign_Up_cubit/sign_up_cubit.dart';
import 'package:ads_app/feature/Auth/cubit/verify_cubit/verfication_cubit.dart';
import 'package:ads_app/feature/Invest_ads/cubit/invest_ads_cubit.dart';
import 'package:ads_app/feature/Splash/splash_view.dart';
import 'package:ads_app/feature/account/cubit/profile_cubit.dart';
import 'package:ads_app/feature/Ads/cubit/cubit.dart';
import 'package:ads_app/feature/layout/cubit/cubit.dart';
import 'package:ads_app/feature/layout/views/Home_View.dart';
import 'package:flutter/material.dart';
import 'package:ads_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => ForgotPasswordCubit()),
        BlocProvider(create: (context) => AdCubit()),
        BlocProvider(create: (context) => UserProfileCubit()),
        BlocProvider(create: (context) => InvestAdsCubit()),
        BlocProvider(create: (context) => VerificationCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // home: CreateNewAd(),
        home: isLoggedIn ? Home_View() : SplashScreen(),
      ),
    );
  }
}
