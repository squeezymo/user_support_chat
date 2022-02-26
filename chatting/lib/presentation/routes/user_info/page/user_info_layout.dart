import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/bloc/user_info/user_info_bloc.dart';
import '../../../../domain/bloc/user_info/user_info_state.dart';
import '../../../commons/widget/data_error_widget.dart';
import '../../../commons/widget/data_loader_widget.dart';
import '../mapper/user_info_ui_mapper.dart';
import '../model/models.dart';
import '../widget/user_flow_event_widget.dart';
import '../widget/user_flow_section_widget.dart';
import '../widget/user_info_key_value_widget.dart';

class UserInfoLayout extends StatelessWidget {
  UserInfoLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        switch (state.status) {
          case UserInfoStatus.initial:
          case UserInfoStatus.loading:
            return const DataLoaderWidget();
          case UserInfoStatus.success:
            return _buildSuccessState(context, state);
          case UserInfoStatus.error:
            return DataErrorWidget(state.errorState!);
        }
      },
    );
  }

  Widget _buildSuccessState(
    BuildContext context,
    UserInfoState state,
  ) {
    final uiItems =
        UserInfoUiMapper.mapUserData(state.userInfo, state.userFlow);

    return ListView.separated(
      itemCount: uiItems.length,
      itemBuilder: (context, index) {
        final uiItem = uiItems[index];

        switch (uiItem.runtimeType) {
          case UserInfoSectionUi:
            return _buildUserInfoSectionItem(context, uiItem);
          case UserInfoKeyValueUi:
            return _buildUserInfoKeyValueItem(context, uiItem);
          case UserFlowEventUi:
            return _buildUserFlowListItem(context, uiItem);
          default:
            throw Exception(
                'Unsupported type ${uiItem.runtimeType.toString()}');
        }
      },
      separatorBuilder: (context, index) {
        if (uiItems[index] is UserInfoSectionUi) {
          return const SizedBox.shrink();
        }

        return _buildUserFlowSeparator(context);
      },
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
    );
  }

  Widget _buildUserFlowSeparator(
    BuildContext context,
  ) {
    return const Divider(
      thickness: 1.0,
      height: 1.0,
      color: Colors.white24,
      indent: 16.0,
    );
  }

  Widget _buildUserInfoSectionItem(
    BuildContext context,
    UserInfoSectionUi section,
  ) {
    return UserInfoSectionWidget(
      section,
    );
  }

  Widget _buildUserInfoKeyValueItem(
    BuildContext context,
    UserInfoKeyValueUi keyValue,
  ) {
    return UserInfoKeyValueWidget(
      keyValue,
      key: ValueKey(keyValue.label.hashCode),
    );
  }

  Widget _buildUserFlowListItem(
    BuildContext context,
    UserFlowEventUi event,
  ) {
    return UserFlowEventWidget(
      event,
      key: ValueKey(event.id),
    );
  }
}
