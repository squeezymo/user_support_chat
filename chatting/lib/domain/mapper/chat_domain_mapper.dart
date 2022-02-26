import '../../data/model/models.dart';
import '../../commons/platform.dart';
import '../model/models.dart';

class ChatDomainMapper {
  static SupportedApplication mapSupportedApplication(
    SupportedApplicationDTO dto,
  ) {
    return SupportedApplication(
      id: dto.id,
      name: dto.name,
    );
  }

  static Chat mapChat(
    ChatDTO dto,
  ) {
    return Chat(
      userId: dto.userId,
      userName: dto.userName,
      lastDate: dto.lastDate.toDate(),
      lastMessage: dto.lastMessage,
      userInfo: mapUserInfo(dto.userInfo),
    );
  }

  static ChatMessage mapChatMessage(
    ChatMessageDTO dto,
  ) {
    return ChatMessage(
      id: dto.id,
      body: dto.body,
      isRead: dto.isRead,
      senderId: dto.senderId,
      date: dto.date.toDate(),
    );
  }

  static UserInfo mapUserInfo(
    UserInfoDTO dto,
  ) {
    return UserInfo(
      appVersion: dto.appVersion,
      platform: mapAppPlatform(dto.platform),
      iOS: dto.iOS,
      android: dto.android,
    );
  }

  static UserFlowEvent mapUserFlowEvent(
    UserFlowEventDTO dto,
  ) {
    return UserFlowEvent(
      id: dto.id,
      message: dto.message,
      step: dto.step,
      type: dto.type,
    );
  }

  static AppPlatform? mapAppPlatform(
    String? dtoValue,
  ) {
    switch (dtoValue?.toLowerCase()) {
      case "ios":
        return AppPlatform.iOS;
      case "macos":
        return AppPlatform.macOS;
      case "android":
        return AppPlatform.android;
      case "fuchsia":
        return AppPlatform.fuchsia;
      case "linux":
        return AppPlatform.linux;
      case "windows":
        return AppPlatform.windows;
      case null:
        return AppPlatform.iOS; // iOS unless specified otherwise
      default:
        throw Exception("Unsupported platform: $dtoValue");
    }
  }
}
