import 'package:clientapp_taxi_getgo/screens/history/Item.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  List<dynamic> trips;

  ListItem({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    print('cout<< ${trips.toString()}');
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: trips
            .map((e) => Item(
                  trip: e as Map<String, dynamic>,
                ))
            .toList(),
      ),
    );
  }
}
