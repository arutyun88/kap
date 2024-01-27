import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kap/datasource/user/user_datasource.dart';
import 'package:kap/domain/exceptions/authorization_exception.dart';
import 'package:kap/domain/exceptions/user_exception.dart';
import 'package:kap/domain/models/user_model/user_model.dart';

class FirebaseUserDatasource implements UserDatasource {
  final FirebaseFirestore _firebaseFirestore;
  static FirebaseUserDatasource? _instance;

  FirebaseUserDatasource._(this._firebaseFirestore);

  factory FirebaseUserDatasource.init(FirebaseFirestore firebaseFirestore) {
    _instance ??= FirebaseUserDatasource._(firebaseFirestore);
    return _instance!;
  }

  @override
  Future<UserModel> getUserByUid(String uid) async {
    try {
      final result = await _firebaseFirestore.collection('users').doc(uid).get();
      if (!result.exists) throw UserNotFoundException();
      final user = UserModel.fromJson(result.data()!);
      return user;
    } on Exception catch (e) {
      throw _exception(e);
    }
  }

  Exception _exception(Exception exception) {
    if (exception is FirebaseException && exception.code == 'permission-denied') {
      return PermissionException('FirebaseUserDatasource: ${exception.runtimeType}: ${exception.message}');
    } else {
      return exception;
    }
  }
}
