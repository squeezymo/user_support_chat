import 'package:equatable/equatable.dart';

abstract class UserInfoEvent extends Equatable {}

class GetUserInfo extends UserInfoEvent {
  final String userId;

  GetUserInfo(this.userId);

  @override
  List<Object?> get props => [userId];
}
