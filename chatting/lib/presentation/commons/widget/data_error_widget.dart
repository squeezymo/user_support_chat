import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../commons/error_state.dart';

class DataErrorWidget extends StatelessWidget {
  final ErrorState state;

  const DataErrorWidget(
    this.state, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          state.text,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
