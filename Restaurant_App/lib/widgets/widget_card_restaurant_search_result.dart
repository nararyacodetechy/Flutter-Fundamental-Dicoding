import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider_search.dart';
import 'package:restaurant_app/ui/pages/details_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/widgets/widget_favorite_search.dart';

class SearchResultWidget extends StatelessWidget {
  final Restaurant restaurant;

  const SearchResultWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black12,
        margin: const EdgeInsets.all(2.0),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          leading: Hero(
            tag:
                "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId!}",
            child: SizedBox(
              width: 100,
              height: 80,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId!}",
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.blue,
                    );
                  }
                },
              ),
            ),
          ),
          title: Text(
            restaurant.name!,
            style: Theme.of(context).textTheme.headline6,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      restaurant.city!,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: FavoriteButtonSearch(restaurant: restaurant),
          onTap: () => Navigator.pushNamed(
            context,
            DetailRestaurant.routeName,
            arguments: restaurant.id,
          ),
        ),
      ),
    );
  }
}
