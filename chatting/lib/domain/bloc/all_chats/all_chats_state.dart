import 'package:chatting/commons/error_state.dart';
import 'package:equatable/equatable.dart';

import '../../../commons/cacheable.dart';
import '../../model/models.dart';

enum AllChatsStatus { initial, success, error, loading }

class AllChatsState extends Equatable {
  final AllChatsStatus status;
  final Cacheable<List<Chat>> chats;
  final ErrorState? errorState;

  const AllChatsState._({
    required this.status,
    required this.chats,
    required this.errorState,
  });

  const AllChatsState.initial()
      : status = AllChatsStatus.initial,
        chats = const Cacheable.remote([]),
        errorState = null;

  const AllChatsState.success(this.chats)
      : status = AllChatsStatus.success,
        errorState = null;

  const AllChatsState.error(this.errorState)
      : status = AllChatsStatus.error,
        chats = const Cacheable.remote([]);

  const AllChatsState.loading()
      : status = AllChatsStatus.loading,
        chats = const Cacheable.remote([]),
        errorState = null;

  @override
  List<Object?> get props => [status, chats];
}
