import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../domain/bloc/all_chats/all_chats_bloc.dart';
import '../../../../domain/bloc/all_chats/all_chats_event.dart';
import '../../../../domain/bloc/all_chats/all_chats_state.dart';
import '../../../commons/navigation/platform_specific/platform_page_route.dart';
import '../../../commons/widget/data_error_widget.dart';
import '../../../commons/widget/data_loader_widget.dart';
import '../../../commons/widget/platform_specific/platform_ink_well.dart';
import '../../chat/page/chat_page.dart';
import '../../user_info/page/user_info_page.dart';
import '../mapper/chats_ui_mapper.dart';
import '../models/models.dart';
import '../widget/chat_widget.dart';

class AllChatsLayout extends StatefulWidget {
  final bool isEmbedded;

  const AllChatsLayout({
    Key? key,
    required this.isEmbedded,
  }) : super(key: key);

  @override
  State<AllChatsLayout> createState() => _AllChatsLayoutState();
}

class _AllChatsLayoutState extends State<AllChatsLayout>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    context.read<AllChatsBloc>().add(StartListeningToUpdates());
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllChatsBloc, AllChatsState>(
      builder: (context, state) {
        switch (state.status) {
          case AllChatsStatus.initial:
          case AllChatsStatus.loading:
            return const DataLoaderWidget();
          case AllChatsStatus.success:
            return _buildSuccessState(context, state);
          case AllChatsStatus.error:
            return DataErrorWidget(state.errorState!);
        }
      },
    );
  }

  Widget _buildSuccessState(
    BuildContext context,
    AllChatsState state,
  ) {
    final uiElements = ChatUiMapper.mapChats(state.chats);

    return ListView.builder(
      itemCount: uiElements.length,
      itemBuilder: (context, index) {
        return _buildListItem(context, uiElements[index]);
      },
      padding: const EdgeInsets.symmetric(vertical: 12.0),
    );
  }

  Widget _buildListItem(BuildContext context, ChatUi chat) {
    return Slidable(
      key: ValueKey(chat.userId),
      child: InkWellFactory.create(
        child: ChatWidget(chat),
        onTap: () => _openChat(context, chat.userId),
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: (_) => _openUserInfo(context, chat.userId),
            backgroundColor: Colors.white24,
            foregroundColor: Colors.white,
            icon: Icons.history,
            label: 'Инфо', // TODO Localize
          ),
          SlidableAction(
            onPressed: (_) => _confirmChatDeletion(context, chat.userId),
            backgroundColor: const Color.fromARGB(255, 228, 25, 84),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить', // TODO Localize
          ),
        ],
      ),
    );
  }

  void _openChat(BuildContext context, String userId) {
    Navigator.push(
      context,
      PlatformPageRouteFactory.create(
        builder: (routeContext) => ChatPage(
          context.read<AllChatsBloc>().appId,
          userId,
          isEmbedded: widget.isEmbedded,
        ),
      ),
    );
  }

  void _openUserInfo(BuildContext context, String userId) {
    Navigator.push(
      context,
      PlatformPageRouteFactory.create(
        builder: (routeContext) => UserInfoPage(
          context.read<AllChatsBloc>().appId,
          userId,
          isEmbedded: widget.isEmbedded,
        ),
      ),
    );
  }

  void _confirmChatDeletion(BuildContext context, String userId) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      message: "Удалить чат?",
      isDestructiveAction: true,
    );

    if (result == OkCancelResult.ok) {
      _deleteChat(context, userId);
    }
  }

  void _deleteChat(BuildContext context, String userId) {
    context.read<AllChatsBloc>().add(DeleteChat(userId));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<AllChatsBloc>().add(StartListeningToUpdates());
    } else if (state == AppLifecycleState.paused) {
      context.read<AllChatsBloc>().add(StopListeningToUpdates());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
