import 'package:flutter/services.dart';

class UserSupportChannel {
  static const _nativeToFlutter =
      MethodChannel('me.squeezymo.channel/user_support/native_to_flutter');
  static const flutterToNative =
      MethodChannel('me.squeezymo.channel/user_support/flutter_to_native');

  static void init() {
    _nativeToFlutter.setMethodCallHandler((call) {
      final listener = _listeners[call.method];
      if (listener == null) {
        throw Exception("No listener registered for method ${call.method}");
      }
      return listener(call);
    });
  }

  static final _listeners =
      <String, Future<dynamic> Function(MethodCall call)>{};

  static void addListener(
    String method,
    Future<dynamic> Function(MethodCall call) handler,
  ) {
    _listeners[method] = handler;
  }

  static void removeListener(
    String method,
  ) {
    _listeners.remove(method);
  }
}
