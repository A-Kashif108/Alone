import 'package:shared_preferences/shared_preferences.dart';
class LocalDataSaver{

  static String logKey = "LOGWALIKEY";

  static Future<bool> saveLoginData(bool isUserLoggedIn)
  async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(logKey, isUserLoggedIn);
  }

  static Future<bool?> getLogData() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(logKey);
  }
}