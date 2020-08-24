class Http_exception implements Exception {
  final String message;
  Http_exception(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}
