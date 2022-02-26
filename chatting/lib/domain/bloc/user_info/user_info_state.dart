import 'package:equatable/equatable.dart';

import '../../../commons/cacheable.dart';
import '../../../commons/error_state.dart';
import '../../model/models.dart';

enum UserInfoStatus { initial, success, error, loading }

class UserInfoState extends Equatable {
  final UserInfoStatus status;
  final Cacheable<UserInfo> userInfo;
  final Cacheable<List<UserFlowEvent>> userFlow;
  final ErrorState? errorState;

  const UserInfoState._({
    required this.status,
    required this.userInfo,
    required this.userFlow,
    required this.errorState,
  });

  const UserInfoState.initial()
      : status = UserInfoStatus.initial,
        userInfo = const Cacheable.remote(UserInfo()),
        userFlow = const Cacheable.remote([]),
        errorState = null;

  const UserInfoState.success({
    required this.userInfo,
    required this.userFlow,
  }) : status = UserInfoStatus.success,
        errorState = null;

  const UserInfoState.error(this.errorState)
      : status = UserInfoStatus.error,
        userInfo = const Cacheable.remote(UserInfo()),
        userFlow = const Cacheable.remote([]);

  const UserInfoState.loading()
      : status = UserInfoStatus.loading,
        userInfo = const Cacheable.remote(UserInfo()),
        userFlow = const Cacheable.remote([]),
        errorState = null;

  @override
  List<Object?> get props => [status, userInfo];

}
