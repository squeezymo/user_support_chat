import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../commons/platform.dart';

class IconButtonFactory {
  static Widget create({
    Key? key,
    required Widget icon,
    required VoidCallback? onPressed,
    String? tooltip,
  }) {
    if (AppEnvironment.designSystem == AppDesignSystem.material) {
      return IconButton(
        icon: icon,
        tooltip: tooltip,
        onPressed: onPressed,
      );
    } else {
      return CupertinoButton(
        child: icon,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      );
    }
  }
}
