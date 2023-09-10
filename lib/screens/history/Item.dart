import 'dart:convert';

import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/widgets/ButtonSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/IconText.dart';
import 'package:clientapp_taxi_getgo/widgets/PlaceStrip.dart';
import 'package:clientapp_taxi_getgo/widgets/SummaryDriver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class Item extends StatefulWidget {
  Map<String, dynamic> trip;
  Item({super.key, required this.trip});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    print('cout<<<<< ${widget.trip.toString()}');
    print('cout<<<<< ${widget.trip['start']}');
    print('cout<<<<< ${widget.trip['start'] is String}');
    Map<String, dynamic> startData = widget.trip['start'];
    Map<String, dynamic> endData = widget.trip['end'];
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              children: [
                if (widget.trip['driver'] != null)
                  SummaryDriver(
                      nameCar: widget.trip['driver']['driver_vehicle']['name'],
                      license_plate: widget.trip['driver']['driver_vehicle']
                          ['license_plate'],
                      avatar: widget.trip['driver']['avatar'],
                      rating: null,
                      name: widget.trip['driver']['name'],
                      status: widget.trip['status'] == "Done"
                          ? "Completed"
                          : widget.trip['status'] == "Cancelled"
                              ? "Cancelled"
                              : widget.trip['status']),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Divider(
                    thickness: 1,
                    height: 8,
                    color: Color(0xFFD5DDE0),
                  ),
                ),
                Visibility(
                  visible: _isExpanded,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconText(
                              icon: "km",
                              text: "${widget.trip['distance']} km",
                            ),
                            IconText(
                              icon: "clock",
                              text: "${widget.trip['duration']} mins",
                            ),
                            IconText(
                              icon: "money",
                              text: NumberFormat.currency(
                                      locale: 'vi_VN',
                                      symbol: '',
                                      decimalDigits: 0)
                                  .format(int.tryParse(widget.trip['price'])),
                            ),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Date & Time',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xa0000000),
                            ),
                          ),
                          Text(
                            DateFormat('MMM d, y | hh:mm a').format(
                                DateTime.parse(widget.trip['createdAt'])),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xa0000000),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          thickness: 1,
                          height: 8,
                          color: Color(0xFFD5DDE0),
                        ),
                      ),
                      PlaceStrip(
                          start: startData['place'], end: endData['place']),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          thickness: 1,
                          height: 8,
                          color: Color(0xFFD5DDE0),
                        ),
                      ),
                      if (widget.trip['status'] != 'Done' &&
                          widget.trip['status'] != 'Cancelled')
                        ButtonSizeL(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.detailTrip,
                                arguments: {
                                  'idTrip': widget.trip['id'],
                                });
                          },
                          name: "Xem chi tiết",
                          height: 40,
                        ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    icon: _isExpanded
                        ? Icon(Icons.keyboard_arrow_up)
                        : Icon(Icons.keyboard_arrow_down)),
              ],
            )),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
