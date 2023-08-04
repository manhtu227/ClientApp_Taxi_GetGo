import 'package:clientapp_taxi_getgo/screens/history/Item.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Item(),
        ],
      ),
    );
  }
}
