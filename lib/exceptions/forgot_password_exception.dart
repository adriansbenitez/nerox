class ForgotPasswordException implements Exception {
  late final String message;

  ForgotPasswordException(message) {
    this.message = message;
  }
}
