import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kap/datasource/device/device_datasource.dart';
import 'package:kap/domain/exceptions/custom_exception.dart';
import 'package:kap/domain/models/device_model/device_model.dart';
import 'package:platform_device_id/platform_device_id.dart';

class FirebaseDeviceDatasource implements DeviceDatasource {
  final FirebaseFirestore _firebaseFirestore;
  final _platform = Platform.isAndroid ? 'android' : 'ios';

  static FirebaseDeviceDatasource? _instance;

  static Future<String> get _deviceId async => (await PlatformDeviceId.getDeviceId) ?? '';

  FirebaseDeviceDatasource._(this._firebaseFirestore);

  factory FirebaseDeviceDatasource.init(FirebaseFirestore firebaseFirestore) {
    _instance ??= FirebaseDeviceDatasource._(firebaseFirestore);
    return _instance!;
  }

  @override
  Future<DeviceModel?> getDeviceByDeviceId() async {
    try {
      final result = await _firebaseFirestore.collection('devices').doc(await _deviceId).get();

      if (result.exists && result.data() != null) {
        final device = DeviceModel.fromJson(result.data()!);
        if (device.platform == _platform) {
          return device;
        }
      }
      return null;
    } on FirebaseException catch (e) {
      final message = 'FirebaseDeviceDatasource: ${e.runtimeType}: ${e.message}';
      if (e.code == 'permission-denied') {
        throw PermissionException(message);
      } else {
        throw DeviceGetException(message);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createDeviceFromPhoneNumber(String phoneNumber) {
    // TODO: implement createDeviceFromPhoneNumber
    throw UnimplementedError();
  }
}
