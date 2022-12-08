import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const typeTheme = 'Type_Theme';
  static const notifRestaurant = 'Notification_Restaurant';

  Future<bool> get isTypeTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(typeTheme) ?? false;
  }

  Future<bool> get isDailyRestaurantActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(notifRestaurant) ?? false;
  }

  void setTypeTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(typeTheme, value);
  }

  void setDailyRestaurant(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(notifRestaurant, value);
  }
}
