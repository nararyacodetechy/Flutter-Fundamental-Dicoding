import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import '../utils/result_state.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService restaurantApiDetail;
  // final String id;

  DetailProvider({
    required this.restaurantApiDetail,
    required String id,
  }) {
    _fetchAllRestaurantDetail(id);
  }

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetail get detail => _restaurantDetail;
  ResultState get state => _state;

  Future _fetchAllRestaurantDetail(id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await restaurantApiDetail.detailRestaurant(id);
      if (restaurant.restaurant.toJson().isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Tidak ada data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error => $e';
    }
  }
}
