import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

import 'package:http/http.dart' show Client;

class ApiService {
  final Client client;
  ApiService(this.client);

  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  // static const String _apiKey = '291b8efe981f4af290e0e3aa785ab9b9';
  // static const String _restaurantListApi = 'restaurants';
  // static const String _idList = 'id';
  static const String _detailUrl = 'detail/';
  static const String _searchUrl = 'search?q=';

  Future<RestaurantList> listApi() async {
    final response = await client.get(Uri.parse(
        // "${_baseUrl}list?restaurant=$_idList&restaurant-list-api=$_restaurantListApi&apiKey=$_apiKey"));
    "https://restaurant-api.dicoding.dev/list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant API');
    }
  }

  Future<RestaurantDetail> detailRestaurant(id) async {
    final response = await http.get(Uri.parse("$_baseUrl$_detailUrl$id"));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearch> searchRestaurant(query) async {
    final response = await http.get(Uri.parse("$_baseUrl$_searchUrl$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant search');
    }
  }
}
