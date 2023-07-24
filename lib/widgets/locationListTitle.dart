import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

class LocationListTitle extends StatelessWidget {
  LocationListTitle(
      {super.key, required this.locations, required this.onClick});
  List<Location> locations;
  Function onClick;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 250,
      child: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                visualDensity: VisualDensity.compact,
                contentPadding: EdgeInsets.only(left: 5),
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SvgPicture.asset(
                    'assets/svgs/titleLocation.svg',
                    width: 22,
                    height: 22,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    locations[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3e4958),
                    ),
                  ),
                ),
                subtitle: Text(
                  locations[index].summary,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff97adb6),
                  ),
                ),
                // Other properties of the location (if any)
                onTap: () {
                  // Handle on tap event here
                  onClick(locations[index]);
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 50.0),
                child: const Divider(
                  thickness: 1,
                  height: 8,
                  color: Color.fromARGB(140, 172, 170, 170),
                ),
              ),
            ],
          );
        },
      ),
    );
    ;
  }
}
