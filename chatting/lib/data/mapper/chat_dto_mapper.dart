import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/models.dart';

class ChatDtoMapper {
  static SupportedApplicationDTO mapSupportedApplication(
    DocumentSnapshot docSnapshot,
  ) {
    return SupportedApplicationDTO(
      id: docSnapshot.id,
      name: docSnapshot.get("name"),
    );
  }

  static ChatDTO mapChat(
    DocumentSnapshot docSnapshot,
  ) {
    final info = docSnapshot.get("userInfo") as Map<String, dynamic>;

    return ChatDTO(
      userId: docSnapshot.id,
      userName: docSnapshot.get("userName"),
      lastDate: docSnapshot.get("lastDate"),
      lastMessage: docSnapshot.get("lastMessage"),
      userInfo: UserInfoDTO(
        appVersion: info["appVersion"],
        platform: info["platform"],
        iOS: info["iOS"],
        android: info["android"],
      ),
    );
  }

  static ChatMessageDTO mapChatMessage(
    DocumentSnapshot docSnapshot,
  ) {
    return ChatMessageDTO(
      id: docSnapshot.id,
      body: docSnapshot.get("body"),
      isRead: docSnapshot.get("isRead"),
      senderId: docSnapshot.get("senderId"),
      date: docSnapshot.get("date"),
    );
  }

  static UserFlowEventDTO mapUserFlowEvent(
    DocumentSnapshot docSnapshot,
  ) {
    return UserFlowEventDTO(
      id: docSnapshot.id,
      message: docSnapshot.get("message"),
      step: docSnapshot.get("step"),
      type: docSnapshot.get("type"),
    );
  }
}
