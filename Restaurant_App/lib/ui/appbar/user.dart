import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: primaryColor,
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 125,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 125,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('https://pecb.com/conferences/wp-content/uploads/2017/10/no-profile-picture-300x216.jpg'),
                            child: Icon(Icons.edit),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Bagus Nararya Nanda Raditya',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Row(
                                children: const [
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.email,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child:Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'bagusnararya@gmail.com',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: const [
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'Temesi Gianyar, Bali',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 0,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                      child: Text(
                          'My Activities',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.list_alt),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Transaction List',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children:  [
                        const Icon(Icons.favorite_border),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Wishlist',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children:  [
                        const Icon(Icons.sentiment_very_satisfied),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Riview',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children:  [
                        const Icon(Icons.corporate_fare),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Restaurant Follows',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                      child: Text(
                        'All Category',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.card_travel),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Category',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.event_note),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Top Up and Billing',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.emoji_transportation),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Restaurant and Tour',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.outdoor_grill),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Halal Corner',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.local_atm),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Finance',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.more_horiz),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'More Services',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

