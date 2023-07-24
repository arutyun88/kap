import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:kap/config/firebase_options.dart';

class FirebaseService extends GetxService {
  FirebaseService._(this.firebaseApp);

  static Future<void> init() async {
    final app = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    Get.lazyPut(() => FirebaseService._(app));
  }

  final FirebaseApp firebaseApp;

  static FirebaseService to = Get.find<FirebaseService>();
}
