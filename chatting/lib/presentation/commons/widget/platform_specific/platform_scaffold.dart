import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../commons/platform.dart';

class ScaffoldFactory {
  static Widget create(
    BuildContext context, {
    Key? key,
    String? title,
    List<Widget>? actions,
    required Widget body,
    required bool isEmbedded,
  }) {
    if (AppEnvironment.designSystem == AppDesignSystem.material) {
      return Scaffold(
        key: key,
        appBar: isEmbedded
            ? null
            : AppBar(
                title: title == null ? null : Text(title),
                actions: actions,
                titleTextStyle: Theme.of(context).textTheme.titleLarge,
              ),
        body: body,
      );
    } else {
      return CupertinoPageScaffold(
        key: key,
        navigationBar: isEmbedded
            ? null
            : CupertinoNavigationBar(
                automaticallyImplyLeading: true,
                backgroundColor: Colors.white10,
                // previousPageTitle: "TODO",
                middle: title == null
                    ? null
                    : Text(
                        title,
                        style: const TextStyle().apply(color: Colors.blue),
                      ),
                trailing: actions == null
                    ? null
                    : Wrap(
                        alignment: WrapAlignment.end,
                        children: actions,
                      ),
              ),
        child: SafeArea(
          child: body,
        ),
      );
    }
  }
}
