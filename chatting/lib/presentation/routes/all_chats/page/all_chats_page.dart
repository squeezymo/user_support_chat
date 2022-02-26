import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../domain/bloc/all_chats/all_chats_bloc.dart';
import '../../../../domain/repository/chat_repository.dart';
import '../../../commons/widget/platform_specific/platform_icon_button.dart';
import '../../../commons/widget/platform_specific/platform_scaffold.dart';
import '../widget/chat_filter_widget.dart';
import 'all_chats_layout.dart';

class AllChatsPage extends StatelessWidget {
  final String appId;
  final String appName;
  final bool isEmbedded;

  const AllChatsPage(
    this.appId,
    this.appName, {
    Key? key,
    required this.isEmbedded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllChatsBloc>(
      create: (context) => AllChatsBloc(
        appId: appId,
        repository: context.read<ChatRepository>(),
      ),
      child: ScaffoldFactory.create(
        context,
        title: appName,
        body: AllChatsLayout(
          isEmbedded: isEmbedded,
        ),
        actions: [
          _buildFilterAction(context),
        ],
        isEmbedded: isEmbedded,
      ),
    );
  }

  Widget _buildFilterAction(BuildContext context) {
    return IconButtonFactory.create(
      icon: const Icon(Icons.filter_alt),
      tooltip: 'Фильтр', // TODO Localize
      onPressed: () => _showFilterSheet(context),
    );
  }

  void _showFilterSheet(BuildContext context) async {
    final bloc = context.read<AllChatsBloc>();

    await showModalBottomSheet(
      context: context,
      builder: (context) => Provider.value(
        value: bloc,
        child: const ChatFilterWidget(),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 33, 36),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.hardEdge,
    );
  }
}
