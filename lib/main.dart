import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import "package:chatting/user_support_widget.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SupportApp());
}

class SupportApp extends StatelessWidget {
  const SupportApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const UserSupportWidget(
      isEmbedded: false,
      firebaseAppName: null,
    );
  }
}
