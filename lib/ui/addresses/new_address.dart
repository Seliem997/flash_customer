import 'dart:developer';

import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../providers/addresses_provider.dart';
import '../../providers/home_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/font_styles.dart';
import '../home/home_screen.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/data_loader.dart';
import '../widgets/navigate.dart';
import '../widgets/spaces.dart';
import 'location_dialog.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({Key? key, this.cameFromHomeScreen = false})
      : super(key: key);

  final bool cameFromHomeScreen;
  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  final CameraPosition _initialLocation =
      const CameraPosition(target: LatLng(0, 0));

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  String? _darkMapStyle;
  String? _lightMapStyle;

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
    _lightMapStyle = MyApp.themeMode(context) ? await rootBundle.loadString('assets/map_styles/dark.json') :
    await rootBundle.loadString('assets/map_styles/light.json');
    if(MyApp.themeMode(context)){
      AppLoader.showLoader(context);
      await Future.delayed(const Duration(seconds: 1));
      AppLoader.stopLoader();
    }
    _setMapStyle();
  }

  Future _setMapStyle() async {
    final HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);

    if (MyApp.themeMode(context)) {
      homeProvider.mapController.setMapStyle(_darkMapStyle);
      setState(() {});
    } else {
      homeProvider.mapController.setMapStyle(_lightMapStyle);
      setState(() {});
    }
  }

  void loadData() async {
    _loadMapStyles();
    final AddressesProvider addressesProvider =
        Provider.of<AddressesProvider>(context, listen: false);
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    widget.cameFromHomeScreen
        ? await addressesProvider
            .getAddresses()
            .then((value) => addressesProvider.setLoading(false))
        : null;
    addressesProvider.addressesDataList.forEach((element) async {
      await homeProvider.markers.add(Marker(
          markerId: MarkerId('startCoordinatesString'),
          position: LatLng(
              double.parse(element.latitude), double.parse(element.langitude)),
          infoWindow: InfoWindow(
            title: "${element.locationName}",
            // snippet: _startAddress,
          ),
          icon: await BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue)));
    });
    addressesProvider.setLoading(false);

    await _handleLocationPermission();
    await _getCurrentLocation();
  }

  _getCurrentLocation() async {
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    homeProvider.resetMap();
    try {
      AppLoader.showLoader(context);
      await Geolocator.getCurrentPosition().then((Position position) async {
        AppLoader.stopLoader();
        homeProvider.currentPosition = position;
        homeProvider.mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15.5,
            ),
          ),
        );
      }).catchError((e) {
        log("Error in accessing current location $e");
      });
    } catch (e) {
      log("Error in accessing current location $e");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S
              .of(context)
              .locationServicesAreDisabledPleaseEnableTheServices)));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).locationPermissionsAreDenied)));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S
              .of(context)
              .locationPermissionsArePermanentlyDeniedWeCannotRequestPermissions)));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    final AddressesProvider addressesProvider =
        Provider.of<AddressesProvider>(context);

    return Scaffold(
      body: addressesProvider.isLoading
          ? const DataLoader()
          : Stack(
              children: [
                GoogleMap(
                  markers: Set<Marker>.from(homeProvider.markers),
                  initialCameraPosition: _initialLocation,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  polylines: Set<Polyline>.of(homeProvider.polylines.values),

                  onLongPress: (latlang) {
                    homeProvider.addMarkerLongPressed(latlang);
                  },
                  onMapCreated: (GoogleMapController controller) {
                    homeProvider.mapController = controller;
                  },
                ),
                Column(
                  children: [
                    CustomAppBar(
                      title: S.of(context).myAddresses,
                      onTap: (){
                        setState(() {
                          homeProvider.markers.clear();
                        });
                        navigateAndFinish(context, const HomeScreen());
                      },
                      backgroundColor: MyApp.themeMode(context) ? AppColor.secondaryDarkColor.withOpacity(0.5) : Colors.transparent,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () async{
                              try {
                                AppLoader.showLoader(context);
                                await Geolocator.getCurrentPosition().then((Position position) async {
                                  AppLoader.stopLoader();
                                  homeProvider.mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(position.latitude, position.longitude),
                                        zoom: 15.5,
                                      ),
                                    ),
                                  );
                                  homeProvider.addMarkerLongPressed(
                                      LatLng(position.latitude, position.longitude));
                                }).catchError((e) {
                                  log("Error in accessing current location $e");
                                });
                              } catch (e) {
                                log("Error in catch accessing current location $e");
                              }
                            },
                            child: Padding(
                              padding: onlyEdgeInsets(end: 24),
                              child: CustomSizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(MyApp.themeMode(context) ? 'assets/images/locationSpotDark.png' : 'assets/images/locationSpot.png',),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: symmetricEdgeInsets(horizontal: 24),
                      child: DefaultButton(
                        text: S.of(context).saveLocation,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const LocationDialog();
                            },
                          );
                        },
                        fontWeight: MyFontWeight.bold,
                        fontSize: 21,
                        height: 48,
                        width: 345,
                      ),
                    ),
                    verticalSpace(50),
                  ],
                ),
              ],
            ),
    );
  }
}
