import 'package:shared_preferences/shared_preferences.dart';

class ConfigApp {
  static Future<void> saveEmailAndPassword(
      String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    return Future.value();
  }

  static Future<List<String>> getEmailAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    if (email == null || password == null) {
      return [];
    }
    return [email, password];
  }
  static Future<void> removeEmailAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
    return Future.value();
  }
}
