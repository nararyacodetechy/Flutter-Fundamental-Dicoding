// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/db/database_helper_list.dart';
import 'package:restaurant_app/data/db/database_helper_search.dart';
import 'package:restaurant_app/data/preferences/preference_helper.dart';
import 'package:restaurant_app/provider/database_provider_list.dart';
import 'package:restaurant_app/provider/database_provider_search.dart';
import 'package:restaurant_app/provider/preference_provider.dart';
import 'package:restaurant_app/ui/pages/details_restaurant.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/ui/bottombar/home.dart';
import 'package:restaurant_app/ui/bottombar/search.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/data/helpers/notification_helper.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final BackgroundService _service = BackgroundService();
  final NotificationHelper _helperNotification = NotificationHelper();

  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _helperNotification.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListProvider>(
          create: (context) => ListProvider(
            apiService: ApiService(Client()),
          ),
        ),
        ChangeNotifierProvider<DetailProvider>(
          create: (context) => DetailProvider(
            restaurantApiDetail: ApiService(Client()),
            id: '',
          ),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(
            apiServices: ApiService(Client()),
          ),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (context) => DatabaseProvider(
            databaseHelper: DatabaseHelperList(),
          ),
        ),
        ChangeNotifierProvider<DatabaseProviderSearch>(
          create: (context) => DatabaseProviderSearch(
            databaseHelper: DatabaseHelperSearch(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (context) => SchedulingProvider(),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, e) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant App',
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            navigatorKey: keyNavigation,
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              DetailRestaurant.routeName: (context) => DetailRestaurant(
                    id: ModalRoute.of(context)?.settings.arguments as String,
                  ),
              SearchPage.routeName: (context) => const SearchPage(),
            },
          );
        },
      ),
    );
  }
}