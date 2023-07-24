import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:kap/config/firebase_options.dart';

class FirebaseService extends GetxService {
  FirebaseService._(this.firebaseApp, this.database);

  static Future<void> init() async {
    final app = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    final database = FirebaseDatabase.instanceFor(
      app: app,
      databaseURL: 'https://kap-kayk-default-rtdb.europe-west1.firebasedatabase.app',
    );
    Get.lazyPut(() => FirebaseService._(app, database));
  }

  final FirebaseApp firebaseApp;
  final FirebaseDatabase database;

  static FirebaseService to = Get.find<FirebaseService>();
}
