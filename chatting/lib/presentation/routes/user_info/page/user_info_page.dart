import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatting/presentation/routes/user_info/page/user_info_layout.dart';

import '../../../../domain/bloc/user_info/user_info_bloc.dart';
import '../../../../domain/bloc/user_info/user_info_event.dart';
import '../../../../domain/repository/chat_repository.dart';
import '../../../commons/widget/platform_specific/platform_scaffold.dart';

class UserInfoPage extends StatelessWidget {
  final String appId;
  final String userId;
  final bool isEmbedded;

  const UserInfoPage(
    this.appId,
    this.userId, {
    Key? key,
    required this.isEmbedded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldFactory.create(
      context,
      title: "О пользователе", // TODO Localize
      body: _buildBody(context),
      isEmbedded: isEmbedded,
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider<UserInfoBloc>(
      create: (context) => UserInfoBloc(
        appId: appId,
        repository: context.read<ChatRepository>(),
      )..add(GetUserInfo(userId)),
      child: UserInfoLayout(),
    );
  }
}
