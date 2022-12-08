import 'package:flutter/material.dart';
import 'package:restaurant_app/data/preferences/preference_helper.dart';
import '../common/styles.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyRestaurantPreferences();
  }

  bool _isTypeTheme = false;
  bool _isDailyRestaurantActive = false;

  bool get isDarkTheme => _isTypeTheme;
  bool get isDailyRestaurantActive => _isDailyRestaurantActive;

  ThemeData get themeData => _isTypeTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isTypeTheme = await preferencesHelper.isTypeTheme;
    notifyListeners();
  }

  void _getDailyRestaurantPreferences() async {
    _isDailyRestaurantActive = await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableTypeTheme(bool value) {
    preferencesHelper.setTypeTheme(value);
    _getTheme();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getDailyRestaurantPreferences();
  }
}
