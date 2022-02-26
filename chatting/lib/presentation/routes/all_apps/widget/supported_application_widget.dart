import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class SupportedApplicationWidget extends StatelessWidget {
  final SupportedApplicationUi app;

  const SupportedApplicationWidget(
    this.app, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(16.0),
          child: Text(
            app.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const Divider(
          thickness: 1.0,
          height: 1.0,
          color: Colors.white24,
        )
      ],
    );
  }
}
