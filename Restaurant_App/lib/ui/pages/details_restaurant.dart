import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DetailRestaurant extends StatefulWidget {
  static const routeName = '/details_restaurant';
  final String id;

  const DetailRestaurant({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<DetailProvider>(
      create: (context) => DetailProvider(
        restaurantApiDetail: ApiService(Client()),
        id: widget.id,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Details Restaurant',
              style: TextStyle(color: primaryColor)),
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
        body: Consumer<DetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 220.0),
                child: Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(
                        color: Colors.green,
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
                ),
              );
            } else if (state.state == ResultState.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Hero(
                      tag:
                          "https://restaurant-api.dicoding.dev/images/small/${state.detail.restaurant.pictureId}",
                      child: SizedBox(
                        height: 250,
                        width: size.width,
                        child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/small/${state.detail.restaurant.pictureId}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.detail.restaurant.name.toString(),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                            state.detail.restaurant.address
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                            state.detail.restaurant.rating
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0),
                            child: Divider(
                              color: Colors.grey,
                              height: 0,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Description',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Text(
                                state.detail.restaurant.description.toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.green),
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Text(
                                          'Foods Menu :',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.detail.restaurant.menus
                                            ?.foods.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.green),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.green,
                                                  ),
                                                  child: Text(state
                                                      .detail
                                                      .restaurant
                                                      .menus!
                                                      .foods[index]
                                                      .name
                                                      .toString()),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Text(
                                          'Drinks Menu :',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.detail.restaurant.menus
                                            ?.drinks.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.green),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.green,
                                                  ),
                                                  child: Text(state
                                                      .detail
                                                      .restaurant
                                                      .menus!
                                                      .drinks[index]
                                                      .name
                                                      .toString()),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                child: Text(state.message),
              );
            }
          },
        ),
      ),
    );
  }
}
