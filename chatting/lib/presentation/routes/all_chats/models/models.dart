import 'package:equatable/equatable.dart';

import '../../../../commons/platform.dart';

class ChatUi extends Equatable {
  final String userId;
  final String userName;
  final String lastDate;
  final String lastMessage;
  final AppPlatform? platform;

  const ChatUi({
    required this.userId,
    required this.userName,
    required this.lastDate,
    required this.lastMessage,
    required this.platform,
  });

  @override
  List<Object?> get props => [
        userId,
        userName,
        lastDate,
        lastMessage,
        platform,
      ];
}
