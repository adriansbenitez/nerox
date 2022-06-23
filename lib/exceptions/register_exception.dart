class RegisterException implements Exception {
  late final String message;

  RegisterException(message) {
    this.message = message;
  }
}
