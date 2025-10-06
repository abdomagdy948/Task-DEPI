import 'package:shared_preferences/shared_preferences.dart';

class LocalStoreNames {
  static const String firebaseDeviceId = 'firebase_device_id';
}

class AppLocalStore {
  AppLocalStore._();

  static Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
