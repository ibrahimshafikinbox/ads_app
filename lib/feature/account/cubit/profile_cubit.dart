import 'dart:async';
import 'dart:io';

import 'package:ads_app/feature/account/Model/profile_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileCubit extends Cubit<UserProfile?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<DocumentSnapshot>? _userSubscription;
  static UserProfileCubit get(context) => BlocProvider.of(context);

  UserProfileCubit() : super(null) {
    _authSubscription = _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        fetchUserProfile(user.uid);
      } else {
        emit(null); // No user logged in
      }
    });
  }
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(null); // Clear the user data from the Cubit
    } catch (e) {
      // Handle errors if any during the logout process
    }
  }

  void fetchUserProfile(String userId) {
    _userSubscription?.cancel();
    _userSubscription = _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        print(snapshot);
        emit(UserProfile.fromFirestore(snapshot));
      } else {
        emit(null); // No user data found or handle appropriately
      }
    }, onError: (error) => emit(null));
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    _userSubscription?.cancel();
    return super.close();
  }
}

class UserCubit extends Cubit<Map<String, dynamic>?> {
  UserCubit() : super(null);

  void getUser(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      emit(userDoc.data() as Map<String, dynamic>?);
    } catch (e) {
      emit(null); // In a real app, better error handling is needed
    }
  }

  void uploadProfileImage(String userId, File imageFile) async {
    try {
      String filePath =
          'profile_images/$userId/${DateTime.now().millisecondsSinceEpoch}';
      UploadTask task =
          FirebaseStorage.instance.ref().child(filePath).putFile(imageFile);

      task.snapshotEvents.listen((event) async {
        if (event.state == TaskState.success) {
          String downloadUrl = await event.ref.getDownloadURL();
          updateUser(userId, {'imageUrl': downloadUrl});
        }
      });
    } catch (e) {
      // Handle errors here
    }
  }

  void updateUser(String userId, Map<String, dynamic> newData) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update(newData);
      getUser(userId); // Refresh data
    } catch (e) {
      // Handle errors here
    }
  }
}
