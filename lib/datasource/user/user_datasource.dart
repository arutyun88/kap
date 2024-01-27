import 'package:kap/domain/models/user_model/user_model.dart';

abstract interface class UserDatasource {
  Future<UserModel> getUserByUid(String uid);
}
