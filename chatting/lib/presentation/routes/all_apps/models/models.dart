import 'package:equatable/equatable.dart';

class SupportedApplicationUi extends Equatable {
  final String id;
  final String name;

  const SupportedApplicationUi({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
