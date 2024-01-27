class UserAuthModel {
  final bool isNewUser;
  final String uid;
  final String phoneNumber;

  const UserAuthModel({
    required this.isNewUser,
    required this.uid,
    required this.phoneNumber,
  });
}
