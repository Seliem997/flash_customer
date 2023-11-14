import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeProvider with ChangeNotifier {

  Position? get currentPosition => _currentPosition;

  set currentPosition(Position? value) {
    _currentPosition = value;
    notifyListeners();
  }

  late GoogleMapController mapController;
  Position? _currentPosition;

  Set<Marker> markers = {};

  Map<PolylineId, Polyline> polylines = {};

  Future<bool> startMarker() async {
    try {
      double startLatitude = _currentPosition!.latitude;
      double startLongitude = _currentPosition!.longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
          markerId: MarkerId(startCoordinatesString),
          position: LatLng(startLatitude, startLongitude),
          icon: await BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue));

      markers.clear();
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
    polylines = {};
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
