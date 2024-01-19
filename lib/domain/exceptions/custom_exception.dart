abstract class CustomException implements Exception {
  final String message;

  const CustomException(this.message);
}

abstract class LocalizationException extends CustomException {
  const LocalizationException(super.message);
}

class LocalizationVersionCheckException extends LocalizationException implements Exception {
  const LocalizationVersionCheckException(super.message);
}

class LocalizationDataGettingException extends LocalizationException implements Exception {
  const LocalizationDataGettingException(super.message);
}

class DeviceGetException extends CustomException {
  const DeviceGetException(super.message);
}

class DeviceAlreadyUseException extends CustomException {
  const DeviceAlreadyUseException(super.message);
}
