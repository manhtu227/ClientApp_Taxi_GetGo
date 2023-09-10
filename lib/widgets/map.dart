import 'dart:async';
import 'dart:math';
import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/sockets/socketService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:uuid/uuid.dart';

class MapScreen extends StatefulWidget {
  LocationModel currentLocation;
  LocationModel? desLocation;
  List<PointLatLng> listPoint;
  List<LatLng> listDrive;
  Function? pickup;
  String icon;
  MapScreen(
      {required this.currentLocation,
      required this.icon,
      this.desLocation,
      this.pickup,
      this.listPoint = const [],
      this.listDrive = const [],
      Key? key})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Timer? _timer;
  Map<String, Marker> _marker = {};
  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    context.read<SocketService>().socket?.on('get-location-driver', (data) {
      print('cout<< $data');
      print('cout<< ${data["directions"]}');
      if (context.read<TripsViewModel>().driverLocation.status == 'comming' &&
          mounted &&
          data["directions"] != '' &&
          data["directions"] != null) {
        context.read<TripsViewModel>().updateDriverLocation(
            LatLng(data['lat'] / 1, data['lng'] / 1),
            data['heading'] / 1 ?? 0,
            'comming');
        addMarkerPicture('current', LatLng(data['lat'] / 1, data['lng'] / 1),
            widget.icon, data['heading'] / 1);
        final directionsData = data["directions"];
        print(data["directions"] is String);
        if (directionsData != '' && directionsData is String) {
          widget.listPoint = PolylinePoints().decodePolyline(directionsData);
        }
        // context.read<DirectionsViewModel>().updatePolylines1(directionsData);
      }
    });
  }

  @override
  void dispose() {
    _controller.future.then((GoogleMapController controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString('assets/jsons/map_style.json');
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(style);
  }

  void getCurrentLocation() async {}
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: widget.currentLocation.coordinates,
            zoom: widget.pickup != null ? 16 : 14,
            bearing: 90.0,
          ),
          onMapCreated: onCreated,
          onCameraMove: (CameraPosition? position) {
            // Hủy timer nếu đã tồn tại
            if (_timer != null) {
              _timer!.cancel();
            }

            // Bắt đầu timer mới
            _timer = Timer(Duration(seconds: 2), () {
              if (widget.pickup != null && position != null) {
                widget.pickup!(position);
              }
            });
          },
          markers: _marker.values.toSet(),
          compassEnabled: false,
          zoomControlsEnabled: false,
          // myLocationEnabled: true,
          myLocationButtonEnabled: widget.desLocation != null ? true : false,
          polylines: {
            if (widget.listPoint.isNotEmpty)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Theme.of(context).primaryColor,
                width: 4,
                points: widget.listPoint.map((e) {
                  return LatLng(e.latitude, e.longitude);
                }).toList(),
              ),
          },
        ),
        Positioned(
          bottom: 45.0,
          right: 16.0,
          child: ElevatedButton(
            onPressed: () {
              if (widget.desLocation != null) {
                List<LatLng> points = widget.listPoint.map((e) {
                  return LatLng(e.latitude, e.longitude);
                }).toList();
                _setMapFitToTour(points);
              } else {
                _moveCameraToLocation(widget.currentLocation.coordinates);
              }
            },
            child: Icon(Icons.my_location),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(0), // Điều này sẽ loại bỏ padding tự động
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10), // Điều này tạo nút hình vuông
              ),
              minimumSize: Size(45, 45), // Kích thước tối thiểu của nút
            ),
          ),
        ),
      ],
    );
  }

  void onCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    addMarkerPicture('current', widget.currentLocation.coordinates, widget.icon,
        widget.currentLocation.heading);
    print('aaaaaaaaaaaaaaaaaaaaaa');
    for (LatLng point in widget.listDrive) {
      addMarkerPicture(const Uuid().v4(), point, 'assets/images/CarMap.png',
          Random().nextDouble() * 360 + 1);
    }
    if (widget.desLocation != null) addPolylineAndFitMap();
  }

  Future<void> addPolylineAndFitMap() async {
    addMarkerPicture('marker', widget.desLocation!.coordinates,
        'assets/images/DesDetail.png', 0);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<LatLng> points = widget.listPoint.map((e) {
        return LatLng(e.latitude, e.longitude);
      }).toList();
      await Future.delayed(Duration(milliseconds: 500));
      await _setMapFitToTour(points);
    });
  }

  Future<void> _setMapFitToTour(List<LatLng> points) async {
    if (points.isEmpty) return;
    final GoogleMapController controller = await _controller.future;
    double minLat =
        points.reduce((a, b) => a.latitude < b.latitude ? a : b).latitude;
    double maxLat =
        points.reduce((a, b) => a.latitude > b.latitude ? a : b).latitude;
    double minLng =
        points.reduce((a, b) => a.longitude < b.longitude ? a : b).longitude;
    double maxLng =
        points.reduce((a, b) => a.longitude > b.longitude ? a : b).longitude;

    controller.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      ),
      60,
    ));
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromSvgAsset(
    String assetName, [
    Size size = const Size(48, 48),
  ]) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

    double devicePixelRatio = ui.window.devicePixelRatio;
    int width = (size.width * devicePixelRatio).toInt();
    int height = (size.height * devicePixelRatio).toInt();

    final scaleFactor = math.min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = ui.PictureRecorder();

    ui.Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  void _moveCameraToLocation(LatLng location) async {
    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 15)));
  }

  Future<void> addMarkerPicture(
      String id, LatLng location, String assetName, double rotate) async {
    // BitmapDescriptor.fromAssetImage(configuration, assetName)
    if (mounted) {
      BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(100, 100)),
        assetName,
      ).then((icon) {
        var marker = Marker(
          markerId: MarkerId(id),
          position: location,
          infoWindow: const InfoWindow(
            title: 'End Point',
            snippet: 'End Marker',
          ),
          icon: icon,
          rotation: rotate,
        );
        _marker[id] = marker;
        setState(() {});
      });
    }
  }
  // Future<void> addMarker(
  //     String id, LatLng location, String assetName, double rotate) async {
  //   BitmapDescriptor svgIcon =
  //       await getBitmapDescriptorFromSvgAsset(assetName, const Size(40, 40));
  //   var marker = Marker(
  //     markerId: MarkerId(id),
  //     position: location,
  //     infoWindow: const InfoWindow(
  //       title: 'End Point',
  //       snippet: 'End Marker',
  //     ),
  //     icon: svgIcon,
  //     rotation: rotate,
  //   );
  //   _marker[id] = marker;
  //   setState(() {});
  // }
}
