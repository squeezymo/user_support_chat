import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataLoaderWidget extends StatelessWidget {
  const DataLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(

      ),
    );
  }
}
