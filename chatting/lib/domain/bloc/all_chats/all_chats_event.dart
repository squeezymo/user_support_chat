import 'package:equatable/equatable.dart';

abstract class AllChatsEvent extends Equatable {}

class StartListeningToUpdates extends AllChatsEvent {
  @override
  List<Object?> get props => [];
}

class StopListeningToUpdates extends AllChatsEvent {
  @override
  List<Object?> get props => [];
}

class DeleteChat extends AllChatsEvent {
  final String chatUserId;

  DeleteChat(this.chatUserId);

  @override
  List<Object?> get props => [chatUserId];
}
