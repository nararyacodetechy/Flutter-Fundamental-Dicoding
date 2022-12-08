import 'dart:async';

import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/widget_network_disconnected.dart';
import 'package:restaurant_app/widgets/widget_card_restaurant_search_result.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({Key? key}) : super(key: key);
  static const String searchTitle = 'Search';

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  late TextEditingController textEditingController;
  late StreamSubscription<ConnectivityResult> subscription;

  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  Future<void> initConnectivity() async {
    late ConnectivityResult resultConnectivity;

    try {
      resultConnectivity = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log("Couldn't check connectivity status", error: e);
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(resultConnectivity);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    super.dispose();

    subscription.cancel();
    textEditingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    final SearchProvider restaurantSearchProvider =
        Provider.of<SearchProvider>(context, listen: false);

    textEditingController =
        TextEditingController(text: restaurantSearchProvider.query);

    subscription = Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        _connectionStatus = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus != ConnectivityResult.none) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          leading: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          title: Consumer<SearchProvider>(
            builder: (context, state, _) => TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                hintText: 'Search restaurant in here...',
                hintStyle: TextStyle(
                  color: Colors.white54,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.brown.shade100,
              onChanged: (value) {
                Provider.of<SearchProvider>(context, listen: false)
                    .restaurantSearch(value);
              },
            ),
          ),
          elevation: 2,
        ),
        body: Consumer<SearchProvider>(
          builder: (context, state, _) {
            if (state.states == ResultState.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              );
            } else if (state.states == ResultState.hasData) {
              return SingleChildScrollView(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.search.founded.toInt(),
                  itemBuilder: (context, index) {
                    final restaurantFounded = state.search.restaurants[index];
                    return SearchResultWidget(
                      restaurant: restaurantFounded,
                    );
                  },
                ),
              );
            } else if (state.states == ResultState.noData) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_rounded,
                        size: 36.0,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(state.messages),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('No restaurants found...'),
              );
            }
          },
        ),
      );
    } else {
      return const NetworkDisconnectedPage();
    }
  }
}
