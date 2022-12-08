import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/ui/appbar/menu.dart';
import 'package:restaurant_app/ui/appbar/settings.dart';
import 'package:restaurant_app/ui/appbar/user.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/widgets/widget_card_restaurant_list.dart';
import 'package:restaurant_app/widgets/widget_platform.dart';

class ListRestaurants extends StatelessWidget {
  const ListRestaurants({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<ListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 220),
              child: Column(
                children: const [
                  CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Sedang memuat data\nmohon tunggu...',
                    textAlign: TextAlign.center,
                  ),
                ],
              ));
          // const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return Material(
            child: Column(
              children: [
                const NavbarListHomePage(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return CardRestaurantList(restaurant: restaurant);
                  },
                ),
              ],
            ),
          );
        } else if (state.state == ResultState.noData) {
          return Material(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 220.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.signal_cellular_connected_no_internet_4_bar,
                    size: 36.0,
                    color: Colors.yellow,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(state.message),
                ],
              ),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 220.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.signal_cellular_connected_no_internet_4_bar,
                      size: 36.0,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Connection Lost !\nPlease check your connection",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Material(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 220.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.error_rounded,
                      size: 36.0,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('Unknown Error !'),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Laporkan !'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: const Text('Restaurant', style: TextStyle(color: primaryColor)),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
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
            tooltip: 'Setting',
            color: primaryColor,
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
      body: SingleChildScrollView(
        child: _buildList(),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final Restaurant restaurant;
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

class NavbarListHomePage extends StatelessWidget {
  const NavbarListHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage(
              'https://d1ds1nqrpp2srf.cloudfront.net/photos/10110/cozy-9529-final72-jpg20121031-10847-106skhx_original.jpg?1515536089'),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              'Restaurant',
              style: TextStyle(fontSize: 40.0, color: Colors.white),
            ),
            Text(
              'Recommendation Restaurant For You',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
