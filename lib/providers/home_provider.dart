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

  String _currentAddress = '';

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

  void resetMap() {
    markers.clear();
    polylineCoordinates = [];
    polylines = {};
    polylinePoints = null;
    _placeDistance = null;
    notifyListeners();
  }
}
