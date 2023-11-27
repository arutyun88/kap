abstract class CustomException {
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
