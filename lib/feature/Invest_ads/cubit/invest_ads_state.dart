import 'package:ads_app/feature/Invest_ads/cubit/invest_ads_cubit.dart';

abstract class InvestAdsState {
  const InvestAdsState();

  @override
  List<Object> get props => [];
}

class InvestAdsLoading extends InvestAdsState {}

class InvestAdsLoaded extends InvestAdsState {
  final List<InvestAdsModel> ads; // Ensure this field is defined correctly

  const InvestAdsLoaded(this.ads);

  @override
  List<Object> get props => [ads];
}

class InvestAdsError extends InvestAdsState {
  final String message;

  const InvestAdsError(this.message);

  @override
  List<Object> get props => [message];
}
