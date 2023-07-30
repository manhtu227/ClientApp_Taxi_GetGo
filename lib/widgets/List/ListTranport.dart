import 'package:clientapp_taxi_getgo/models/CarType.dart';
import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/widgets/transport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class ListTransport extends StatefulWidget {
  const ListTransport({super.key});

  @override
  State<ListTransport> createState() => _ListTransportState();
}

class _ListTransportState extends State<ListTransport> {
  late List<CarTypeModel> CarType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CarType = context.read<CarTypeProvider>().listCar;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2.5;

    return Container(
      height: width * 0.75,
      width: MediaQuery.of(context).size.width - 10,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: CarType.map((e) => Transport(type: e)).toList()),
    );
  }
}
