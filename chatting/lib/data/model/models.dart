import 'package:cloud_firestore/cloud_firestore.dart';

class SupportedApplicationDTO {
  final String id;
  final String name;

  SupportedApplicationDTO({
    required this.id,
    required this.name,
  });
}

class ChatDTO {
  final String userId;
  final String userName;
  final Timestamp lastDate;
  final String lastMessage;
  final UserInfoDTO userInfo;

  ChatDTO({
    required this.userId,
    required this.userName,
    required this.lastDate,
    required this.lastMessage,
    required this.userInfo,
  });
}

class ChatMessageDTO {
  final String id;
  final String body;
  final bool isRead;
  final String senderId;
  final Timestamp date;

  ChatMessageDTO({
    required this.id,
    required this.body,
    required this.isRead,
    required this.senderId,
    required this.date,
  });
}

class UserInfoDTO {
  final String? appVersion;
  final String? platform;
  final String? iOS;
  final String? android;

  UserInfoDTO({
    this.appVersion,
    this.platform,
    this.iOS,
    this.android,
  });
}

class UserFlowEventDTO {
  final String id;
  final String message;
  final int step;
  final String type;

  UserFlowEventDTO({
    required this.id,
    required this.message,
    required this.step,
    required this.type,
  });
}
