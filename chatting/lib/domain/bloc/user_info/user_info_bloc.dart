import 'package:chatting/commons/error_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatting/domain/bloc/user_info/user_info_event.dart';
import 'package:chatting/domain/bloc/user_info/user_info_state.dart';

import '../../model/models.dart';
import '../../repository/chat_repository.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc({
    required this.appId,
    required ChatRepository repository,
  })  : _chatRepository = repository,
        super(
          const UserInfoState.initial(),
        ) {
    on<GetUserInfo>(_getUserInfo);
  }

  final String appId;
  final ChatRepository _chatRepository;

  void _getUserInfo(
    GetUserInfo event,
    Emitter<UserInfoState> emit,
  ) async {
    emit(const UserInfoState.loading());

    try {
      final chat = await _chatRepository.getChat(appId, event.userId);
      final userFlow = await _chatRepository.getUserFlow(appId, event.userId);

      emit(
        UserInfoState.success(
          userInfo: chat.map(
            (c) => UserInfo(
              userName: c.userName,
              appVersion: c.userInfo.appVersion,
              platform: c.userInfo.platform,
              iOS: c.userInfo.iOS,
            ),
          ),
          userFlow: userFlow,
        ),
      );
    } on Exception catch (ex) {
      emit(
        UserInfoState.error(
          ErrorState.fromException(
            ex,
          ),
        ),
      );
    }
  }
}
