import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/bloc/all_chats/all_chats_bloc.dart';

class ChatFilterWidget extends StatelessWidget {
  const ChatFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllChatsBloc>();

    return Text(
"Bottom Sheet"
    );
  }
}
