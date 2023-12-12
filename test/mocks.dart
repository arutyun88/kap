import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kap/datasource/localization/local_localization_datasource.dart';
import 'package:kap/datasource/localization/localization_datasource.dart';
import 'package:kap/repositories/localization_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteLocalizationDatasource extends Mock implements LocalizationDatasource {}

class MockLocalLocalizationDatasource extends Mock implements LocalLocalizationDatasource {}

class MockLocalizationRepository extends Mock implements LocalizationRepository {}

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

class MockDataSnapshot extends Mock implements DataSnapshot {
  @override
  final dynamic value;

  MockDataSnapshot(this.value);
}

class MockDatabaseReference extends Mock implements DatabaseReference {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}

class FakeDuration extends Fake implements Duration {}

class MockUserCredential extends Mock implements UserCredential {}

class FakeAuthCredential extends Fake implements AuthCredential {}

class FakeFirebaseUser extends Fake implements User {
  @override
  String get uid => 'some_uid';
}
