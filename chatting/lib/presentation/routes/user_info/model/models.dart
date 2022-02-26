import 'package:equatable/equatable.dart';

class UserInfoSectionUi extends Equatable {
  final String title;

  const UserInfoSectionUi({
    required this.title,
  });

  @override
  List<Object?> get props => [title];
}

class UserInfoKeyValueUi extends Equatable {
  final String caption;
  final String label;

  const UserInfoKeyValueUi({
    required this.caption,
    required this.label,
  });

  @override
  List<Object?> get props => [caption, label];
}

class UserFlowEventUi extends Equatable {
  final String id;
  final String message;
  final int step;
  final String type;

  const UserFlowEventUi({
    required this.id,
    required this.message,
    required this.step,
    required this.type,
  });

  @override
  List<Object?> get props => [message, step, type];
}
