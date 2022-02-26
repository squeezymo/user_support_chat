import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/models.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessageUi message;

  const ChatMessageWidget(this.message, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: BubbleSpecialThree(
        text: message.body,
        isSender: message.isSender,
        tail: message.isLastMessageInSeries,
        color: message.isSender ? Colors.white30 : Colors.white12,
        textStyle: Theme.of(context).textTheme.bodyMedium!,
      ),
    );
  }

}
