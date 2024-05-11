import 'dart:io';
import 'package:ads_app/feature/Ads/cubit/ad_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AdCubit extends Cubit<AdState> {
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  static AdCubit get(context) => BlocProvider.of(context);

  AdCubit() : super(InitialAdState());

  Future<void> pickAndUploadAd(Ad ad) async {
    emit(AdLoadingState());
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        await uploadAdWithImage(ad, imageFile);
      } else {
        emit(AdErrorState("No image selected"));
      }
    } catch (e) {
      emit(AdErrorState(e.toString()));
    }
  }

  // Future<void> fetchAds() async {
  //   try {
  //     emit(InvestmentAdsLoading());
  //     // Fetch data from Firestore
  //     var adsCollection = FirebaseFirestore.instance.collection('ads');
  //     var snapshot = await adsCollection.get();
  //     var ads = snapshot.docs.map((doc) => doc.data()).toList();
  //     emit(InvestmentAdsSuccess());
  //     print(ads);
  //   } catch (e) {
  //     emit(InvestmentAdsError());
  //     print(e.toString());
  //   }
  // }

  Future<void> uploadAdWithImage(Ad ad, File file) async {
    try {
      String filePath =
          'ads_images/${DateTime.now().millisecondsSinceEpoch}_${ad.name}';
      TaskSnapshot snapshot = await _storage.ref(filePath).putFile(file);
      String imageUrl = await snapshot.ref.getDownloadURL();
      ad.imageUrl = imageUrl; // Update ad with imageUrl
      await createAd(ad); // Now create the ad in Firestore
    } catch (e) {
      emit(AdErrorState(e.toString()));
    }
  }

  Future<void> createAd(Ad ad) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('ads').add(ad.toMap());
      ad.id = docRef.id;
      emit(AdCreatedState(ad));
    } catch (e) {
      emit(AdErrorState(e.toString()));
    }
  }

  Future<List<Ad>> searchAds(String searchTerm) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('ads')
          .where('name', isEqualTo: searchTerm)
          .get();
      List<Ad> ads =
          snapshot.docs.map((doc) => Ad.fromMap(doc.data())).toList();
      return ads;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}

class Ad {
  String? id;
  String imageUrl;
  String name;
  String description;
  String salary;
  String email;
  String phone;
  String? additionalDetail1; // Optional additional detail 1
  String? additionalDetail2; // Optional additional detail 2

  Ad({
    this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.salary,
    required this.email,
    required this.phone,
    this.additionalDetail1,
    this.additionalDetail2,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'description': description,
      'salary': salary,
      'email': email,
      'phone': phone,
      'additionalDetail1': additionalDetail1,
      'additionalDetail2': additionalDetail2,
    };
  }

  factory Ad.fromMap(Map<String, dynamic> map) {
    return Ad(
      id: map['id'],
      imageUrl: map['imageUrl'],
      name: map['name'],
      description: map['description'],
      salary: map['salary'],
      email: map['email'],
      phone: map['phone'],
      additionalDetail1: map['additionalDetail1'],
      additionalDetail2: map['additionalDetail2'],
    );
  }
}
