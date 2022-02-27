import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../commons/platform.dart';

class PlatformPageRouteFactory {
  static PageRoute create({
    required WidgetBuilder builder,
    String? title,
  }) {
    if (AppEnvironment.designSystem == AppDesignSystem.material) {
      return MaterialPageRoute(
        builder: builder,
      );
    } else {
      return CupertinoPageRoute(
        builder: builder,
        title: title,
      );
    }
  }
}
