import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final baseKey = 'refresh_key';

  Future<DateTime> getLastRefresh(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('$baseKey/$key') ?? "";
    return value == "" ? DateTime(1900) : DateTime.parse(value);
  }

  setLastRefresh(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('$baseKey/$key', DateTime.now().toIso8601String());
  }
}
