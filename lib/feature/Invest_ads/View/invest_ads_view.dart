import 'package:ads_app/core/navigateion_helper.dart';
import 'package:ads_app/feature/Invest_ads/cubit/invest_ads_cubit.dart';
import 'package:ads_app/feature/Invest_ads/cubit/invest_ads_state.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvestAdsView extends StatefulWidget {
  const InvestAdsView({super.key});

  @override
  State<InvestAdsView> createState() => _InvestAdsViewState();
}

class _InvestAdsViewState extends State<InvestAdsView> {
  @override
  void initState() {
    super.initState();

    InvestAdsCubit.get(context).fetchAds();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          "Welcome , ${FirebaseAuth.instance.currentUser?.displayName ?? ""}",
          style: AppTextStyle.textStyleBoldBlack,
        ),
      ),
      body: BlocConsumer<InvestAdsCubit, InvestAdsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView(
            children: [
              SizedBox(
                child: BlocBuilder<InvestAdsCubit, InvestAdsState>(
                  builder: (context, state) {
                    if (state is InvestAdsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is InvestAdsLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.ads.length,
                        itemBuilder: (context, index) {
                          final ad = state.ads[index];
                          return Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Smart Investing",
                                        style: AppTextStyle.textStyleBoldBlack,
                                      ),
                                      Text(
                                        "Made Simple",
                                        style: AppTextStyle.textStyleBoldBlack,
                                      ),
                                      Text(
                                        "Start Investing Today ",
                                        style: AppTextStyle.textStyleBoldBlack,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppColors.grey,
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 70,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${ad.imageUrl}"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        AppSizedBox.sizedH10,
                                        Text(
                                          ad.name,
                                          style:
                                              AppTextStyle.textStyleBoldBlack,
                                        ),
                                        AppSizedBox.sizedH10,
                                        Text(
                                          "${ad.description} ",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                navigateTo(
                                                    context,
                                                    AdDetailsScreen(
                                                      ad: InvestAdsModel(
                                                          description:
                                                              ad.description,
                                                          name: ad.name,
                                                          imageUrl: ad.imageUrl,
                                                          salary: ad.salary,
                                                          email: ad.email,
                                                          phone: ad.phone),
                                                    ));
                                              },
                                              child: Text(
                                                "invest",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (state is InvestAdsError) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text("No ads available"));
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Investment Guide ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Basic Type of Investments",
                          style: TextStyle(
                              color: AppColors.textGray,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "There are long term and short term ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "investment, choose based on needs ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: AppColors.grey,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1631270315847-f418bde47ca6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGFkc3xlbnwwfHwwfHx8MA%3D%3D"),
                      radius: 35,
                    ),
                  ],
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How Much Money I need to start ? ",
                          style: TextStyle(
                              color: AppColors.textGray,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "actually you can start with any amount  ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "due to the variety of startups, ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: AppColors.grey,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1490529553037-4f4ed6f3f575?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGFkc3xlbnwwfHwwfHx8MA%3D%3D"),
                      radius: 35,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class AdDetailsScreen extends StatelessWidget {
  final InvestAdsModel ad;

  const AdDetailsScreen({required this.ad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ad.name,
              style: AppTextStyle.textStyleBoldBlack20,
            ),
            AppSizedBox.sizedH10,
            Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(ad.imageUrl), fit: BoxFit.cover)),
            ),
            AppSizedBox.sizedH15,
            Text(
              "Get to know about: ${ad.name}",
              style: AppTextStyle.textStyleBoldBlack,
            ),
            AppSizedBox.sizedH15,
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.black)),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  ad.description,
                  style: AppTextStyle.textStyleMediumAppBlack,
                ),
              ),
            ),
            AppSizedBox.sizedH10,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        " amount of funds requested ",
                        style: TextStyle(fontSize: 12),
                      ),
                      AppSizedBox.sizedH25,
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.black,
                            )),
                        child: Center(
                            child: Text(
                          " ${ad.salary}  EGP ",
                          style: AppTextStyle.textStyleBoldBlack,
                        )),
                      )
                    ],
                  ),
                ),
                AppSizedBox.sizedW50,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        "equity given for the ",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const Text(
                        "amount of funding",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      AppSizedBox.sizedH10,
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.black,
                            )),
                        child: const Center(
                            child: Text(
                          "5 %  ",
                          style: AppTextStyle.textStyleBoldBlack,
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSizedBox.sizedH25,
            const Text(
                "reach us on our business email or our business phone number"),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${ad.email ?? ""}",
                  style: AppTextStyle.textStyleBoldBlack,
                ),
              )),
            ),
            AppSizedBox.sizedH10,
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                  child: Text(
                "${ad.phone ?? ""}",
                style: AppTextStyle.textStyleBoldBlack,
              )),
            ),
            // Additional UI components here as needed
          ],
        ),
      ),
    );
  }
}
