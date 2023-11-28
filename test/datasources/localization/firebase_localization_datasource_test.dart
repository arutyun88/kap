import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kap/config/environment.dart';
import 'package:kap/datasource/localization/firebase_localization_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/services/environment_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../resources/test_const.dart';
import '../../resources/utils.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FirebaseLocalizationDatasource firebaseLocalizationDatasource;
  late FirebaseDatabase firebaseDatabase;
  late DatabaseReference databaseReference;

  setUp(() async {
    await utilSetUp();
    await EnvironmentService.init(Environment.dev);

    firebaseDatabase = MockFirebaseDatabase();
    databaseReference = MockDatabaseReference();
    firebaseLocalizationDatasource = FirebaseLocalizationDatasource(firebaseDatabase: firebaseDatabase);
  });

  group('getData tests', () {
    test('getData returns data from Firebase', () async {
      when(() => firebaseDatabase.ref(any())).thenAnswer((_) => databaseReference);
      when(() => databaseReference.get()).thenAnswer((_) => Future.value(MockDataSnapshot(firebaseSnapshotData)));

      final data = await firebaseLocalizationDatasource.getData();

      expect(data, firebaseSnapshotData);
      verify(() => firebaseDatabase.ref(any())).called(1);
      verify(() => databaseReference.get()).called(1);
    });

    test('getData throws FirebaseException', () async {
      when(() => firebaseDatabase.ref(any())).thenThrow(FirebaseException(plugin: ''));

      expect(firebaseLocalizationDatasource.getData, throwsA(isA<LocalizationDataGettingException>()));
      verify(() => firebaseDatabase.ref(any())).called(1);
      verifyNever(() => databaseReference.get());
    });

    test('getData throws other Exception', () async {
      when(() => firebaseDatabase.ref(any())).thenThrow(Exception());

      expect(firebaseLocalizationDatasource.getData, throwsA(isNot(isA<LocalizationDataGettingException>())));
      verify(() => firebaseDatabase.ref(any())).called(1);
      verifyNever(() => databaseReference.get());
    });
  });
}
