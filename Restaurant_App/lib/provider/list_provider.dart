import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/utils/result_state.dart';

class ListProvider extends ChangeNotifier {
  final ApiService apiService;

  ListProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantList _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantList get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.listApi();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
