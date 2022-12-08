// ignore_for_file: avoid_print

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/data/helpers/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling is turned on');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        exact: true,
        wakeup: true,
        startAt: DateTimeHelper.format(),
        BackgroundService.callback,
      );
    } else {
      print('Scheduling is turned off');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
