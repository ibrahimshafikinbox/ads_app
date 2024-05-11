class UserModel {
  final String uid;
  final String email;
  final String name;
  final String imageUrl;
  final String token;

  UserModel(
      {required this.uid,
      required this.email,
      this.name = '',
      this.imageUrl = '',
      this.token = ''});

  // Add a method to convert the model to a map, which is useful for uploading data to Firebase Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'token': token,
    };
  }
}
