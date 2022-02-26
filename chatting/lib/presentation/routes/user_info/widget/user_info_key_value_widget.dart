import 'package:flutter/material.dart';

import '../model/models.dart';

class UserInfoKeyValueWidget extends StatelessWidget {
  final UserInfoKeyValueUi keyValue;

  const UserInfoKeyValueWidget(
    this.keyValue, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            keyValue.caption,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            keyValue.label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
