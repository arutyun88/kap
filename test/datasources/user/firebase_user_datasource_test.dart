import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kap/datasource/user/firebase_user_datasource.dart';
import 'package:kap/datasource/user/user_datasource.dart';
import 'package:kap/domain/exceptions/authorization_exception.dart';
import 'package:kap/domain/exceptions/user_exception.dart';
import 'package:kap/domain/models/user_model/user_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../resources/test_const.dart';
import '../../resources/utils.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late UserDatasource userDatasource;
  late FirebaseFirestore firebaseFirestore;
  late CollectionReference<Map<String, dynamic>> collectionReference;
  late DocumentReference<Map<String, dynamic>> documentReference;
  late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

  setUpAll(() async {
    await utilSetUp();

    collectionReference = MockCollectionReference();
    documentReference = MockDocumentReference();
    documentSnapshot = MockDocumentSnapshot();
    firebaseFirestore = MockFirebaseFirestore();
    userDatasource = FirebaseUserDatasource.init(firebaseFirestore);
  });

  group('getUserByUid tests', () {
    group('success tests', () {
      setUpAll(() {
        when(() => firebaseFirestore.collection(any())).thenReturn(collectionReference);
        when(() => collectionReference.doc(any())).thenReturn(documentReference);
        when(() => documentReference.get()).thenAnswer((_) async => documentSnapshot);
      });

      test('when user found by uid', () async {
        when(() => documentSnapshot.exists).thenReturn(true);
        when(() => documentSnapshot.data()).thenReturn(userInfo);

        final actual = await userDatasource.getUserByUid('uid');

        expect(actual, isA<UserModel>());
        expect(actual.uid, userInfo['uid']);
      });

      test('when user not found by uid', () async {
        when(() => documentSnapshot.exists).thenReturn(false);

        expect(userDatasource.getUserByUid('uid'), throwsA(isA<UserNotFoundException>()));
      });
    });

    group('failed tests', () {
      setUpAll(() {
        when(() => firebaseFirestore.collection(any())).thenReturn(collectionReference);
      });

      test('when document permission denied', () {
        when(() => collectionReference.doc(any())).thenThrow(FirebaseException(plugin: '', code: 'permission-denied'));

        expect(userDatasource.getUserByUid('uid'), throwsA(isA<PermissionException>()));
      });
    });
  });
}
