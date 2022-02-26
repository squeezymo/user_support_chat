import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatting/data/utils/firebase_ext.dart';
import 'package:firebase_core/firebase_core.dart';

import '../commons/cacheable.dart';
import '../domain/model/models.dart';
import 'mapper/chat_dto_mapper.dart';
import 'model/models.dart';

class ChatDataSource {
  final String _platform;
  final String _appVersion;
  final String _supportId;
  final FirebaseFirestore _firestore;

  ChatDataSource({
    required String platform,
    required String appVersion,
    required String supportId,
    required FirebaseApp firebaseApp,
  })  : _platform = platform,
        _appVersion = appVersion,
        _supportId = supportId,
        _firestore = FirebaseFirestore.instanceFor(app: firebaseApp);

  Future<Cacheable<Iterable<SupportedApplicationDTO>>> getApplications() {
    return _firestore.collection("groups").get().then((querySnapshot) {
      return Cacheable(
        data: querySnapshot.extract((docSnapshot) =>
            ChatDtoMapper.mapSupportedApplication(docSnapshot)),
        isFromCache: querySnapshot.metadata.isFromCache,
      );
    });
  }

  Stream<Cacheable<Iterable<ChatDTO>>> getChats(
    String appId,
  ) {
    return _firestore
        .collection("groups/$appId/chats")
        .snapshots()
        .asyncMap((querySnapshot) {
      return Cacheable(
        data: querySnapshot
            .extract((docSnapshot) => ChatDtoMapper.mapChat(docSnapshot)),
        isFromCache: querySnapshot.metadata.isFromCache,
      );
    });
  }

  Future<Cacheable<ChatDTO>> getChat(
    String appId,
    String userId,
  ) {
    return _firestore
        .doc("groups/$appId/chats/$userId")
        .get()
        .then((docSnapshot) {
      return Cacheable(
        data: ChatDtoMapper.mapChat(docSnapshot),
        isFromCache: docSnapshot.metadata.isFromCache,
      );
    });
  }

  Future<void> deleteChat(
    String appId,
    String userId,
  ) {
    final writeBatch = _firestore.batch();
    writeBatch.delete(_firestore.doc("groups/$appId/chats/$userId"));

    return Future.wait([
      markCollectionForDeletion(
        "groups/$appId/chats/$userId/messages",
        writeBatch,
      ),
      markCollectionForDeletion(
        "groups/$appId/chats/$userId/userFlow",
        writeBatch,
      )
    ]).then((_) => writeBatch.commit());
  }

  Future<void> markCollectionForDeletion(
    String collectionPath,
    WriteBatch writeBatch,
  ) {
    return _firestore.collection(collectionPath).get().then((querySnapshot) {
      for (final docSnapshot in querySnapshot.docs) {
        writeBatch.delete(docSnapshot.reference);
      }
    });
  }

  Stream<Cacheable<Iterable<ChatMessageDTO>>> getMessages(
    String appId,
    String userId,
  ) {
    return _firestore
        .collection("groups/$appId/chats/$userId/messages")
        .snapshots()
        .asyncMap((querySnapshot) {
      return Cacheable(
        data: querySnapshot.extract(
            (docSnapshot) => ChatDtoMapper.mapChatMessage(docSnapshot)),
        isFromCache: querySnapshot.metadata.isFromCache,
      );
    });
  }

  Future<void> addMessage(
    String message, {
    required String appId,
    required String userId,
    required String? chatUserId,
  }) {
    final dateNow = Timestamp.now();
    final writeBatch = _firestore.batch();
    final isMessageFromClient = chatUserId == null || chatUserId == userId;

    writeBatch
      ..set(
        _firestore.doc("groups/$appId/chats/${chatUserId ?? userId}"),
        {
          "userInfo": {
            "platform": _platform,
            "appVersion": _appVersion,
          },
          "lastMessage": message,
          "lastDate": dateNow,
          if (isMessageFromClient) "userName": "",
          if (isMessageFromClient) "needRead": 1,
          if (isMessageFromClient) "userId": userId,
          "supportId": _supportId,
        },
        SetOptions(merge: true),
      )
      ..set(
        _firestore
            .collection("groups/$appId/chats/${chatUserId ?? userId}/messages")
            .doc(),
        {
          "body": message,
          "senderId": userId,
          "isRead": false,
          "date": dateNow,
        },
      );

    return writeBatch.commit();
  }

  Future<Cacheable<Iterable<UserFlowEventDTO>>> getUserFlow(
    String appId,
    String userId,
  ) {
    return _firestore
        .collection("groups/$appId/chats/$userId/userFlow")
        .get()
        .then((querySnapshot) {
      return Cacheable(
        data: querySnapshot.extract(
            (docSnapshot) => ChatDtoMapper.mapUserFlowEvent(docSnapshot)),
        isFromCache: querySnapshot.metadata.isFromCache,
      );
    });
  }

  Future<void> sendUserFlow(
    String appId,
    String userId,
    List<UserFlowEventOut> userFlow,
  ) {
    final writeBatch = _firestore.batch();
    final collectionPath = "groups/$appId/chats/$userId/userFlow";

    return markCollectionForDeletion(
      collectionPath,
      writeBatch,
    ).then((_) {
      for (final userFlowEvent in userFlow) {
        writeBatch.set(
          _firestore.collection(collectionPath).doc(),
          {
            "step": userFlowEvent.step,
            "message": userFlowEvent.message,
            "type": userFlowEvent.type,
          },
        );
      }

      return writeBatch.commit();
    });
  }

}
