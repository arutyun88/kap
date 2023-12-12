import 'package:kap/domain/models/device_model/device_model.dart';

abstract interface class DeviceDatasource {
  Future<void> createDeviceFromPhoneNumber(String phoneNumber);

  Future<DeviceModel?> getDeviceByDeviceId();
}
