import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {}

class StartListeningToUpdates extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class StopListeningToUpdates extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class SubmitNewMessage extends ChatEvent {
  final String message;

  SubmitNewMessage(this.message);

  @override
  List<Object?> get props => [message];
}
