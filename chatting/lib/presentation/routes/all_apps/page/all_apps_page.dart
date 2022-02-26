import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/bloc/all_apps/all_apps_bloc.dart';
import '../../../../domain/bloc/all_apps/all_apps_event.dart';
import '../../../../domain/repository/chat_repository.dart';
import '../../../commons/widget/platform_specific/platform_scaffold.dart';
import 'all_apps_layout.dart';

class AllAppsPage extends StatelessWidget {
  final bool isEmbedded;

  const AllAppsPage({
    required this.isEmbedded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldFactory.create(
      context,
      title: "Приложения", // TODO Localize
      body: _buildBody(context),
      isEmbedded: isEmbedded,
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider<AllAppsBloc>(
      create: (context) => AllAppsBloc(
        repository: context.read<ChatRepository>(),
      )..add(GetAllApps()),
      child: AllAppsLayout(
        isEmbedded: isEmbedded,
      ),
    );
  }
}
