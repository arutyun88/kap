import 'package:kap/domain/exceptions/custom_exception.dart';

class AuthorizationException extends CustomException {
  const AuthorizationException(super.message);
}

class TimeoutException extends AuthorizationException {
  const TimeoutException(super.message);
}

class CodeException extends AuthorizationException {
  const CodeException(super.message);
}

class PermissionException extends AuthorizationException {
  const PermissionException(super.message);
}

class TooMachException extends AuthorizationException {
  const TooMachException(super.message);
}
