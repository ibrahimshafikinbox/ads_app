import 'package:ads_app/feature/Ads/cubit/cubit.dart';

abstract class AdState {}

class InitialAdState extends AdState {}

class AdLoadingState extends AdState {}

// class InvestmentAdsLoading extends AdState {}

// class InvestmentAdsSuccess extends AdState {}

// class InvestmentAdsError extends AdState {}

class AdCreatedState extends AdState {
  final Ad ad;
  AdCreatedState(this.ad);
}

class AdErrorState extends AdState {
  final String error;
  AdErrorState(this.error);
}
