abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final Map<String, dynamic> userData;
  UserProfileLoaded(this.userData);
}

class UserProfileUpdated extends UserProfileState {}

class UserProfileError extends UserProfileState {
  final String message;
  UserProfileError(this.message);
}
