import 'package:chatting/user_support_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const UserSupportWidget(
      isEmbedded: true,
      firebaseAppName: "chatting",
    ),
  );
}
