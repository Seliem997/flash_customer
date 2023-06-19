import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class HomeProvider with ChangeNotifier {
  String? _placeDistance;
  String? get placeDistance => _placeDistance;

  set placeDistance(String? value) {
    _placeDistance = value;
    notifyListeners();
  }

  Position? get currentPosition => _currentPosition;

  set currentPosition(Position? value) {
    _currentPosition = value;
    notifyListeners();
  }

  late GoogleMapController mapController;
  Position? _currentPosition;

  Set<Marker> markers = {};

  PolylinePoints? polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  Future<bool> startMarker() async {
    try {
      double startLatitude = _currentPosition!.latitude;
      double startLongitude = _currentPosition!.longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
          markerId: MarkerId(startCoordinatesString),
          position: LatLng(startLatitude, startLongitude),
          infoWindow: const InfoWindow(
            title: 'That\'s your Location',
            // snippet: _startAddress,
          ),
          icon: await BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue));

      markers.clear();
      polylineCoordinates = [];
      polylines = {};
      markers.add(startMarker);

      return true;
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return false;
  }

  Future addMarkerLongPressed(LatLng latlang) async {
    const MarkerId markerId = MarkerId("RANDOM_ID");
    Marker marker = Marker(
      markerId: markerId,
      draggable: true,
      position: latlang,
      //With this parameter you automatically obtain latitude and longitude
      infoWindow: const InfoWindow(
        title: "New Location",
        snippet: 'Marker here',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    currentPosition = Position(
      longitude: latlang.longitude,
      latitude: latlang.latitude,
      timestamp: currentPosition!.timestamp,
      accuracy: currentPosition!.accuracy,
      altitude: currentPosition!.altitude,
      heading: currentPosition!.heading,
      speed: currentPosition!.speed,
      speedAccuracy: currentPosition!.speedAccuracy,
    );


    markers.add(marker);
    print('Lat Lang $latlang');
    notifyListeners();
  }
  void resetMap() {
    // markers.clear();
    polylineCoordinates = [];
    polylines = {};
    polylinePoints = null;
    _placeDistance = null;
    notifyListeners();
  }

//-------------------------------------------- Launch Url -------
  launchExpectedURL({required String expectedUrl}) async {
    final Uri url = Uri.parse(expectedUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

}
