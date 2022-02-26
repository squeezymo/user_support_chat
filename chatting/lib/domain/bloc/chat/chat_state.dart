import 'package:chatting/commons/error_state.dart';
import 'package:equatable/equatable.dart';

import '../../../commons/cacheable.dart';
import '../../model/models.dart';

enum ChatStatus { initial, success, error, loading }

class ChatState extends Equatable {
  final String currentUserId;
  final ChatStatus status;
  final Cacheable<List<ChatMessage>> messages;
  final bool isMessageSubmitInProgress;
  final ErrorState? errorState;

  const ChatState._({
    required this.currentUserId,
    required this.status,
    required this.messages,
    required this.isMessageSubmitInProgress,
    required this.errorState,
  });

  const ChatState.initial()
      : currentUserId = "",
        status = ChatStatus.initial,
        messages = const Cacheable.remote([]),
        isMessageSubmitInProgress = false,
        errorState = null;

  const ChatState.success(
      this.currentUserId,
    this.messages,
    this.isMessageSubmitInProgress,
  )   : status = ChatStatus.success,
        errorState = null;

  const ChatState.error(this.currentUserId, this.errorState,)
      : status = ChatStatus.error,
        messages = const Cacheable.remote([]),
        isMessageSubmitInProgress = false;

  const ChatState.loading(this.currentUserId,)
      : status = ChatStatus.loading,
        messages = const Cacheable.remote([]),
        isMessageSubmitInProgress = false,
        errorState = null;

  @override
  List<Object?> get props => [status, messages, isMessageSubmitInProgress];

}
