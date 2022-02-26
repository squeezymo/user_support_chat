import 'package:collection/collection.dart';

import '../../../../commons/cacheable.dart';
import '../../../../domain/model/models.dart';
import '../model/models.dart';

class ChatMessagesUiMapper {
  static List<ChatMessageUi> mapChatMessages(
    Cacheable<List<ChatMessage>> chatMessages,
    bool isEmbedded,
    String currentUserId,
    String? chatUserId,
  ) {
    final result = <ChatMessageUi>[];

    chatMessages.data.forEachIndexed(
      (index, message) {
        final ChatMessage? nextMessage;

        if (index >= chatMessages.data.length - 1) {
          nextMessage = null;
        } else {
          nextMessage = chatMessages.data[index + 1];
        }

        final bool isSender;

        if (isEmbedded) {
          isSender = message.senderId == currentUserId;
        } else {
          isSender = message.senderId != chatUserId;
        }

        result.add(
          ChatMessageUi(
            id: message.id,
            body: message.body,
            isRead: message.isRead,
            isSender: isSender,
            isLastMessageInSeries: nextMessage?.senderId != message.senderId,
          ),
        );
      },
    );

    return result;
  }
}
