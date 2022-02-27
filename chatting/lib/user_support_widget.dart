library user_support;

import 'dart:convert';

import 'package:chatting/presentation/commons/channel/channel_utils.dart';
import 'package:chatting/presentation/commons/widget/data_error_widget.dart';
import 'package:chatting/presentation/routes/chat/page/chat_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatting/presentation/commons/widget/data_loader_widget.dart';
import 'package:chatting/presentation/routes/all_apps/page/all_apps_page.dart';

import 'commons/error_state.dart';
import 'data/chat_data_source.dart';
import 'domain/repository/chat_repository.dart';
import 'domain/repository/user_id_repository.dart';
import 'commons/platform.dart';
import 'firebase_options.dart';

class UserSupportWidget extends StatefulWidget {
  final String? firebaseAppName;
  final bool isEmbedded;

  const UserSupportWidget({
    required this.isEmbedded,
    required this.firebaseAppName,
    Key? key,
  }) : super(key: key);

  @override
  State<UserSupportWidget> createState() => _UserSupportWidgetState();
}

class _UserSupportWidgetState extends State<UserSupportWidget> {
  String? _appId;
  String _platform = 'android';
  String _appVersion = '1.0';
  String _supportId = 'SUPPORT';

  @override
  void initState() {
    super.initState();
    UserSupportChannel.init();
    UserSupportChannel.addListener(
      "setData",
      (call) => _setData(call.arguments as String),
    );
  }

  @override
  void dispose() {
    UserSupportChannel.removeListener("setData");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFirebaseApp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final appId = _appId;

          if (widget.isEmbedded) {
            if (appId == null) {
              return _createApp(
                context,
                const DataLoaderWidget(),
              );
            } else {
              return _createAppWithProviders(
                context,
                snapshot.data as FirebaseApp,
                ChatPage(
                  appId,
                  null,
                  isEmbedded: widget.isEmbedded,
                ),
              );
            }
          } else {
            return _createAppWithProviders(
              context,
              snapshot.data as FirebaseApp,
              AllAppsPage(
                isEmbedded: widget.isEmbedded,
              ),
            );
          }
        }

        if (snapshot.hasError) {
          return _createApp(
            context,
            DataErrorWidget(
              ErrorState.fromObject(
                snapshot.error,
              ),
            ),
          );
        }

        return _createApp(
          context,
          const DataLoaderWidget(),
        );
      },
    );
  }

  Future<FirebaseApp> _initFirebaseApp() {
    return Firebase.initializeApp(
      name: widget.firebaseAppName,
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> _setData(String jsonString) async {
    Map<String, dynamic> data = jsonDecode(jsonString);

    setState(() {
      _appId = data["appId"];
      _platform = data["platform"];
      _appVersion = data["appVersion"];
      _supportId = data["supportId"];
    });
  }

  Widget _createAppWithProviders(
    BuildContext context,
    FirebaseApp firebaseApp,
    Widget home,
  ) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserIdRepository>(
          create: (context) => const UserIdRepository(),
        ),
        RepositoryProvider<ChatRepository>(
          create: (context) => ChatRepository(
            dataSource: ChatDataSource(
              platform: _platform,
              appVersion: _appVersion,
              supportId: _supportId,
              firebaseApp: firebaseApp,
            ),
          ),
        ),
      ],
      child: _createApp(
        context,
        home,
      ),
    );
  }

  Widget _createApp(BuildContext context, Widget home) {
    if (AppEnvironment.designSystem == AppDesignSystem.material) {
      return _createMaterialApp(context, home);
    } else {
      return _createCupertinoApp(context, home);
    }
  }

  Widget _createMaterialApp(BuildContext context, Widget home) {
    return MaterialApp(
      title: 'Support',
      theme: _createMaterialTheme(context),
      home: home,
    );
  }

  Widget _createCupertinoApp(BuildContext context, Widget home) {
    return CupertinoApp(
      home: home,
      theme: MaterialBasedCupertinoThemeData(
        materialTheme: _createMaterialTheme(context),
      ),
    );
  }

  ThemeData _createMaterialTheme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.grey,
      splashColor: getBackgroundColor(),
      scaffoldBackgroundColor: getBackgroundColor(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 36, 33, 36),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: TextTheme(
        headlineSmall: const TextStyle().apply(color: Colors.white),
        headlineMedium: const TextStyle().apply(color: Colors.white),
        titleSmall: const TextStyle().apply(color: Colors.white),
        titleMedium: const TextStyle().apply(color: Colors.white),
        titleLarge: const TextStyle().apply(color: Colors.white),
        bodySmall: const TextStyle().apply(color: Colors.white60),
        bodyMedium: const TextStyle().apply(color: Colors.white),
        bodyLarge: const TextStyle().apply(color: Colors.white),
      ),
      cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: const TextStyle().apply(color: Colors.white),
        ),
      ),
    );
  }

  Color getBackgroundColor() {
    if (widget.isEmbedded && _appId == "Filch") {
      return Colors.black;
    }

    return const Color.fromARGB(255, 26, 23, 28);
  }
}
