import 'package:ads_app/feature/Ads/cubit/cubit.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class AdDetailsScreen extends StatelessWidget {
  final Ad ad;

  const AdDetailsScreen({required this.ad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${ad.name ?? ""}",
              style: AppTextStyle.textStyleBoldBlack20,
            ),
            AppSizedBox.sizedH10,
            Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(ad.imageUrl), fit: BoxFit.fill)),
            ),
            AppSizedBox.sizedH15,
            Text(
              "Get to know about :  ${ad.name ?? ""}  ",
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
                  "${ad.description ?? ""}",
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
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class AdDetailsView extends StatefulWidget {
//   const AdDetailsView({super.key});

//   @override
//   State<AdDetailsView> createState() => _AdDetailsViewState();
// }

// class _AdDetailsViewState extends State<AdDetailsView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AppSizedBox.sizedH50,
//             const Text(
//               "E-cars maadi company",
//               style: AppTextStyle.textStyleBoldBlack,
//             ),
//             Container(
//               height: 200,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage("assets/images/image 1.png"))),
//             ),
//             const Text(
//               "Get to know about E-cars maadi ",
//               style: AppTextStyle.textStyleBoldBlack,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(color: AppColors.black)),
//               child: const Padding(
//                 padding: EdgeInsets.all(15.0),
//                 child: Text(
//                     "E-cars maadi is a car assembly startup, we are trying to introduce to the Egyptian market the concept of eco friendly and luxuries sport cars, we are expecting a huge revenue in the upcoming years but this depends on us expanding worldwide this is why we are asking for funding so we can upgrade our production and marketing strategies."),
//               ),
//             ),
//             AppSizedBox.sizedH10,
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       const Text(
//                         " amount of funds requested ",
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       AppSizedBox.sizedH10,
//                       Container(
//                         height: 50,
//                         width: MediaQuery.of(context).size.width / 3,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: AppColors.black,
//                             )),
//                         child: const Center(
//                             child: Text(
//                           "3 M EGP ",
//                           style: AppTextStyle.textStyleBoldBlack,
//                         )),
//                       )
//                     ],
//                   ),
//                 ),
//                 const Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       const Text(
//                         "equity given for amount ",
//                         style: TextStyle(
//                           fontSize: 12,
//                         ),
//                       ),
//                       AppSizedBox.sizedH10,
//                       Container(
//                         height: 50,
//                         width: MediaQuery.of(context).size.width / 3,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: AppColors.black,
//                             )),
//                         child: const Center(
//                             child: Text(
//                           "5 %  ",
//                           style: AppTextStyle.textStyleBoldBlack,
//                         )),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             AppSizedBox.sizedH25,
//             Text("reach us on our business email or our business phone number"),
//             Container(
//               width: MediaQuery.of(context).size.width / 2,
//               height: 40,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.black),
//               ),
//               child: const Center(
//                   child: Text(
//                 "email@gmail.com",
//                 style: AppTextStyle.textStyleBoldBlack,
//               )),
//             ),
//             AppSizedBox.sizedH10,
//             Container(
//               width: MediaQuery.of(context).size.width / 2,
//               height: 40,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.black),
//               ),
//               child: const Center(
//                   child: Text(
//                 "011016839520",
//                 style: AppTextStyle.textStyleBoldBlack,
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
