import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commons/error_state.dart';
import '../../../../domain/bloc/chat/chat_bloc.dart';
import '../../../../domain/repository/chat_repository.dart';
import '../../../../domain/repository/user_id_repository.dart';
import '../../../commons/navigation/platform_specific/platform_page_route.dart';
import '../../../commons/widget/data_error_widget.dart';
import '../../../commons/widget/data_loader_widget.dart';
import '../../../commons/widget/platform_specific/platform_icon_button.dart';
import '../../../commons/widget/platform_specific/platform_scaffold.dart';
import '../../user_info/page/user_info_page.dart';
import 'chat_layout.dart';

class ChatPage extends StatelessWidget {
  final String appId;
  final String? userId;
  final bool isEmbedded;

  const ChatPage(
    this.appId,
    this.userId, {
    Key? key,
    required this.isEmbedded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userId == null
          ? context.read<UserIdRepository>().getUserId()
          : Future.value(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildChatLayoutWithProviders(
            context,
            snapshot.data as String,
          );
        }

        if (snapshot.hasError) {
          return _buildChatLayout(
            context,
            null,
            DataErrorWidget(
              ErrorState.fromObject(
                snapshot.error,
              ),
            ),
          );
        }

        return _buildChatLayout(
          context,
          null,
          const DataLoaderWidget(),
        );
      },
    );
  }

  Widget _buildChatLayoutWithProviders(BuildContext context, String userId) {
    return BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(
        appId: appId,
        chatUserId: userId,
        userIdRepository: context.read<UserIdRepository>(),
        chatRepository: context.read<ChatRepository>(),
      ),
      child: _buildChatLayout(
        context,
        userId,
        ChatLayout(
          isEmbedded: isEmbedded,
        ),
      ),
    );
  }

  Widget _buildChatLayout(BuildContext context, String? userId, Widget body) {
    return ScaffoldFactory.create(
      context,
      title: "Чат",
      // TODO Localize
      body: body,
      actions: [
        if (userId != null) _buildUserFlowAction(context, userId),
      ],
      isEmbedded: isEmbedded,
    );
  }

  Widget _buildUserFlowAction(BuildContext context, String userId) {
    return IconButtonFactory.create(
      icon: const Icon(Icons.history),
      tooltip: 'Инфо', // TODO Localize
      onPressed: () => _openUserInfo(context, userId),
    );
  }

  void _openUserInfo(BuildContext context, String userId) {
    Navigator.push(
      context,
      PlatformPageRouteFactory.create(
        builder: (routeContext) => UserInfoPage(
          appId,
          userId,
          isEmbedded: isEmbedded,
        ),
      ),
    );
  }
}
