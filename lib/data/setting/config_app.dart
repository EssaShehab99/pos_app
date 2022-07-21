import 'package:shared_preferences/shared_preferences.dart';

class ConfigApp {
 static Future<void> saveToken(String token) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString('token', token);
    });
    print('ggggggggggggggggggggggggggggggggggggggg'+token);
    return Future.value();
  }
  static Future<String?> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  static Future<void> removeToken() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.remove('token');
    });
    return Future.value();
  }
}