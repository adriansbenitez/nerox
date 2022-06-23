class AuthenticationException implements Exception {
  late final String message;

  AuthenticationException(message) {
    this.message = message;
  }
}
