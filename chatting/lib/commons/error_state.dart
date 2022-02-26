class ErrorState {
  final String text;

  ErrorState.fromObject(Object? obj) : text = _extractErrorText(obj);

  ErrorState.fromException(Exception ex)
      : text = _extractErrorTextFromException(ex);

  static String _extractErrorText(Object? obj) {
    switch (obj?.runtimeType) {
      case Exception:
        return _extractErrorTextFromException(obj as Exception);
      case Error:
        return _extractErrorTextFromError(obj as Error);
      default:
        return _extractErrorTextFromUnknownObject(obj);
    }
  }

  static String _extractErrorTextFromException(Exception ex) {
    return ex.toString();
  }

  static String _extractErrorTextFromError(Error err) {
    return err.toString();
  }

  static String _extractErrorTextFromUnknownObject(Object? obj) {
    return "Unknown error (${obj?.runtimeType.toString()})";
  }
}
