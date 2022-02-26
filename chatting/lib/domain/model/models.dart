import '../../commons/platform.dart';

class SupportedApplication {
  final String id;
  final String name;

  const SupportedApplication({
    required this.id,
    required this.name,
  });
}

class Chat {
  final String userId;
  final String userName;
  final DateTime lastDate;
  final String lastMessage;
  final UserInfo userInfo;

  const Chat({
    required this.userId,
    required this.userName,
    required this.lastDate,
    required this.lastMessage,
    required this.userInfo,
  });
}

class ChatMessage {
  final String id;
  final String body;
  final bool isRead;
  final String senderId;
  final DateTime date;

  const ChatMessage({
    required this.id,
    required this.body,
    required this.isRead,
    required this.senderId,
    required this.date,
  });
}

class UserFlowEventOut {
  final String message;
  final int step;
  final String type;

  const UserFlowEventOut({
    required this.message,
    required this.step,
    required this.type,
  });
}

class UserFlowEvent {
  final String id;
  final String message;
  final int step;
  final String type;

  const UserFlowEvent({
    required this.id,
    required this.message,
    required this.step,
    required this.type,
  });
}

class UserInfo {
  final String? userName;
  final String? appVersion;
  final AppPlatform? platform;
  final String? iOS;
  final String? android;

  const UserInfo(
      {this.userName, this.appVersion, this.platform, this.iOS, this.android});
}
