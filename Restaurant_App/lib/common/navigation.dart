import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> keyNavigation = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Object arguments) {
    keyNavigation.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static back() => keyNavigation.currentState?.pop();
}
