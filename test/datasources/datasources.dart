import 'localization/firebase_localization_datasource_test.dart' as firebase_localization_datasource;
import 'localization/hive_localization_datasource_test.dart' as hive_localization_datasource;
import 'authorization/firebase_authorization_datasource_test.dart' as firebase_authorization_datasource;
import 'device/firebase_device_datasource_test.dart' as firebase_device_datasource_test;

main() {
  firebase_localization_datasource.main();
  hive_localization_datasource.main();
  firebase_authorization_datasource.main();
  firebase_device_datasource_test.main();
}