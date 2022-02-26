import 'package:equatable/equatable.dart';

abstract class AllAppsEvent extends Equatable {}

class GetAllApps extends AllAppsEvent {
  @override
  List<Object?> get props => [];
}
