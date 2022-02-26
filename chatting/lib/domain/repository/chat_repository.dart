import '../../commons/cacheable.dart';
import '../../data/chat_data_source.dart';
import '../mapper/chat_domain_mapper.dart';
import '../model/models.dart';

class ChatRepository {
  const ChatRepository({
    required ChatDataSource dataSource,
  }) : _dataSource = dataSource;

  final ChatDataSource _dataSource;

  Future<Cacheable<List<SupportedApplication>>> getApplications() {
    return _dataSource.getApplications().then((cacheable) {
      final apps = cacheable.data.map((application) =>
          ChatDomainMapper.mapSupportedApplication(application));

      return Cacheable(
        data: apps.toList(growable: false)
          ..sort((app1, app2) => app1.name.compareTo(app2.name)),
        isFromCache: cacheable.isFromCache,
      );
    });
  }

  Stream<Cacheable<List<Chat>>> getChats(
    String appId,
  ) {
    return _dataSource.getChats(appId).map(
          (cacheable) => cacheable.map(
            (chats) => chats
                .map(
                  (chat) => ChatDomainMapper.mapChat(chat),
                )
                .toList(
                  growable: false,
                )
              ..sort(
                  (chat1, chat2) => chat2.lastDate.compareTo(chat1.lastDate)),
          ),
        );
  }

  Future<Cacheable<Chat>> getChat(
    String appId,
    String userId,
  ) {
    return _dataSource.getChat(appId, userId).then(
          (cacheable) => cacheable.map(
            (chat) => ChatDomainMapper.mapChat(chat),
          ),
        );
  }

  Future<void> deleteChat(
    String appId,
    String userId,
  ) {
    return _dataSource.deleteChat(appId, userId);
  }

  Stream<Cacheable<List<ChatMessage>>> getMessages(
    String appId,
    String userId,
  ) {
    return _dataSource.getMessages(appId, userId).map(
          (cacheable) => cacheable.map(
            (messages) => messages
                .map(
                  (message) => ChatDomainMapper.mapChatMessage(message),
                )
                .toList(
                  growable: false,
                )..sort((chat1, chat2) => chat1.date.compareTo(chat2.date)),
          ),
        );
  }

  Future<void> addMessage(
    String message, {
    required String appId,
    required String userId,
    required String? chatUserId,
  }) {
    return _dataSource.addMessage(
      message,
      appId: appId,
      userId: userId,
      chatUserId: chatUserId,
    );
  }

  Future<Cacheable<List<UserFlowEvent>>> getUserFlow(
    String appId,
    String userId,
  ) {
    return _dataSource.getUserFlow(appId, userId).then((cacheable) {
      final userFlowEvents = cacheable.data.map(
          (userFlowEvent) => ChatDomainMapper.mapUserFlowEvent(userFlowEvent));

      return Cacheable(
        data: userFlowEvents.toList(growable: false)
          ..sort((event1, event2) => event1.step.compareTo(event2.step)),
        isFromCache: cacheable.isFromCache,
      );
    });
  }

  Future<void> sendUserFlow(
    List<UserFlowEventOut> userFlow,
  ) {
    return Future.value();
  }
}
