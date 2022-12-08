import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/database_helper_search.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProviderSearch extends ChangeNotifier {
  final DatabaseHelperSearch databaseHelper;

  DatabaseProviderSearch({required this.databaseHelper}) {
    _getFavorite();
  }

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  void _getFavorite() async {
    _favorite = (await databaseHelper.getFavorite()).cast<Restaurant>();
    if (_favorite.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Ups! No restaurants have been added to favorites yet';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant resto) async {
    try {
      await databaseHelper.addFavorite(resto);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedResto = await databaseHelper.getFavoriteById(id);
    return favoritedResto.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to Delete Data';
      notifyListeners();
    }
  }
}
