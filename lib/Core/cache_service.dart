import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const _hideBalanceKey = 'hide_balance';

  /// Save hide/show state
  static Future<void> setHideBalance(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hideBalanceKey, value);
  }

  /// Get hide/show state (default = false → balance visible)
  static Future<bool> getHideBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hideBalanceKey) ?? true;
  }
}
