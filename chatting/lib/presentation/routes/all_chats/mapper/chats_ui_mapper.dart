import '../../../../commons/cacheable.dart';
import '../../../../domain/model/models.dart';
import '../../../util/date_formatter.dart';
import '../models/models.dart';

class ChatUiMapper {
  static List<ChatUi> mapChats(
    Cacheable<List<Chat>> chats,
  ) {
    return chats.data
        .map(
          (chat) => ChatUi(
            userId: chat.userId,
            userName: extractUiUserName(chat.userName),
            lastDate: DateTimeVerbalizer.verbalize(chat.lastDate),
            lastMessage: chat.lastMessage,
            platform: chat.userInfo.platform,
          ),
        )
        .toList(growable: false);
  }

  static String extractUiUserName(String name) {
    final iphoneGenericPattern = RegExp(r'^iPhone \((.*)\)$');
    final extractedName = iphoneGenericPattern.firstMatch(name)?.group(1);

    return extractedName ?? name;
  }
}
