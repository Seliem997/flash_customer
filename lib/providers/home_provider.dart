import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

      // Adding the markers to the list
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
/*

  Future addMarkerLongPressed(LatLng latlang) async {
    final MarkerId markerId = MarkerId("RANDOM_ID");
    Marker marker = Marker(
      markerId: markerId,
      draggable: true,
      position: latlang, //With this parameter you automatically obtain latitude and longitude
      infoWindow: InfoWindow(
        title: "Marker here",
        snippet: 'This looks good',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    markers[markerId] = marker;
    notifyListeners();
*/
/*
    //This is optional, it will zoom when the marker has been created
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(latlang, 17.0));*//*

  }
*/

  void resetMap() {
    markers.clear();
    polylineCoordinates = [];
    polylines = {};
    polylinePoints = null;
    _placeDistance = null;
    notifyListeners();
  }
}
