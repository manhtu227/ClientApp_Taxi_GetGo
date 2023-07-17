import 'package:clientapp_taxi_getgo/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailDistance extends StatefulWidget {
  const DetailDistance({super.key});

  @override
  State<DetailDistance> createState() => _DetailDistanceState();
}

class _DetailDistanceState extends State<DetailDistance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [MapScreen(), Text('data')],
      ),
    );
  }
}
