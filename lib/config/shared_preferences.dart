import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final key = 'refresh_key';

  Future<DateTime> getLastRefresh() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? "";
    return value == "" ? DateTime(1900) : DateTime.parse(value);
  }

  setLastRefresh(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, time.toIso8601String());
  }
}
