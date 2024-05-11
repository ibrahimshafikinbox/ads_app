import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String? name;
  final String? email;
  final String? number;
  final String? imageUrl;

  UserProfile(
      {required this.uid, this.name, this.email, this.number, this.imageUrl});

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserProfile(
      uid: doc.id,
      name: data['name'] as String?,
      email: data['email'] as String?,
      number: data['number'] as String?,
      imageUrl: data['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name ?? '',
      'email': email ?? '',
      'number': number ?? '',
      'imageUrl': imageUrl ?? '',
    };
  }
}
