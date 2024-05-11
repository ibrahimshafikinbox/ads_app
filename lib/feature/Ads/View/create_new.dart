import 'dart:io';

import 'package:ads_app/core/navigateion_helper.dart';
import 'package:ads_app/core/show_toast.dart';
import 'package:ads_app/feature/Ads/cubit/ad_state.dart';
import 'package:ads_app/feature/Auth/Widgtes/default_botton.dart';
import 'package:ads_app/feature/Ads/View/ads_View.dart';
import 'package:ads_app/feature/Ads/cubit/cubit.dart';
import 'package:ads_app/feature/layout/views/Home_View.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:ads_app/feature/resources/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewAd extends StatefulWidget {
  const CreateNewAd({super.key});

  @override
  State<CreateNewAd> createState() => _CreateNewAdState();
}

class _CreateNewAdState extends State<CreateNewAd> {
  var serviceDescribtionController = TextEditingController();
  var amountEgpController = TextEditingController();
  var serviceNameController = TextEditingController();
  var businessEmailController = TextEditingController();
  var buisinessPhoneController = TextEditingController();
  File? imageFile; // Variable to hold the picked image file

  // Function to pick an image
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdCubit, AdState>(
      listener: (context, state) {
        if (state is AdCreatedState) {
          showToast(text: "ad created Success", state: ToastStates.SUCCESS);
          navigateAndFinish(context, Home_View());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        )),
                  ],
                ),
                const Text(
                  "Enter Startup Information",
                  style: AppTextStyle.textStyleBoldBlack20,
                ),
                AppSizedBox.sizedH15,
                const Text(
                  'Add Photos of your Service or Project ',
                  style: AppTextStyle.textStyleBoldBlack,
                ),
                AppSizedBox.sizedH10,
                GestureDetector(
                  onTap:
                      pickImage, // Add functionality to pick the image when tapping
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.black26),
                    ),
                    child: imageFile == null
                        ? const Icon(Icons.add_a_photo, size: 50)
                        : Image.file(imageFile!, fit: BoxFit.cover),
                  ),
                ),
                AppSizedBox.sizedH10,
                const Text("Name of service or project"),
                TextField(
                  controller: serviceNameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                ),
                AppSizedBox.sizedH20,
                const Text("Description of service or project "),
                TextField(
                  controller: serviceDescribtionController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                ),
                AppSizedBox.sizedH20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "The amount of funds requested",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        AppSizedBox.sizedH25,
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: AppColors.grey)),
                            child: TextField(
                              controller: amountEgpController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '..... EGP',
                                hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                              ),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSizedBox.sizedW10,
                    Column(
                      children: [
                        const Text(
                          "The percentage of equity given ",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        const Text(
                          "for the amount of funding",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        AppSizedBox.sizedH10,
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: AppColors.grey)),
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '.......   %',
                                hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AppSizedBox.sizedH15,
                const Text("Business E-mail  "),
                TextField(
                  controller: businessEmailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                ),
                AppSizedBox.sizedH15,
                const Text("Business phone number  "),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: buisinessPhoneController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                ),
                AppSizedBox.sizedH10,
                DefaultButton(
                  function: () {
                    if (imageFile != null) {
                      // Ensure an image is selected
                      Ad ad = Ad(
                        imageUrl:
                            "", // Image URL will be set in the Cubit after uploading
                        name: serviceNameController.text,
                        description: serviceDescribtionController.text,
                        salary: amountEgpController.text,
                        email: businessEmailController.text,
                        phone: buisinessPhoneController.text,
                      );
                      AdCubit.get(context).uploadAdWithImage(
                          ad, imageFile!); // Use the imageFile
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please select an image first")));
                    }
                  },
                  text: "Create Ad",
                  textColor: Colors.white,
                  bottonColor: const Color.fromARGB(255, 158, 10, 13),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
