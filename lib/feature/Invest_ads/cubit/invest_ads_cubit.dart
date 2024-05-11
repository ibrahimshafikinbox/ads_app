import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ads_app/feature/Invest_ads/cubit/invest_ads_state.dart';

class InvestAdsCubit extends Cubit<InvestAdsState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static InvestAdsCubit get(context) => BlocProvider.of(context);
  InvestAdsCubit() : super(InvestAdsLoading());

  void fetchAds() async {
    emit(InvestAdsLoading());
    try {
      var adsCollection = firestore.collection('investment_ads');
      var snapshot = await adsCollection.get();
      var ads = snapshot.docs
          .map((doc) => InvestAdsModel.fromMap(doc.data()))
          .toList();
      print(ads.length);
      emit(InvestAdsLoaded(ads));
    } catch (e) {
      print(e.toString());
      emit(InvestAdsError(e.toString()));
    }
  }
}

class InvestAdsModel {
  final String imageUrl;
  final String name;
  final String description;
  String salary;
  String email;
  String phone;

  InvestAdsModel({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.salary,
    required this.email,
    required this.phone,
  });

  factory InvestAdsModel.fromMap(Map<String, dynamic> map) {
    return InvestAdsModel(
      imageUrl: map['ad_image'],
      name: map['name'],
      description: map['ad_description'],
      salary: map['salary'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}
