import 'package:kap/services/environment_service.dart';

abstract class SettingsService {
  const SettingsService._();

  static final environment = EnvironmentService.to.environment;
}
