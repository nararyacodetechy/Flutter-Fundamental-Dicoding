// ignore_for_file: no_duplicate_case_values, dead_code, unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider_list.dart';
import 'package:restaurant_app/provider/database_provider_search.dart';
import 'package:restaurant_app/ui/bottombar/home.dart';
import 'package:restaurant_app/ui/bottombar/search.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/ui/appbar/menu.dart';
import 'package:restaurant_app/ui/appbar/settings.dart';
import 'package:restaurant_app/ui/appbar/user.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/widgets/widget_card_restaurant_list.dart';
import 'package:restaurant_app/widgets/widget_card_restaurant_search_result.dart';
import 'package:restaurant_app/widgets/widget_platform.dart';

class FavoritePage extends StatelessWidget {
  static const String favoriteTitle = 'Favorites';

  const FavoritePage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(favoriteTitle, style: TextStyle(color: primaryColor)),
        backgroundColor: secondaryColor,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: primaryColor,
          tooltip: 'Menu',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const MenuPage();
                },
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            color: primaryColor,
            tooltip: 'Account',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const UserPage();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            color: primaryColor,
            tooltip: 'Setting',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<bool>(
        builder: (context, snapshot) {
          var isFavorited = snapshot.data ?? false;
          return isFavorited ? _buildList() : _buildSearch();
        },
      ),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              // return CardRestaurantList(restaurant: provider.favorite[index]);
              return CardRestaurantList(restaurant: provider.favorite[index]);
            },
          );
        } else {
          return Center(
            child: Material(
              child: Container(
                margin: const EdgeInsets.only(top: 70),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.black,
                        size: 70,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        provider.message,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 28, 44, 31)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SearchPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Let's Search Now",
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildSearch() {
    return Consumer<DatabaseProviderSearch>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              // return CardRestaurantList(restaurant: provider.favorite[index]);
              return SearchResultWidget(restaurant: provider.favorite[index]);
            },
          );
        } else {
          return Center(
            child: Material(
              child: Container(
                margin: const EdgeInsets.only(top: 70),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.black,
                        size: 70,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        provider.message,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 28, 44, 31)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomePage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Let's Search Now",
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(favoriteTitle),
      ),
      child: _buildList(),
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
