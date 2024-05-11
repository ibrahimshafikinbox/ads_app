import 'package:ads_app/feature/Invest_ads/View/invest_ads_view.dart';
import 'package:ads_app/feature/account/View/account.dart';
import 'package:ads_app/feature/Ads/View/ads_View.dart';
import 'package:ads_app/feature/layout/cubit/status.dart';
import 'package:ads_app/feature/search/search.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    InvestAdsView(),
    AdsListScreen(),
    FilterPage(),
    AccountView(),
  ];

  List<String> titles = [
    'Home',
    'Search',
    'Account ',
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
}
