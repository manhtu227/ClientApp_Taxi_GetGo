import 'dart:async';
import 'dart:convert';
import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/services/googlemap/api_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late LatLng currentLocation;
  late LatLng desLocation;
  final List<LatLng> listDriver = [
    LatLng(10.7757, 106.7004),
    LatLng(10.7240, 106.7356),
    LatLng(10.7094, 106.7320),
    LatLng(10.7219, 106.7281),
  ];
  static const CameraPosition _kLake = CameraPosition(
    // bearing: 192.8334901395799,
    target: LatLng(10.728728, 106.718796),
    // tilt: 59.440717697143555,
    zoom: 16,
  );
  Map<String, Marker> _marker = {};
  Set<Polyline> _polylines = {};
  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    currentLocation =
        context.read<DirectionsViewModel>().currentLocation.coordinates;

    desLocation = context.read<DirectionsViewModel>().desLocation.coordinates;
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString('assets/jsons/map_style.json');
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    // Thêm dòng sau để lấy tọa độ từ polylinePoints của bạn
    List<LatLng> points =
        context.read<DirectionsViewModel>().polylinePoints.map((e) {
      return LatLng(e.latitude, e.longitude);
    }).toList();
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: currentLocation,
        zoom: 10,
      ),
      onMapCreated: (GoogleMapController controller) async {
        _controller.complete(controller);

        addMarker('test1', currentLocation);
        addMarker('test', desLocation);
        // addMarker('destination', destinationLocation);
        // addMarker('destination1', destinationLocation1);
        // _createPolylines(currentLocation, destinationLocation);
        // List<LatLng> nearbyPlaces = await DirectionsRepository()
        //     .calculateDistance(currentLocation, destinationLocation);
        // int i = 0;
        // for (LatLng x in nearbyPlaces) {
        //   addMarker('destination${i.toString()}', x);
        //   i++;
        // }
        // print('wwwwwwwwwwwwwwww');
        // print(nearbyPlaces[0]);
        // // destinationLocation1 = nearbyPlaces[0];
        // print(1111111111111);
        // print(DirectionsRepository.destinationLocation1!);
        // await _createPolylines(
        //     currentLocation, nearbyPlaces[0]);
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await Future.delayed(Duration(milliseconds: 500));
          await _setMapFitToTour(points);
        });
        // await _setMapFitToTour(points);
      },
      markers: _marker.values.toSet(),
      compassEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapToolbarEnabled: false,
      polylines: {
        if (context.read<DirectionsViewModel>().polylinePoints.isNotEmpty)
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Theme.of(context).primaryColor,
            width: 3,
            points: context.read<DirectionsViewModel>().polylinePoints.map((e) {
              return LatLng(e.latitude, e.longitude);
            }).toList(),
          ),
      },
    );
    // floatingActionButton: FloatingActionButton.extended(
    //   onPressed: _goToTheLake,
    //   label: const Text('To the lake!'),
    //   icon: const Icon(Icons.directions_boat),
    // ),
    // );
  }

  // Phương thức để điều chỉnh camera sao cho toàn bộ quãng đường nằm trong phạm vi hiển thị của bản đồ.
  // Phương thức để điều chỉnh camera sao cho toàn bộ quãng đường nằm trong phạm vi hiển thị của bản đồ.

  Future<void> _setMapFitToTour(List<LatLng> points) async {
    print(points);
    if (points.isEmpty) return;

    double minLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLat = points.first.latitude;
    double maxLng = points.first.longitude;

    points.forEach((point) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    });

    final GoogleMapController controller = await _controller.future;
    print('hehehhe222222222');
    print(LatLng(minLat, minLng));
    print(LatLng(maxLat, maxLng));
    controller.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      ),
      20,
    ));
    print('xonmg nè');
  }

  // Future<void> _createPolylines(LatLng start, LatLng destination) async {
  //   final directions = await APIPlace.getDirections(origin: start, destination: destination);
  //   print(destination);
  //   print('dasssssssssssssss');
  //   print(directions.polylinePoints);
  //   setState(() => _info = directions);
  // }

  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: 'End Point',
        snippet: 'End Marker',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    _marker[id] = marker;
    setState(() {});
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
