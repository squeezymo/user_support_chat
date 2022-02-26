import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserIdRepository {
  const UserIdRepository();

  Future<String> getUserId() {
    return SharedPreferences.getInstance().then((prefs) => _getUserId(prefs));
  }
  
  String _getUserId(SharedPreferences prefs) {
    var userId = prefs.getString("user_id");

    if (userId == null) {
      userId = const Uuid().v4().toString().toUpperCase();
      prefs.setString("user_id", userId);
    }

    return userId;
  }
}
