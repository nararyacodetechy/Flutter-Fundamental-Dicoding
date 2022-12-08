import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/pages/details_restaurant.dart';
import 'package:restaurant_app/ui/pages/list_restaurant.dart';
import 'package:restaurant_app/ui/bottombar/search.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/ui/bottombar/favorite.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/data/helpers/notification_helper.dart';
import 'package:restaurant_app/widgets/widget_platform.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Home';

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<ListProvider>(
      create: (_) => ListProvider(apiService: ApiService(Client())),
      child: const ListRestaurants(),
    ),
    const SearchPage(),
    const FavoritePage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
      label: _headlineText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
      label: SearchPage.searchTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Platform.isIOS ? CupertinoIcons.square_favorites : Icons.favorite),
      label: FavoritePage.favoriteTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: secondaryColor,
        unselectedItemColor: primaryColor,
        selectedItemColor: primaryColor,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: secondaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailRestaurant.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
