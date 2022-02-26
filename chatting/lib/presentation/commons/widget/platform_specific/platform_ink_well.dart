import 'package:flutter/material.dart';

import '../../../../commons/platform.dart';

class InkWellFactory {
  static Widget create({
    Key? key,
    required Widget child,
    GestureTapCallback? onTap,
  }) {
    if (AppEnvironment.designSystem == AppDesignSystem.material) {
      return InkWell(
        child: child,
        onTap: onTap,
      );
    } else {
      return GestureDetector(
        child: child,
        onTap: onTap,
      );
    }
  }
}
