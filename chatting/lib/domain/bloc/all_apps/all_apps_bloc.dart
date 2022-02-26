import 'package:chatting/commons/error_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/chat_repository.dart';
import 'all_apps_event.dart';
import 'all_apps_state.dart';

class AllAppsBloc extends Bloc<AllAppsEvent, AllAppsState> {
  AllAppsBloc({
    required ChatRepository repository,
  })  : _chatRepository = repository,
        super(
          const AllAppsState.initial(),
        ) {
    on<GetAllApps>(_getAllApps);
  }

  final ChatRepository _chatRepository;

  void _getAllApps(
    GetAllApps event,
    Emitter<AllAppsState> emit,
  ) async {
    emit(const AllAppsState.loading());

    try {
      final apps = await _chatRepository.getApplications();
      emit(
        AllAppsState.success(apps),
      );
    } on Exception catch (e) {
      emit(
        AllAppsState.error(
          ErrorState.fromException(e),
        ),
      );
    }
  }
}
