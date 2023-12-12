import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_model.freezed.dart';

part 'device_model.g.dart';

@freezed
class DeviceModel with _$DeviceModel {
  const factory DeviceModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'platform') required String platform,
    @JsonKey(name: 'phone_number') required String phoneNumber,
  }) = _DeviceModel;

  factory DeviceModel.fromJson(Map<String, dynamic> json) => _$DeviceModelFromJson(json);
}
