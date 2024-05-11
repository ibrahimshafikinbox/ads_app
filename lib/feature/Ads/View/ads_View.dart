import 'package:ads_app/core/navigateion_helper.dart';
import 'package:ads_app/feature/Ads/View/create_new.dart';
import 'package:ads_app/feature/Ads/cubit/cubit.dart';
import 'package:ads_app/feature/Ads/widgets/Build_item.dart';
import 'package:ads_app/feature/details/details.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdsListScreen extends StatelessWidget {
  Stream<QuerySnapshot> getAdsStream() {
    return FirebaseFirestore.instance.collection('ads').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSizedBox.sizedH50,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Welcome , ${FirebaseAuth.instance.currentUser?.displayName ?? ""}",
                  style: AppTextStyle.textStyleBoldBlack,
                ),
                Spacer(),
                TextButton(
                  child: Text("create Ad "),
                  onPressed: () {
                    navigateTo(context, CreateNewAd());
                  },
                )
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getAdsStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.data!.docs.isEmpty) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 300,
                    ),
                    const Center(
                      child: Text("ad list is empty ",
                          style: AppTextStyle.textStyleBoldBlack),
                    ),
                    Center(
                        child: TextButton(
                      onPressed: () {
                        navigateTo(context, CreateNewAd());
                      },
                      child: const Text(
                        "create new ad  ",
                      ),
                    )),
                  ],
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var adData = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    var ad = Ad.fromMap(adData);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdDetailsScreen(ad: ad),
                          ),
                        );
                      },
                      child: BuildItemCart(
                        image: ad.imageUrl,
                        describtion: ad.description,
                        profuctName: ad.name,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
