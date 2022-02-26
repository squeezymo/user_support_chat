import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:chatting/commons/error_state.dart';
import 'package:chatting/domain/model/models.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/commons/channel/channel_utils.dart';
import '../../repository/chat_repository.dart';
import '../../repository/user_id_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required this.appId,
    required this.chatUserId,
    required UserIdRepository userIdRepository,
    required ChatRepository chatRepository,
  })  : _userIdRepository = userIdRepository,
        _chatRepository = chatRepository,
        super(const ChatState.initial()) {
    on<StartListeningToUpdates>(_startListeningToUpdates);
    on<StopListeningToUpdates>(_stopListeningToUpdates);
    on<SubmitNewMessage>(_submitNewMessage);

    UserSupportChannel.addListener(
      "sendUserFlow",
      (call) => _sendUserFlow(call.arguments as String),
    );
  }

  final String appId;
  final String? chatUserId;
  final UserIdRepository _userIdRepository;
  final ChatRepository _chatRepository;
  bool _isStarted = false;
  bool _hasRequestedUserFlow = false;
  StreamSubscription? _subscription;

  void _startListeningToUpdates(
    StartListeningToUpdates event,
    Emitter<ChatState> emit,
  ) async {
    final userId = await _userIdRepository.getUserId();
    emit(ChatState.loading(userId));
    await _resubscribeToChats(emit);
    _isStarted = true;
  }

  void _stopListeningToUpdates(
    StopListeningToUpdates event,
    Emitter<ChatState> emit,
  ) async {
    await _subscription?.cancel();
    _isStarted = false;
  }

  void _submitNewMessage(
    SubmitNewMessage event,
    Emitter<ChatState> emit,
  ) async {
    final userId = await _userIdRepository.getUserId();
    await _chatRepository.addMessage(
      event.message,
      appId: appId,
      userId: userId,
      chatUserId: chatUserId,
    );
    if (!_hasRequestedUserFlow) {
      UserSupportChannel.flutterToNative.invokeMethod("requestUserFlow");
      _hasRequestedUserFlow = true;
    }
    if (_isStarted && _subscription == null) {
      await _resubscribeToChats(emit);
    }
  }

  Future<void> _resubscribeToChats(
    Emitter<ChatState> emit,
  ) async {
    final unsubscribe = _subscription?.cancel() ?? Future<void>.value(Void);

    if (chatUserId == null) {
      return unsubscribe;
    }

    final userId = await _userIdRepository.getUserId();
    final newSubscription =
        _chatRepository.getMessages(appId, chatUserId ?? userId).listen(
      (messages) {
        emit(
          ChatState.success(
            userId,
            messages,
            state.isMessageSubmitInProgress,
          ),
        );
      },
      onError: (ex) {
        _subscription = null;
        emit(ChatState.error(
          userId,
          ErrorState.fromException(
            ex,
          ),
        ));
      },
      onDone: () {
        _subscription = null;
      },
      cancelOnError: true,
    );

    _subscription = newSubscription;

    return unsubscribe.then((value) => newSubscription.asFuture());
  }

  Future<void> _sendUserFlow(String jsonString) async {
    List<Map<String, dynamic>> data = jsonDecode(jsonString);

    try {
      await _chatRepository.sendUserFlow(data.map((event) {
        return UserFlowEventOut(
          message: event["message"],
          step: event["step"],
          type: event["type"],
        );
      }).toList(growable: false));
    } catch (e) {
      // TODO Log exception
    }
  }

  @override
  Future<void> close() async {
    UserSupportChannel.removeListener("sendUserFlow");
    return super.close();
  }
}
