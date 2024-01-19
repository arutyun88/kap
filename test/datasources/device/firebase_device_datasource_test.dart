import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kap/datasource/device/device_datasource.dart';
import 'package:kap/datasource/device/firebase_device_datasource.dart';
import 'package:kap/domain/exceptions/authorization_exception.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/domain/models/device_model/device_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../resources/test_const.dart';
import '../../resources/utils.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DeviceDatasource deviceDatasource;
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
    deviceDatasource = FirebaseDeviceDatasource.init(firebaseFirestore);
  });

  group('getDeviceByDeviceId tests', () {
    group('success tests', () {
      setUpAll(() {
        when(() => firebaseFirestore.collection(any())).thenReturn(collectionReference);
        when(() => collectionReference.doc(any())).thenReturn(documentReference);
        when(() => documentReference.get()).thenAnswer((_) async => documentSnapshot);
      });

      test('when device found by deviceId', () async {
        when(() => documentSnapshot.exists).thenReturn(true);
        when(() => documentSnapshot.data()).thenReturn(deviceInfo);

        final actualResult = await deviceDatasource.getDeviceByDeviceId();

        expect(actualResult, isA<DeviceModel>());
      });

      test('when device not found by deviceId', () async {
        when(() => documentSnapshot.exists).thenReturn(false);

        final actualResult = await deviceDatasource.getDeviceByDeviceId();

        expect(actualResult, null);
      });

      test('when device is null', () async {
        when(() => documentSnapshot.exists).thenReturn(true);
        when(() => documentSnapshot.data()).thenReturn(null);

        final actualResult = await deviceDatasource.getDeviceByDeviceId();

        expect(actualResult, null);
      });
    });

    group('failed tests', () {
      setUpAll(() {
        when(() => firebaseFirestore.collection(any())).thenReturn(collectionReference);
      });

      test('when document permission denied', () {
        when(() => collectionReference.doc(any())).thenThrow(FirebaseException(plugin: '', code: 'permission-denied'));

        expect(deviceDatasource.getDeviceByDeviceId, throwsA(isA<PermissionException>()));
      });

      test('when other firebase exception', () {
        when(() => collectionReference.doc(any())).thenReturn(documentReference);
        when(() => documentReference.get()).thenThrow(FirebaseException(plugin: ''));

        expect(deviceDatasource.getDeviceByDeviceId, throwsA(isA<DeviceGetException>()));
      });
    });
  });

  group('createDeviceFromPhoneNumber tests', () {
    final phoneNumber = deviceInfo['phone_number'] ?? '';

    group('success tests', () {
      test('when device created', () async {
        when(() => firebaseFirestore.collection(any())).thenReturn(collectionReference);
        when(() => collectionReference.doc(any())).thenReturn(documentReference);
        when(() => documentReference.set(any())).thenAnswer((_) => Future.value());

        await expectLater(deviceDatasource.createDeviceFromPhoneNumber(phoneNumber), isNot(isA<Exception>));
        verify(() => documentReference.set(any())).called(1);
      });
    });

    group('failed tests', () {
      test('when document permission denied', () async {
        when(() => firebaseFirestore.collection(any())).thenReturn(collectionReference);
        when(() => collectionReference.doc(any())).thenThrow(FirebaseException(plugin: '', code: 'permission-denied'));

        await expectLater(deviceDatasource.createDeviceFromPhoneNumber(phoneNumber), throwsA(isA<PermissionException>()));
        verifyNever(() => documentReference.set(any()));
      });

      test('when other firebase exception', () async {
        when(() => firebaseFirestore.collection(any())).thenReturn(collectionReference);
        when(() => collectionReference.doc(any())).thenReturn(documentReference);
        when(() => documentReference.set(any())).thenThrow(FirebaseException(plugin: ''));

        await expectLater(deviceDatasource.createDeviceFromPhoneNumber(phoneNumber), throwsA(isA<DeviceGetException>()));
        verify(() => documentReference.set(any())).called(1);
      });
    });
  });
}
