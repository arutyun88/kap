import 'package:kap/services/environment_service.dart';
import 'package:kap/services/localization_service.dart';

abstract class SettingsService {
  const SettingsService._();

  static final environment = EnvironmentService.to.environment;
  static final localization = LocalizationService.to;
}
