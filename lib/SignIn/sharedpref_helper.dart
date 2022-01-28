import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  String userIdKey = 'USERIDKEY';
  String userNameKey = 'USERNAME';
  String userMajorKey = 'USERMAJOR';

  // Save data
  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveNameId(String getNameId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getNameId);
  }

  Future<bool> saveMajorId(String getMajorId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userMajorKey, getMajorId);
  }

  // Get data
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getNameId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getMajorId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userMajorKey);
  }
}