library;

import '../core/_core.dart';

part 'net_resp_exception.dart';

/// Base class for all all client-side errors that can be generated by the app
sealed class AppException implements Exception {
  const AppException(this.code, this.message);

  final String message;
  final int code;

  // TODO watchout with this App strings map, modify accordingly whether to use localization or not.
  @override
  String toString() => APP_STRINGS[message] ?? "ERROR";

  // To use translation third party would be just:
  // @override
  // Future<String> toString() async => await translate(APP_STRINGS[message] ?? "ERROR");

  // To use hardcoded localization would be:
  // @override
  // String toString() => message.tr();

  @override
  bool operator ==(covariant AppException other) {
    if (identical(this, other)) return true;

    return other.message == message && other.code == code;
  }

  @override
  int get hashCode {
    return message.hashCode ^ code.hashCode;
  }
}

class UnknownException extends AppException {
  const UnknownException() : super(-1, 'unknown_error');
}

class CustomException extends AppException {
  const CustomException(this._msg) : super(-2, _msg);
  // ignore: unused_field
  final String _msg;
}

/// Might you wonder why this is not network response exception, the reason is because this
/// kind of exception happen client-side.
class NoConnectionException extends AppException {
  const NoConnectionException() : super(-3, 'no_internet_connection');
}

class EmailAlreadyInUseException extends AppException {
  const EmailAlreadyInUseException() : super(-4, 'email-already-in-use');
}

class UpdateCheckException extends AppException {
  // Update check failed. Please try again later.
  const UpdateCheckException() : super(-5, 'update_check_failed');
}

// TODO expand this, and figure the messageKey to messageStr, and support for localization.
