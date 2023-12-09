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

class FakeDuration extends Fake implements Duration {}
