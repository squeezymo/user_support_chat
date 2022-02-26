import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../commons/platform.dart';
import '../../../util/avatar_color_factory.dart';
import '../models/models.dart';

class ChatWidget extends StatelessWidget {
  final ChatUi chat;

  const ChatWidget(
    this.chat, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const avatarRadius = 28.0;
    const baseHorizontalPadding = 8.0;
    const baseVerticalPadding = 8.0;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: baseVerticalPadding,
                horizontal: baseHorizontalPadding,
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: AvatarColorFactory.fromString(chat.userId),
                    child: Center(
                      child: Text(
                        chat.userName.isEmpty ? "?" : chat.userName[0],
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: avatarRadius / 3,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: _createPlatformIcon(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: baseVerticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (chat.userName.isNotEmpty)
                      Text(
                        chat.userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      chat.lastMessage,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: baseHorizontalPadding,
                  vertical: baseVerticalPadding),
              child: Text(
                chat.lastDate,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
              left: 2 * (avatarRadius + baseHorizontalPadding)),
          child: const Divider(
            thickness: 1.0,
            height: 1.0,
            color: Colors.white24,
          ),
        ),
      ],
    );
  }

  Widget _createPlatformIcon() {
    switch (chat.platform) {
      case AppPlatform.iOS:
        return const Icon(
          Icons.apple,
          color: Colors.black,
          size: 16,
        );
      case AppPlatform.android:
        return const Icon(
          Icons.android,
          color: Colors.green,
          size: 16,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

/*
    switch (chat.platform) {
      case AppPlatform.iOS:
        return SvgPicture.asset(
          'assets/images/apple.svg',
          color: Colors.black,
        );
      case AppPlatform.android:
        return SvgPicture.asset(
          'assets/images/android.svg',
          color: Colors.green,
        );
      default:
        return const SizedBox.shrink();
    }
 */
