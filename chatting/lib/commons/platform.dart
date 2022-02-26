import 'dart:io';

enum AppPlatform { iOS, macOS, android, fuchsia, linux, windows }

enum AppDesignSystem { material, cupertino }

class AppEnvironment {
  static AppPlatform platform = _platform();

  static AppDesignSystem designSystem = _designSystem(platform);

  static AppPlatform _platform() {
    if (Platform.isIOS) {
      return AppPlatform.iOS;
    }

    if (Platform.isMacOS) {
      return AppPlatform.macOS;
    }

    if (Platform.isAndroid) {
      return AppPlatform.android;
    }

    if (Platform.isFuchsia) {
      return AppPlatform.fuchsia;
    }

    if (Platform.isLinux) {
      return AppPlatform.linux;
    }

    if (Platform.isWindows) {
      return AppPlatform.windows;
    }

    throw Exception('Undefined platform');
  }

  static AppDesignSystem _designSystem(AppPlatform platform) {
    switch (platform) {
      case AppPlatform.iOS:
      case AppPlatform.macOS:
        return AppDesignSystem.cupertino;
      case AppPlatform.android:
      case AppPlatform.fuchsia:
      case AppPlatform.linux:
      case AppPlatform.windows:
        return AppDesignSystem.material;
    }
  }
}
