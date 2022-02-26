import 'package:flutter/material.dart';

import '../model/models.dart';

class UserFlowEventWidget extends StatelessWidget {
  final UserFlowEventUi event;

  const UserFlowEventWidget(
    this.event, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      child: Text(
        event.message,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
