import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/bloc/chat/chat_bloc.dart';
import '../../../../domain/bloc/chat/chat_event.dart';
import '../../../../domain/bloc/chat/chat_state.dart';
import '../../../commons/widget/data_error_widget.dart';
import '../../../commons/widget/data_loader_widget.dart';
import '../mapper/chat_messages_ui_mapper.dart';
import '../model/models.dart';
import '../widget/chat_message_widget.dart';
import '../widget/compose_message_widget.dart';

class ChatLayout extends StatefulWidget {
  final bool isEmbedded;

  const ChatLayout({
    required this.isEmbedded,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatLayout> createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(StartListeningToUpdates());
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        switch (state.status) {
          case ChatStatus.initial:
          case ChatStatus.loading:
            return const DataLoaderWidget();
          case ChatStatus.success:
            return _buildSuccessState(context, state);
          case ChatStatus.error:
            return DataErrorWidget(state.errorState!);
        }
      },
    );
  }

  Widget _buildSuccessState(
    BuildContext context,
    ChatState state,
  ) {
    final uiElements = ChatMessagesUiMapper.mapChatMessages(
      state.messages,
      widget.isEmbedded,
      state.currentUserId,
      context.read<ChatBloc>().chatUserId,
    );

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: uiElements.length,
            itemBuilder: (context, index) {
              return _buildListItem(context, uiElements[index]);
            },
            padding: const EdgeInsets.symmetric(vertical: 12.0),
          ),
        ),
        ComposeMessageWidget(
          isMessageSubmitInProgress: state.isMessageSubmitInProgress,
        )
      ],
    );
  }

  Widget _buildListItem(
    BuildContext context,
    ChatMessageUi message,
  ) {
    return ChatMessageWidget(
      message,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<ChatBloc>().add(StartListeningToUpdates());
    } else if (state == AppLifecycleState.paused) {
      context.read<ChatBloc>().add(StopListeningToUpdates());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
