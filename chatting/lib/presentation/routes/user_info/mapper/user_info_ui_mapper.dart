import '../../../../commons/cacheable.dart';
import '../../../../domain/model/models.dart';
import '../../../../commons/platform.dart';
import '../model/models.dart';

class UserInfoUiMapper {
  static List<dynamic> mapUserData(
    Cacheable<UserInfo> userInfo,
    Cacheable<List<UserFlowEvent>> events,
  ) {
    final uiUserInfo = UserInfoUiMapper._mapUserInfo(userInfo);
    final uiUserEvents = UserInfoUiMapper._mapUserEvents(events);
    final result = <dynamic>[];

    result.addAll(uiUserInfo);

    if (uiUserEvents.isNotEmpty) {
      // TODO Localize
      result.add(
        const UserInfoSectionUi(
          title: "Флоу",
        ),
      );

      result.addAll(uiUserEvents);
    }

    return result;
  }

  static List<UserFlowEventUi> _mapUserEvents(
    Cacheable<List<UserFlowEvent>> events,
  ) {
    return events.data
        .map(
          (event) => UserFlowEventUi(
            id: event.id,
            message: event.message,
            step: event.step,
            type: event.type,
          ),
        )
        .toList(growable: false);
  }

  static List<UserInfoKeyValueUi> _mapUserInfo(
    Cacheable<UserInfo> userInfo,
  ) {
    final String platformUi;
    if (userInfo.data.platform == AppPlatform.android) {
      platformUi = "Android";
    } else {
      platformUi = "iOS";
    }

    // TODO Localize
    final map = {
      "Имя": userInfo.data.userName,
      "Платформа": platformUi,
      "Версия iOS": userInfo.data.iOS,
      "Версия Android": userInfo.data.android,
      "Версия приложения": userInfo.data.appVersion,
    }..removeWhere((key, value) => value == null || value.isEmpty);

    final result = <UserInfoKeyValueUi>[];

    map.forEach((key, value) {
      result.add(UserInfoKeyValueUi(
        caption: key,
        label: value!,
      ));
    });

    return result;
  }
}
