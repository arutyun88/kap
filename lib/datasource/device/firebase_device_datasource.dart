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
    } on Exception catch (e) {
      throw _exception(e, 'getDeviceByDeviceId');
    }
  }

  @override
  Future<void> createDeviceFromPhoneNumber(String phoneNumber) async {
    final id = await _deviceId;
    try {
      await _firebaseFirestore.collection('devices').doc(id).set(
            DeviceModel(id: id, platform: _platform, phoneNumber: phoneNumber).toJson(),
          );
    } on Exception catch (e) {
      throw _exception(e, 'createDeviceFromPhoneNumber');
    }
  }

  Exception _exception(Exception exception, String methodName) {
    if (exception is FirebaseException) {
      final message = 'FirebaseDeviceDatasource: $methodName: ${exception.runtimeType}: ${exception.message}';
      if (exception.code == 'permission-denied') {
        return PermissionException(message);
      } else {
        return DeviceGetException(message);
      }
    } else {
      return exception;
    }
  }
}
