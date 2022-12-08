import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/provider/database_provider_search.dart';

class FavoriteButtonSearch extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteButtonSearch({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProviderSearch>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id!),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isFavorited
                    ? IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.removeFavorite(restaurant.id!),
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.addFavorite(restaurant),
                      ),
              ],
            );
          },
        );
      },
    );
  }
}
