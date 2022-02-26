import 'package:equatable/equatable.dart';

import '../../../commons/cacheable.dart';
import '../../../commons/error_state.dart';
import '../../model/models.dart';

enum AllAppsStatus { initial, success, error, loading }

class AllAppsState extends Equatable {
  final AllAppsStatus status;
  final Cacheable<List<SupportedApplication>> applications;
  final ErrorState? errorState;

  const AllAppsState._({
    required this.status,
    required this.applications,
    required this.errorState,
  });

  const AllAppsState.initial()
      : status = AllAppsStatus.initial,
        applications = const Cacheable.remote([]),
        errorState = null;

  const AllAppsState.success(this.applications)
      : status = AllAppsStatus.success,
        errorState = null;

  const AllAppsState.error(this.errorState)
      : status = AllAppsStatus.error,
        applications = const Cacheable.remote([]);

  const AllAppsState.loading()
      : status = AllAppsStatus.loading,
        applications = const Cacheable.remote([]),
        errorState = null;

  @override
  List<Object?> get props => [status, applications];
}
