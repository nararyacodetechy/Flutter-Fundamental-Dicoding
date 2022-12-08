import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/preference_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/widgets/widget_custom_dialog.dart';
import 'package:restaurant_app/widgets/widget_platform.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle, style: TextStyle(color: primaryColor)),
        backgroundColor: secondaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10.0),
                          child: Text(
                            'Help Center',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        const Material(
                          child: ListTile(
                            leading: Icon(Icons.help),
                            title: Text('Help Center'),
                          ),
                        ),
                        const Material(
                          child: ListTile(
                            leading: Icon(Icons.medical_services),
                            title: Text('Term of Services'),
                          ),
                        ),
                        const Material(
                          child: ListTile(
                            leading: Icon(Icons.error),
                            title: Text('Bug Report'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10.0),
                          child: Text(
                            'Application Settings',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: const Icon(Icons.nightlight),
                            title: const Text('Dark & Light Mode'),
                            trailing: Switch.adaptive(
                              value: provider.isDarkTheme,
                              onChanged: (value) {
                                provider.enableTypeTheme(value);
                              },
                            ),
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: const Icon(Icons.notification_add),
                            title: const Text('Scheduling'),
                            trailing: Consumer<SchedulingProvider>(
                              builder: (context, scheduled, _) {
                                return Switch.adaptive(
                                  value: provider.isDailyRestaurantActive,
                                  onChanged: (value) async {
                                    if (Platform.isIOS) {
                                      customDialog(context);
                                    } else {
                                      scheduled.scheduledRestaurant(value);
                                      provider.enableDailyRestaurant(value);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        const Material(
                          child: ListTile(
                            leading: Icon(Icons.privacy_tip),
                            title: Text('Privacy'),
                          ),
                        ),
                        const Material(
                          child: ListTile(
                            leading: Icon(Icons.security),
                            title: Text('Security'),
                          ),
                        ),
                        const Material(
                          child: ListTile(
                            leading: Icon(Icons.language),
                            title: Text('Language'),
                          ),
                        ),
                        const Material(
                          child: ListTile(
                            leading: Icon(Icons.chat),
                            title: Text('Chatting'),
                          ),
                        ),
                        const Material(
                          child: ListTile(
                            leading: Icon(Icons.accessibility),
                            title: Text('Accessibility'),
                          ),
                        ),
                        const Material(
                          child: ListTile(
                            leading: Icon(Icons.miscellaneous_services),
                            title: Text('More Settings'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}