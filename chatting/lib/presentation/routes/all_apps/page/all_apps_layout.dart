import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/bloc/all_apps/all_apps_bloc.dart';
import '../../../../domain/bloc/all_apps/all_apps_state.dart';
import '../../../commons/navigation/platform_specific/platform_page_route.dart';
import '../../../commons/widget/data_error_widget.dart';
import '../../../commons/widget/data_loader_widget.dart';
import '../../../commons/widget/platform_specific/platform_ink_well.dart';
import '../../all_chats/page/all_chats_page.dart';
import '../mapper/all_apps_ui_mapper.dart';
import '../widget/supported_application_widget.dart';
import '../models/models.dart';

class AllAppsLayout extends StatelessWidget {
  final bool isEmbedded;

  const AllAppsLayout({
    required this.isEmbedded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllAppsBloc, AllAppsState>(
      builder: (context, state) {
        switch (state.status) {
          case AllAppsStatus.initial:
          case AllAppsStatus.loading:
            return const DataLoaderWidget();
          case AllAppsStatus.success:
            return _buildSuccessState(context, state);
          case AllAppsStatus.error:
            return DataErrorWidget(state.errorState!);
        }
      },
    );
  }

  Widget _buildSuccessState(
    BuildContext context,
    AllAppsState state,
  ) {
    final uiElements = AllAppsUiMapper.mapApplications(state.applications);

    return ListView.builder(
      itemCount: uiElements.length,
      itemBuilder: (context, index) {
        return _buildListItem(context, uiElements[index]);
      },
    );
  }

  Widget _buildListItem(
    BuildContext context,
    SupportedApplicationUi app,
  ) {
    return InkWellFactory.create(
      child: SupportedApplicationWidget(
        app,
        key: ValueKey(app.id),
      ),
      onTap: () => _openChats(context, app.id, app.name),
    );
  }

  void _openChats(
    BuildContext context,
    String appId,
    String appName,
  ) {
    Navigator.push(
      context,
      PlatformPageRouteFactory.create(
        builder: (routeContext) => AllChatsPage(
          appId,
          appName,
          isEmbedded: isEmbedded,
        ),
      ),
    );
  }
}
