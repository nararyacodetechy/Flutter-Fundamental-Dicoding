import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/utils/result_state.dart';


class SearchProvider extends ChangeNotifier {
  final ApiService apiServices;
  String query;

  SearchProvider({
    required this.apiServices,
    this.query = '',
  }) {
    _fetchsAllsRestaurant(query);
  }

  late RestaurantSearch _searchResults;
  late ResultState _states;
  String _messages = '';

  RestaurantSearch get search => _searchResults;
  ResultState? get states => _states;
  String get messages => _messages;

  restaurantSearch(String newValue) {
    query = newValue;
    _fetchsAllsRestaurant(query);
    notifyListeners();
  }

  Future<dynamic> _fetchsAllsRestaurant(value) async {
    try {
      _states = ResultState.loading;
      notifyListeners();
      final restaurantSearch = await apiServices.searchRestaurant(value);
      if (restaurantSearch.restaurants.isNotEmpty) {
        _states = ResultState.hasData;
        notifyListeners();
        return _searchResults = restaurantSearch;
      } else {
        _states = ResultState.noData;
        notifyListeners();
        return _messages = 'Restaurant not found!';
      }
    } catch (e) {
      _states = ResultState.error;
      notifyListeners();
      return _messages = 'Error => $e';
    }
  }
}
