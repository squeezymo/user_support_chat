import 'package:flutter/material.dart';

import '../model/models.dart';

class UserInfoSectionWidget extends StatelessWidget {
  final UserInfoSectionUi section;

  const UserInfoSectionWidget(this.section, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 16.0,
        right: 8.0,
      ),
      child: Text(
        section.title,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
