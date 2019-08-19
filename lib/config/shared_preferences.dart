import 'package:ninjanga3/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final baseKey = 'refresh_key';

  Future<DateTime> getLastRefresh(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('$baseKey/$key') ?? "";
    return value == "" ? DateTime(1900) : DateTime.parse(value);
  }

  setLastRefresh(String key, [DateTime date]) async {
    final prefs = await SharedPreferences.getInstance();
    if (date == null) {
      prefs.setString('$baseKey/$key', DateTime.now().toIso8601String());
    } else
      prefs.setString('$baseKey/$key', date.toIso8601String());
  }

  Future hardReset() async {
    await setLastRefresh(Constants.MOVIES_DB, DateTime(1900));
    await setLastRefresh(Constants.SERIES_DB, DateTime(1900));
  }
}
