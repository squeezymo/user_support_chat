import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/bloc/chat/chat_bloc.dart';
import '../../../../domain/bloc/chat/chat_event.dart';
import '../../../../commons/platform.dart';

class ComposeMessageWidget extends StatefulWidget {
  final bool isMessageSubmitInProgress;

  const ComposeMessageWidget({
    required this.isMessageSubmitInProgress,
    Key? key,
  }) : super(key: key);

  @override
  State<ComposeMessageWidget> createState() => _ComposeMessageWidgetState();
}

class _ComposeMessageWidgetState extends State<ComposeMessageWidget> {
  final TextEditingController _controller = TextEditingController();

  String get _inputText {
    return _controller.text.trim();
  }

  bool get _isInputEmpty {
    return _inputText.isEmpty;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _buildMessageInput(context),
          ),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0),
    );
    const hint = "Сообщение"; // TODO Localise
    final hintStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.merge(const TextStyle(color: Colors.white30));
    const fillColor = Colors.white30;
    final inputStyle = Theme.of(context).textTheme.bodyLarge;

    if (AppEnvironment.designSystem == AppDesignSystem.material) {
      return TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintStyle,
          filled: true,
          fillColor: fillColor,
          border: defaultBorder,
          focusedBorder: defaultBorder,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
        ),
        style: inputStyle,
        minLines: 1,
        maxLines: 6,
        textCapitalization: TextCapitalization.sentences,
        autocorrect: true,
      );
    }
    else {
      return CupertinoTextField(
        controller: _controller,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(24.0),
        ),
        placeholder: hint,
        placeholderStyle: hintStyle,
        style: inputStyle,
        minLines: 1,
        maxLines: 6,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        textCapitalization: TextCapitalization.sentences,
        autocorrect: true,
      );
    }
  }

  Widget _buildSubmitButton(BuildContext context) {
    final VoidCallback? onPressed;

    if (_isInputEmpty || widget.isMessageSubmitInProgress) {
      onPressed = null;
    } else {
      onPressed = () => _submit(context);
    }

    return ElevatedButton(
      onPressed: onPressed,
      child: Icon(
        Icons.arrow_upward_rounded,
        color: onPressed == null ? Colors.white60 : Colors.white,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.blue,
        ),
        shape: MaterialStateProperty.all<CircleBorder>(
          const CircleBorder(),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size(48.0, 48.0),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    context.read<ChatBloc>().add(SubmitNewMessage(_inputText));
    _controller.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
