import 'package:equatable/equatable.dart';

class ChatMessageUi extends Equatable {
  final String id;
  final String body;
  final bool isRead;
  final bool isSender;
  final bool isLastMessageInSeries;

  const ChatMessageUi({
    required this.id,
    required this.body,
    required this.isRead,
    required this.isSender,
    required this.isLastMessageInSeries,
  });

  @override
  List<Object?> get props => [id, body];
}
