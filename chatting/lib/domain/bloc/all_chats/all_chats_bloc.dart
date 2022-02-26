import 'dart:async';
import 'dart:ffi';

import 'package:chatting/commons/error_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/chat_repository.dart';
import 'all_chats_event.dart';
import 'all_chats_state.dart';

class AllChatsBloc extends Bloc<AllChatsEvent, AllChatsState> {
  AllChatsBloc({
    required this.appId,
    required ChatRepository repository,
  })  : _chatRepository = repository,
        super(
          const AllChatsState.initial(),
        ) {
    on<StartListeningToUpdates>(_startListeningToUpdates);
    on<StopListeningToUpdates>(_stopListeningToUpdates);
    on<DeleteChat>(_deleteChat);
  }

  final String appId;
  final ChatRepository _chatRepository;
  StreamSubscription? _subscription;

  void _startListeningToUpdates(
    StartListeningToUpdates event,
    Emitter<AllChatsState> emit,
  ) async {
    emit(const AllChatsState.loading());
    await _resubscribeToChats(emit);
  }

  void _stopListeningToUpdates(
    StopListeningToUpdates event,
    Emitter<AllChatsState> emit,
  ) async {
    await _subscription?.cancel();
  }

  Future<void> _resubscribeToChats(
    Emitter<AllChatsState> emit,
  ) async {
    final unsubscribe = _subscription?.cancel() ?? Future<void>.value(Void);
    final newSubscription = _chatRepository.getChats(appId).listen(
      (chats) {
        emit(
          AllChatsState.success(
            chats,
          ),
        );
      },
      onError: (err) {
        _subscription = null;
        emit(
          AllChatsState.error(
            ErrorState.fromException(
              err,
            ),
          ),
        );
      },
      onDone: () {
        _subscription = null;
      },
      cancelOnError: true,
    );

    _subscription = newSubscription;

    return unsubscribe.then((value) => newSubscription.asFuture());
  }

  void _deleteChat(
    DeleteChat event,
    Emitter<AllChatsState> emit,
  ) async {
    await _chatRepository.deleteChat(appId, event.chatUserId);
  }
}
